/* David Martinez Garcia
* B34019
* Escuela de Ingenieria Electrica
* Universidad de Costa Rica
* Circuitos Digitales II
*/
// 74AC110000
`timescale 1ns/100ps
module nanda(A,B,OUT);
	input A,B;
	output reg OUT;
	always @(A or B) begin

		if(A & B)

			OUT=0;

		else

			OUT=1;
	end

	specify
		/*
		specparam tPLH =7.2;
		specparam tPHL =5.8;
		*/
		specparam tPLH = 7.2;
		specparam tPHL = 5.8;
		
		(A, B *>OUT) =(tPLH, tPHL);

	endspecify
endmodule


		
