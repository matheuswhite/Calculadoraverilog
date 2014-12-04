module OverflowDetection(A, B, Sum, Overflow);
	input A, B, Sum;
	output Overflow;
	
	wire SumNot, ANot, BNot, s1, s2, s3;
	
	not n1(SumNot, Sum);
	not n2(ANot, A);
	not n3(BNot, B);

	and a1(s1, ANot, BNot, Sum);
	and a2(s2, A, B, SumNot);
	
	or o1(Overflow, s1, s2);
endmodule
