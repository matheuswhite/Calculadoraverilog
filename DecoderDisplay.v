module DecoderDisplay(clock, Zero, Overflow, Carry_out, Units, Tens, Hundreds, Display1, Display2, Leds);
	input Zero, Overflow, Carry_out, clock;
	input [3:0] Units, Tens;
	input [1:0] Hundreds;
	output [7:0] Display1, Display2;
	output [1:0] Leds; //01 Overflow; 10 Carry_out;
	
	reg [6:0] rUnits, rTens;
	reg [1:0] rHundreds;
	reg [7:0] Display1 = 8'b0, Display2 = 8'b0;
	reg [1:0] Leds;
	
	wire [6:0] wUnits, wTens;
	
	BCD_to_SevenSegments b1(clock, Units, wUnits);
	BCD_to_SevenSegments b2(clock, Tens, wTens);
	
	always @(posedge clock) begin
		if(Zero) begin
			rUnits <= 8'b00111111;
			rTens  <= 8'b00111111;
			rHundreds <= 2'b00;
		end
		if(Overflow) begin
			Leds[0] <= 1'b1;
		end
		if(Carry_out) begin
			Leds[1] <= 1'b1;
		end
		case (Hundreds)
			2'b01: rHundreds <= 2'b01;
			2'b10: rHundreds <= 2'b11; 
			2'b00: rHundreds <= 2'b00;
			default: rHundreds <= 2'b00;
		endcase
		
		rUnits <= wUnits;
		rTens <= wTens;
		Display1 <= {rHundreds[0],rUnits};
		Display2 <= {rHundreds[1],rTens};
	end
endmodule
