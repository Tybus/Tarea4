`timescale 1ns/100ps
module retrasador(IN,OUT);
	input IN;
	output OUT;
	wire out1;
	AC11004 i(IN,out1);
	AC11004 i2(out1,OUT);
endmodule
