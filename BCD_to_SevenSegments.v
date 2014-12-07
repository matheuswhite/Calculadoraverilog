module BCD_to_SevenSegments(clock, A, Out);
	input [3:0] A;
	input clock;
	output [6:0] Out;
	
	reg [6:0] Out;
	
	always @(posedge clock) begin
		case (A)
			4'b0000: Out <= 7'b0111111;
			4'b0001: Out <= 7'b0000110;
			4'b0010: Out <= 7'b1011011;
			4'b0011: Out <= 7'b1001111;
			4'b0100: Out <= 7'b1100110;
			4'b0101: Out <= 7'b1101101;
			4'b0110: Out <= 7'b1111101;
			4'b0111: Out <= 7'b0000111;
			4'b1000: Out <= 7'b1111111;
			4'b1001: Out <= 7'b1100111;
			default: Out <= 7'b1000000;
		endcase
	end
endmodule
