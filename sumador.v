`timescale 1ns/100ps
module sumadortip(X,A,B,llevo,res);
	input A, B, X;
	output llevo, res;
	wire nX;
	AC11004 inv(X,nX);
	MUX muxres(A,B,X,nX,nX,X,1'b0,res);
	MUX muxllevo(A,B,1'b0,X,X,1'b1,1'b0,llevo);
endmodule

module sumadorinic(A,B,llevo,res);
	input A, B;
	output  llevo,res;
	wire nX;
	MUX muxllevo(A,B,1'b0,1'b0,1'b0,1'b1,1'b0,llevo);
	MUX muxres(A,B,1'b0,1'b1,1'b1,1'b0,1'b0,res);
endmodule

module sumadorfin(X,A,B,res);
	input X,A,B;
	output res;
	wire nX;
	AC11004 inv(X,nX);
	MUX muxres(A,B,X,nX,nX,X,1'b0,res);
endmodule
