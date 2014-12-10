module OverflowDetection(A, B, Binvert, Carry_out, Sum, Overflow);
	input A, B, Sum, Carry_out, Binvert;
	output Overflow;
	
	wire SumNot, ANot, BNot, OpNot;
	wire s1, s2, s3, wResult;
	
	not n1(SumNot, Sum);
	not n2(ANot, A);
	not n3(BNot, B);

	and a1(s1, ANot, BNot, Sum);
	and a2(s2, A, B, SumNot);
	
	or o1(wResult, s1, s2);
	
	Mux2to1 m1(Carry_out, wResult, Binvert, Overflow);
endmodule
