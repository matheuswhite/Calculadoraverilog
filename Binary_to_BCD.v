module Binary_to_BCD(A, Units, Tens, Hundreds);
	input [7:0] A;
	output [3:0] Units, Tens;
	output [1:0] Hundreds;
	
	wire [3:0] c1, c2, c3, c4, c5, c6, c7;
	wire [3:0] d1, d2, d3, d4, d5, d6, d7;
	
	assign d1 = {1'b0, A[7:5]};
	assign d2 = {c1[2:0], A[4]};
	assign d3 = {c2[2:0], A[3]};
	assign d4 = {c3[2:0], A[2]};
	assign d5 = {c4[2:0], A[1]};
	assign d6 = {1'b0, c1[3], c2[3], c3[3]};
	assign d7 = {c6[2:0], c4[3]};
	
	Add3 a1(d1,c1);
	Add3 a2(d2,c2);
	Add3 a3(d3,c3);
	Add3 a4(d4,c4);
	Add3 a5(d5,c5);
	Add3 a6(d6,c6);
	Add3 a7(d7,c7);
	
	assign Units = {c5[2:0], A[0]};
	assign Tens = {c7[2:0], c5[3]};
	assign Hundreds = {c6[3], c7[3]};
endmodule
