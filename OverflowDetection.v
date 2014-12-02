module OverflowDetection(A, B, Sum, Overflow);
	input A, B, Sum;
	output Overflow;
	
	wire SumNot, s1, s2, s3;
	
	not n1(SumNot, Sum);
	and a1(s1, A, B, SumNot);
	
	xor x1(s2, A, B);
	and a2(s3, s2, Sum);
	
	or o1(Overflow, s1, s3);
endmodule
