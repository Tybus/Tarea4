/* David Martinez Garcia
* B34019
* Escuela de Ingenieria Electrica
* Universidad de Costa Rica
* Circuitos Digitales II
*/

`timescale 1ns/100ps
//SN74LS253
module MUX(B,A,C0,C1,C2,C3,nG,Y);
	input B,A,C0,C1,C2,C3,nG;
	output reg Y;
//	always@(B or A or C0 or C1 or C2 or C3 or nG) begin
	always@(*) begin
		if(nG)
			Y = 1'bz;
		else if(~B & ~A)
			Y = C0;
		else if(~B & A)
			Y = C1;
		else if(B & ~A)
			Y = C2;
		else if(B & A)
			Y = C3;
	end
/*
	specify
		specparam tPLHData = 6;
		specparam tPHLData = 6;
		specparam tPLHSelc = 11.5;
		specparam tPHLSelc = 12;
		specparam tPZH = 11;
		specparam tPZL = 12;
		specparam tPHZ = 6.5;
		specparam tPLZ = 10;
		
		(C0,C1,C2,C3 *> Y) =(tPLHData,tPHLData);
		(B,A *> Y) =(tPLHSelc,tPHLSelc);
		(nG => Y) = (0,0,tPLZ,tPZH,tPHZ,tPZL);
	endspecify
*/
endmodule
		


