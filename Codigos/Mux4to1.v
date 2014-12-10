module Mux4to1(A, B, C, D, Sel, Result);
	input A, B, C, D;
	input [1:0] Sel;
	output Result;
	
	wire s1, s2;
	
	Mux2to1 m1(A, B, Sel[0], s1);
	Mux2to1 m2(C, D, Sel[0], s2);
	Mux2to1 m3(s1, s2, Sel[1], Result);
endmodule
