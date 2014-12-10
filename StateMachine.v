module StateMachine(clock, Switchs, Enter, Clear, ValueOut, Display, Leds, Zero, Carry_out, Overflow);
	input [11:0] Switchs;
	input Enter, Clear, clock;
	output [3:0] Leds;
	output [7:0] ValueOut;
	output [2:0] Display;
	output Zero, Carry_out, Overflow;
	
	`define IDLE 'b000
	`define WITH_A 'b001
	`define WITH_B 'b010
	`define RESULT 'b011
	`define ENTERPRESSED 'b100
	`define WITH_A_RESULT 'b101
	`define NONE 'b111
	
	`define DISPLAY_A 'b001
	`define DISPALY_B 'b010
	`define DISPLAY_RESULT 'b011
	`define CLEAR_ALL 'b100
	`define CLEAR_B_AND_RESULT 'b101
	
	reg [7:0] A, B = 8'b0, OUT;
	reg [3:0] Operation, Leds;
	reg [2:0] state = `IDLE;
	reg [2:0] nextState;
	reg [2:0] Display = 3'b000;
	reg [7:0] ValueOut;
	
	wire [7:0] wResult;
	
	ALU8 a1(A, B, Operation, Carry_out, Zero, wResult, Overflow);
	
	always @(posedge clock) begin
		case (state)
			`IDLE: begin
				Display <= 3'b100;
				ValueOut <= 0;
				Leds[3:0] <= 4'b0001;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `WITH_A;
				end
			end
			`WITH_A: begin
				Display <= 3'b001;
				ValueOut <= A;
				Leds[3:0] <= 4'b0011;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `WITH_B;
				end
				else if(Clear) begin
					state <= `IDLE;
				end
			end
			`WITH_B: begin
				Display <= 3'b010;
				ValueOut <= B;
				Leds[3:0] <= 4'b0111;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `RESULT;
				end
				else if(Clear) begin
					state <= `IDLE;
				end
			end
			`RESULT: begin
				Display <= 3'b011;
				ValueOut <= wResult;
				OUT <= wResult;
				Leds[3:0] <= 4'b1111;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `WITH_A_RESULT;
				end	
				else if(Clear) begin
					state <= `IDLE;
				end
			end
			`ENTERPRESSED : begin
				if(Enter)
					case (nextState)
						`IDLE: begin 
							A <= 0;
							B <= 0;
							Operation <= 0;
						end
						`WITH_A: A <= Switchs[7:0];
						`WITH_B: B <= Switchs[7:0];
						`RESULT: Operation <= Switchs[11:8];
						`WITH_A_RESULT: A <= OUT;
						default: begin
							A <= 0;
							B <= 0;
							Operation <= 0;
						end
					endcase
					
				if(Enter == 0) begin
					state <= nextState;
					nextState <= `NONE;
				end
			end
			`WITH_A_RESULT : begin
				Display <= 3'b101;
				ValueOut <= A;
				Leds[3:0] <= 4'b0011;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `WITH_B;
				end
				else if(Clear) begin
					state <= `IDLE;
				end
			end
			default: begin
				A <= 0;
				B <= 0;
				Operation <= 0;
				
				Display <= 3'b100;
				ValueOut <= 0;
				Leds[3:0] <= 4'b0001;
				
				state <= `IDLE;
			end
		endcase
	end
endmodule
