module Adder(A, B, Carry_in, Carry_out, Result);
	input A, B, Carry_in;
	output Carry_out, Result;
	
	xor x1(half_sum, A, B);
	xor x2(Result, half_sum, Carry_in);
	
	and a1(s1, half_sum, Carry_in);
	and a2(s2, A, B);
	
	or o1(Carry_out, s1, s2);
endmodule
