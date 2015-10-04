`timescale 1ns/100ps
module testbenchcont; //Modulo Encargado de crear el ambiente necesario para correr la prueba.	
	wire CLK,ENB,RCO1;
	wire [1:0] MODO;
	wire [3:0] D,Q1;
	contadorbin uno (CLK,ENB,MODO,D,Q1,RCO1);
	testingModule t (CLK,ENB,MODO,D,Q1,RCO1);
endmodule
module contadorbin(CLK, ENB, MODO, D, Q, RCO);
	input CLK,ENB;
	input [1:0] MODO;
	input [3:0] D;
	output RCO;
	output [3:0] Q;
	wire demulCLK,nLOAD,nCTEN,MM,nRCO,RCO2,nCLK,nQ0,nQ1,nandq0q1,nandq0q1i,nandq2q3,nandbig,nnand;
	wire [3:0] preset,sumadop,sumado,sumadof;
	AC11004 inv(ENB,nCTEN);
	AC11004 inv2(CLK,nCLK);
	AC11004 inv3(Q[2],nQ0);
	AC11004 inv4(Q[3],nQ1);
	nanda nand1(nQ0,nQ1,nandq0q1);
	AC11004 nandi(nandq0q1,nandq0q1i);
	nanda nand2(Q[0],Q[1],nandq2q3);
	nanda nand3(nandq0q1i,nandq2q3,nandbig);
	AC11004 nandi2f(nandbig,nnand);
	MUX load(MODO[1],MODO[0],1'b1,1'b1,demulCLK,1'b0,1'b0,nLOAD); //Cambiar a nCLK
 //DnU es modo2.
	sumador4bit suma(Q,4'b1101,sumadop);
	retrasador ret(sumadop[0],sumadof[0]);
	retrasador ret2(sumadop[1],sumadof[1]);
	retrasador ret3(sumadop[2],sumadof[2]);
	retrasador ret4(sumadop[3],sumadof[3]);
	
	retrasador re(sumadof[0],sumado[0]);
	retrasador re2(sumadof[1],sumado[1]);
	retrasador re3(sumadof[2],sumado[2]);
	retrasador re4(sumadof[3],sumado[3]);

	demulnCLK clockr(CLK,demulCLK);
	MUX Aa(MODO[1],MODO[0],D[0],D[0],sumado[0],D[0],1'b0,preset[0]);//Cambiar indices del sumado y D
	MUX Bb(MODO[1],MODO[0],D[1],D[1],sumado[1],D[1],1'b0,preset[1]);
	MUX Cc(MODO[1],MODO[0],D[2],D[2],sumado[2],D[2],1'b0,preset[2]);
	MUX Dd(MODO[1],MODO[0],D[3],D[3],sumado[3],D[3],1'b0,preset[3]);
	MUX rco(MODO[1],MODO[0],MM,MM,nnand,1'b0,1'b0,RCO);
	
	CD74HCT191 cont(preset,MODO[0],nLOAD,nCTEN,CLK,MM,Q,nRCO);
endmodule

module testingModule(CLK,ENB,MODO,D,Q,RCO); //Se realizan las pruebas del #1 al #3
	output reg CLK,ENB;
	output reg [1:0] MODO;
	output reg [3:0] D;
	input RCO;
	input [3:0] Q;
	initial
		begin
			$dumpfile("probador.vcd");
			$dumpvars;
			$display ("Prueba 1");
			$monitor($time,,
			"CLK = %b ENB = %b MODO = %b D =%b Q =%b RCO = %b",
			CLK,ENB,MODO,D,Q,RCO);
			#200 CLK = 0;
			#200 MODO = 3; ENB =1;D=0;
			#200 CLK =~CLK;
			#200 CLK =~CLK; MODO =0;
			repeat(32) begin
				#100 CLK =~CLK;
			end
			$display ("Prueba 2");
			#200 CLK =0;
			#200 MODO =3; ENB =1; D=15;
			#200 CLK = ~CLK;
			#200 CLK = ~CLK; 
			#200 MODO=1;
			repeat(32) begin
				#100 CLK =~CLK;
			end
			$display ("Prueba 3");
			#2000 CLK =0;
			#2000 MODO = 3; ENB =1; D=15;
			#2000 CLK = ~CLK;
			#2000 CLK = ~CLK; 
			#2000 MODO =2;
			#2000 CLK = ~CLK;
			#2000 CLK = ~CLK;
			repeat(32) begin
				#2000 CLK = ~CLK;
			end
			$finish;	
		end
endmodule

