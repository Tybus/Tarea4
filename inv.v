/* David Martinez Garcia
* B34019
* Escuela de Ingenieria Electrica
* Universidad de Costa Rica
* Circuitos Digitales II
*/
`timescale 1ns/100ps
module AC11004(A,OUT);
	input A;
	output reg OUT;
	always @(A) begin
		OUT = ~A;
	end
	specify 
		specparam tPLH = 6.1;
		specparam tPHL = 5.2;
		(A=> OUT) = (tPLH,tPHL);
	endspecify
endmodule

			
