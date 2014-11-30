module Mux2to1(A, B, Sel, S);
	input A, B, Sel;
	output S;
	
	not n2(Sel_not, Sel);
	
	and a1(s1, A, Sel_not);
	and a2(s2, B, Sel);
	
	or o1(S, s1, s2);
endmodule
