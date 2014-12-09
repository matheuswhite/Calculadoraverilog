module HolderB(clock, A, Sel, Out);
	input clock;
	input [7:0] A;
	input [2:0] Sel;
	output [7:0] Out;
	
	reg [7:0] Out;
	
	wire wSel, wSel2, SelNot3, SelNot1, SelNot2;
	
	not n1(SelNot3, Sel[2]);
	not n2(SelNot1, Sel[0]);
	not n3(SelNot2, Sel[1]);
	
	and a1(wSel, SelNot3, Sel[1], SelNot1);
	and a2(wSel2, Sel[2], SelNot2, SelNot1);
	
	always @(posedge clock) begin
		if(wSel)
			Out <= A;
		else if(wSel2)
			Out <= 0;
	end
endmodule