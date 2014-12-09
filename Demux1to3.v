module Demux1to3(In, Sel, A, B, C);
	input [7:0] In;
	input [2:0] Sel;
	output [7:0] A, B, C;
	
	wire SelNot1, SelNot2, SelNot3;
	
	not n1(SelNot1, Sel[0]);
	not n2(SelNot2, Sel[1]);
	not n3(SelNot3, Sel[2]);
	
	And8Bits a1(In, {SelNot1, SelNot2, Sel[2]}, A);
	And8Bits a2(In, {SelNot1, Sel[1], SelNot3}, B);
	And8Bits a3(In, {SelNot1, Sel[1], Sel[2]}, C);
endmodule
