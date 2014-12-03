module DecoderDisplay(clock, Zero, Overflow, Units, Tens, Hundreds, Display1, Display2);
	input Zero, Overflow, clock;
	input [3:0] Units, Tens;
	input [1:0] Hundreds;
	output [7:0] Display1, Display2;
	
	reg [6:0] rUnits, rTens;
	reg wHundreds1, wHundreds2;
	
	wire [6:0] wUnits, wTens;
	
	parameter reg_delay = 1;
	
	BCD_to_SevenSegments b1(Units, wUnits);
	BCD_to_SevenSegments b2(Tens, wTens);
	
	assign Display1 = {wHundreds1,rUnits};
	assign Display2 = {wHundreds2,rTens};
	assign wUnits = rUnits;
	assign wTens = rTens;
	
	always @(posedge clock) begin
		if(Zero) begin
			rUnits <= #(reg_delay) 8'b00000000;
			rTens <= #(reg_delay) 8'b00000000;
			wHundreds1 <= #(reg_delay) 1'b0;
			wHundreds2 <= #(reg_delay) 1'b0;
		end
		if(Overflow) begin
			rUnits <= #(reg_delay) 8'b11000000;
			rTens <= #(reg_delay) 8'b01000000;
			wHundreds1 <= #(reg_delay) 1'b0;
			wHundreds2 <= #(reg_delay) 1'b0;
		end
		else begin
			case (Hundreds)
				2'b01: wHundreds1 <= #(reg_delay) 1'b1;
				2'b10: begin
					wHundreds1 <= #(reg_delay) 1'b1;
					wHundreds2 <= #(reg_delay) 1'b1;
				end
				2'b00: begin
					wHundreds1 <= #(reg_delay) 1'b0;
					wHundreds2 <= #(reg_delay) 1'b0;
				end
				default: begin
					wHundreds1 <= #(reg_delay) 1'b0;
					wHundreds2 <= #(reg_delay) 1'b0;
				end
			endcase
		end
	end
endmodule
