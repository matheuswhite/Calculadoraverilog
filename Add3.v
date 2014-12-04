module Add3(in,out);
	input [3:0] in;
	output [3:0] out;
	reg [3:0] out;
	
	parameter reg_delay = 1;
	
	always @ (in) begin
		case (in)
			4'b0000: out <= #(reg_delay) 4'b0000;
			4'b0001: out <= #(reg_delay) 4'b0001;
			4'b0010: out <= #(reg_delay) 4'b0010;
			4'b0011: out <= #(reg_delay) 4'b0011;
			4'b0100: out <= #(reg_delay) 4'b0100;
			4'b0101: out <= #(reg_delay) 4'b1000;
			4'b0110: out <= #(reg_delay) 4'b1001;
			4'b0111: out <= #(reg_delay) 4'b1010;
			4'b1000: out <= #(reg_delay) 4'b1011;
			4'b1001: out <= #(reg_delay) 4'b1100;
			default: out <= #(reg_delay) 4'b0000;
		endcase
	end
endmodule
