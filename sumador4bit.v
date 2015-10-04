`timescale 1ns/100ps
/*
module test();
	wire [3:0] word1, word2, Y;
	sumador4bit a(word1,word2,Y);
	pruebasu b(word1,word2,Y);
endmodule*/
module sumador4bit(word1,word2,Y);
	input [3:0] word1, word2;
	output [3:0] Y;
	wire carry1,carry2,carry3;
	sumadorinic i(word1[0],word2[0],carry1,Y[0]);
	sumadortip t1(carry1,word1[1],word2[1],carry2,Y[1]);
	sumadortip t2(carry2,word1[2],word2[2],carry3,Y[2]);
	sumadorfin f(carry3,word1[3],word2[3],Y[3]);
endmodule
/*
module pruebasu(word1,word2,Y);
	input [3:0] Y;
	output reg [3:0] word1,word2;
	initial begin
		#20 word1= 4'b0000;
		#20 word2= 4'b1101;
		$monitor($time,,
			"word1 = %b word2 = %b Y = %b",
			word1,word2,Y);
	end
endmodule
*/
