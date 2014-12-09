module DecoderDisplay(clock, Zero, Overflow, Carry_out, Units, Tens, Hundreds, Display1, Display2, Leds);
	input Zero, Overflow, Carry_out, clock;
	input [3:0] Units, Tens;
	input [1:0] Hundreds;
	output [7:0] Display1, Display2;
	output [1:0] Leds; //01 Overflow; 10 Carry_out;

	reg [1:0] rHundreds;
	wire [7:0] Display1, Display2;
	reg [1:0] Leds;
	
	wire [6:0] wUnits, wTens;
	
	BCD_to_SevenSegments b1(clock, Units, wUnits);
	BCD_to_SevenSegments b2(clock, Tens, wTens);
	
	assign Display1 = {rHundreds[0],wUnits};
	assign Display2 = {rHundreds[1],wTens};
	
	always @(posedge clock) begin
		if(Overflow)
			Leds[0] <= 1'b1;
		else if(Overflow == 0)
			Leds[0] <= 1'b0;
		if(Carry_out)
			Leds[1] <= 1'b1;
		else if(Carry_out == 0)
			Leds[1] <= 1'b0;
		
		case (Hundreds)
			2'b01: rHundreds <= 2'b01;
			2'b10: rHundreds <= 2'b11; 
			2'b00: rHundreds <= 2'b00;
			default: rHundreds <= 2'b00;
		endcase
	end
endmodule
