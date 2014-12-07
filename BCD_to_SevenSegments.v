module BCD_to_SevenSegments(clock, A, Out);
	input [3:0] A;
	input clock;
	output [6:0] Out;
	
	reg [6:0] Out;
	
	always @(posedge clock) begin
		case (A)
			4'h0: Out <= 7'b0111111;
			4'h1: Out <= 7'b0000110;
			4'h2: Out <= 7'b1011011;
			4'h3: Out <= 7'b1001111;
			4'h4: Out <= 7'b1100110;
			4'h5: Out <= 7'b1101101;
			4'h6: Out <= 7'b1111101;
			4'h7: Out <= 7'b0000111;
			4'h8: Out <= 7'b1111111;
			4'h9: Out <= 7'b1100111;
			default: Out <= 7'b1000000;
		endcase
	end
endmodule
