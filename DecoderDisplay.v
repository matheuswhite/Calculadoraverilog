module DecoderDisplay(state, Zero, Overflow, Units, Tens, Hundreds, Display1, Display2);
	input Zero, Overflow;
	input [3:0] Units, Tens;
	input [1:0] Hundreds, state;
	output [7:0] Display1, Display2;
	
	reg [6:0] rUnits, rTens;
	reg [1:0] rHundreds;
	reg [7:0] Display1 = 8'b0, Display2 = 8'b0;
	
	wire [6:0] wUnits, wTens;
	
	parameter reg_delay = 1;
	
	BCD_to_SevenSegments b1(Units, wUnits);
	BCD_to_SevenSegments b2(Tens, wTens);
	
	always @(state) begin
		if(Zero) begin
			rUnits <= #(reg_delay) 8'b00000000;
			rTens <= #(reg_delay) 8'b00000000;
			rHundreds <= #(reg_delay) 2'b00;
		end
		if(Overflow) begin
			rUnits <= #(reg_delay) 8'b11000000;
			rTens <= #(reg_delay) 8'b01000000;
			rHundreds <= #(reg_delay) 2'b00;
		end
		case (Hundreds)
			2'b01: rHundreds <= #(reg_delay) 2'b01;
			2'b10: rHundreds <= #(reg_delay) 2'b11; 
			2'b00: rHundreds <= #(reg_delay) 2'b00;
			default: rHundreds <= #(reg_delay) 2'b00;
		endcase
		
		rUnits <= #(reg_delay) wUnits;
		rTens <= #(reg_delay) wTens;
		Display1 <= #(reg_delay) {rHundreds[0],rUnits};
		Display2 <= #(reg_delay) {rHundreds[1],rTens};
	end
endmodule
