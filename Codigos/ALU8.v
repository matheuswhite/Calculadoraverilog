module ALU8(A, B, Operation, Carry_out, Zero, Result, Overflow);
	input [7:0] A, B;
	input [3:0] Operation;
	output [7:0] Result;
	output Zero, Carry_out, Overflow;
	
	reg [7:0] Result;
	
	wire wSet;
	wire wCarry_out1, wCarry_out2, wCarry_out3, wCarry_out4, wCarry_out5, wCarry_out6, wCarry_out7;
	wire wZero1, wZero2, wZero3, wZero4, wZero5, wZero6, wZero7, wZero8, wZeroFinal;
	
	ALU1 alu1(A[0], B[0], Operation[3], Operation[2], Operation[2], Operation[1:0], wSet, wCarry_out1, wZero1);
	ALU1 alu2(A[1], B[1], Operation[3], Operation[2], wCarry_out1, Operation[1:0], 0, wCarry_out2, wZero2);
	ALU1 alu3(A[2], B[2], Operation[3], Operation[2], wCarry_out2, Operation[1:0], 0, wCarry_out3, wZero3);
	ALU1 alu4(A[3], B[3], Operation[3], Operation[2], wCarry_out3, Operation[1:0], 0, wCarry_out4, wZero4);
	ALU1 alu5(A[4], B[4], Operation[3], Operation[2], wCarry_out4, Operation[1:0], 0, wCarry_out5, wZero5);
	ALU1 alu6(A[5], B[5], Operation[3], Operation[2], wCarry_out5, Operation[1:0], 0, wCarry_out6, wZero6);
	ALU1 alu7(A[6], B[6], Operation[3], Operation[2], wCarry_out6, Operation[1:0], 0, wCarry_out7, wZero7);
	
	ALU1MSB alu8(A[7], B[7], Operation[3], Operation[2], wCarry_out7, Operation[1:0], 0, Carry_out, wZero8, wSet, Overflow);
	
	always @(A, B, Operation) begin
		Result[0] <=  wZero1;
		Result[1] <=  wZero2;
		Result[2] <=  wZero3;
		Result[3] <=  wZero4;
		Result[4] <=  wZero5;
		Result[5] <=  wZero6;
		Result[6] <=  wZero7;
		Result[7] <=  wZero8;
	end

	or(wZeroFinal, wZero1, wZero2, wZero3, wZero4, wZero5, wZero6, wZero7, wZero8);
	not(Zero, wZeroFinal);
endmodule
