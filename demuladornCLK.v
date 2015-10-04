`timescale 1ns/100ps
/*
module testbench;
	wire CLK, demnCLK;
	demulnCLK d(CLK,demnCLK);
	probador p(CLK,demnCLK);
endmodule
**/
module demulnCLK(CLK,demnCLK);//tiene un retraso total de 18+7
	input CLK;
	output demnCLK;
	wire nCLK,clk,nclk;
	AC11004 i(CLK,nCLK);
	AC11004 i1(nCLK,clk);
	AC11004 i2(clk,nclk);
	nanda n(CLK,nclk,demnCLK);
endmodule
/*
module probador(CLK,demnCLK);
	input demnCLK;
	output reg CLK;
	initial begin
		$dumpfile("demulador.vcd");
		$dumpvars;
		#200 CLK = 0;
		repeat(32) begin
			#200 CLK = ~CLK;
		end
	end
endmodule
*/
