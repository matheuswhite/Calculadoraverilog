module ALU1(A, B, Ainvert, Binvert, Carry_in, Operation, Less, Carry_out, Result);
	input A, B, Ainvert, Binvert, Carry_in, Less;
	input [1:0] Operation;
	output Carry_out, Result;
	
	wire wA, wB, Anot, Bnot;
	wire Rsum, Ror, Rand;
	
	not n1(Anot, A);
	not n2(Bnot, B);
	Mux2to1 m1(A, Anot, Ainvert, wA);
	Mux2to1 m2(B, Bnot, Binvert, wB);
	
	Adder sum1(wA, wB, Carry_in, Carry_out, Rsum);
	
	and and1(Rand, wA, wB);
	
	or or1(Ror, wA, wB);
	
	Mux4to1 m3(Rand, Ror, Rsum, Less, Operation, Result);
endmodule
