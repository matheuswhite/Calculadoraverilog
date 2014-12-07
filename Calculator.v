module Calculator(clock, Switchs, Enter, Clear, SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6, Leds);
	input [11:0] Switchs;
	input Enter, Clear, clock;
	output [7:0] SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6;
	output [5:0] Leds;
	
	`define IDLE 'b000
	`define WITH_A 'b001
	`define WITH_B 'b010
	`define RESULT 'b011
	`define ENTERPRESSED 'b100
	`define NONE 'b111
	
	reg [7:0] A, B, OUT;
	reg [3:0] Operation;
	reg [5:0] Leds;
	reg [2:0] state = `IDLE;
	reg [2:0] nextState;
	reg [7:0] SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6;
	reg blockEnter = 1'b0;
	reg blockClear = 1'b0;
	
	wire [7:0] wResult;
	wire wZero, wCarry_out, wOverflow;
	wire [3:0] wUnitsA, wTensA, wUnitB, wTensB, wUnitsResult, wTensResult;
	wire [1:0] wHundredsA, wHundredsB, wHundredsResult;
	wire [7:0] Display1, Display2, Display3, Display4, Display5, Display6;
	wire [1:0] wLedsA, wLedsB, wLedsResult;
	
	ALU8 a1(A, B, Operation, wCarry_out, wZero, wResult, wOverflow);
	
	Binary_to_BCD b1(A, wUnitsA, wTensA, wHundredsA);
	Binary_to_BCD b2(B, wUnitsB, wTensB, wHundredsB);
	Binary_to_BCD b3(wResult, wUnitsResult, wTensResult, wHundredsResult);
	
	DecoderDisplay d1(clock, 0, 0, 0, wUnitsA, wTensA, wHundredsA, Display1, Display2, wLedsA);
	DecoderDisplay d2(clock, 0, 0, 0, wUnitsB, wTensB, wHundredsB, Display3, Display4, wLedsB);
	DecoderDisplay d3(clock, wZero, wOverflow, wCarry_out, wUnitsResult, wTensResult, wHundredsResult, Display5, Display6, wLedsResult);
	
	always @(posedge clock) begin
		case (state)
			`IDLE: begin
				SSegments1 <= 0;
				SSegments2 <= 0;
				SSegments3 <= 0;
				SSegments4 <= 0;
				SSegments5 <= 0;
				SSegments6 <= 0; 
				Leds[5:0] <= 4'b000001;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `WITH_A;
				end
			end
			`WITH_A: begin
				SSegments1 <= Display1;
				SSegments2 <= Display2;
				Leds[5:0] <= 4'b000011;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `WITH_B;
				end
				else if(Clear) begin
					state <= `IDLE;
				end
			end
			`WITH_B: begin
				SSegments3 <= Display3;
				SSegments4 <= Display4;
				Leds[5:0] <= 4'b000111;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `RESULT;
				end
				else if(Clear) begin
					state <= `IDLE;
				end
			end
			`RESULT: begin
				SSegments5 <= Display5;
				SSegments6 <= Display6;
				Leds[3:0] <= 4'b1111;
				Leds[5:4] <= wLedsResult;
				
				if(Enter) begin
					state <= `ENTERPRESSED;
					nextState <= `WITH_A;
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
			default: begin
				A <= 0;
				B <= 0;
				Operation <= 0;
				
				SSegments1 <= 0;
				SSegments2 <= 0;
				SSegments3 <= 0;
				SSegments4 <= 0;
				SSegments5 <= 0;
				SSegments6 <= 0;
				Leds[5:0] <= 4'b000001;
				
				state <= `IDLE;
			end
		endcase
	end
endmodule
