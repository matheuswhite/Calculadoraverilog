module Calculator(clock, Switchs, Enter, Clear, SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6, Leds);
	input [11:0] Switchs;
	input Enter, Clear, clock;
	output [7:0] SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6;
	output [3:0] Leds;
	
	reg [7:0] A, B, OUT;
	reg [3:0] Operation;
	reg [1:0] state;
	
	wire wEnter, wClear, wZero, wCarry_out, wOverflow;
	wire [7:0] wResult;
	
	parameter reg_delay = 1'b1;
	parameter IDLE = 2'b00;
	parameter WITH_A = 2'b01;
	parameter WITH_B = 2'b10;
	parameter RESULT = 2'b11;
	
	ALU8(A, B, Operation, wCarry_out, wZero, wResult, wOverflow)
	
	always @(posedge Enter)
		wEnter <= #(reg_delay) 1;
	always @(posedge Clear)
		wClear <= #(reg_delay) 1;
	
	always @(posedge clock) begin
		case (state)
			IDLE: 
				if(wEnter) begin
					state <= #(reg_delay) WITH_A;
					wEnter <= #(reg_delay) 0;
				end
			WITH_A:
				if(wEnter) begin
					state <= #(reg_delay) WITH_B;
					wEnter <= #(reg_delay) 0;
				end
				if(wClear) begin
					state <= #(reg_delay) IDLE;
					wClear <= #(reg_delay) 0;
				end
			WITH_B:
				if(wEnter) begin
					state <= #(reg_delay) RESULT;
					wEnter <= #(reg_delay) 0;
				end
				if(wClear) begin
					state <= #(reg_delay) IDLE;
					wClear <= #(reg_delay) 0;
				end
			RESULT:
				if(wEnter) begin
					state <= #(reg_delay) WITH_A;
					wEnter <= #(reg_delay) 0;
				end
				if(wClear) begin
					state <= #(reg_delay) IDLE;
					wClear <= #(reg_delay) 0;
				end
			default: state <= #(reg_delay) IDLE;
		endcase
	end
	
	always @(state) begin
		if(state == IDLE) begin
			if(wEnter) begin
				A <= #(reg_delay) Switchs[7:0];
			end
		end
		if(state == WITH_A) begin
			if(wEnter) begin
				B <= #(reg_delay) Switchs[7:0];
			end
			if(wClear) begin
				A <= #(reg_delay) 0;
			end
		end
		if(state == WITH_B) begin
			if(wEnter) begin
				Operation <= #(reg_delay) Switchs[11:8];
			end
			if(wClear) begin
				A <= #(reg_delay) 0;
				B <= #(reg_delay) 0;
			end
		end
		if(state == RESULT) begin
			if(wEnter) begin
				Operation <= #(reg_delay) Switchs[11:8];
			end
			if(wClear) begin
				A <= #(reg_delay) 0;
				B <= #(reg_delay) 0;
				Operation <= #(reg_delay) 0;
			end
		end
	end
endmodule
