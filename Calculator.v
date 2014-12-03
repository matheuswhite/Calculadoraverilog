module Calculator(clock, Switchs, Enter, Clear, SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6, Leds);
	input [11:0] Switchs;
	input Enter, Clear, clock;
	output [7:0] SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6;
	output [3:0] Leds;
	
	reg [7:0] A, B, OUT;
	reg [3:0] Operation, Leds;
	reg [1:0] state = IDLE;
	reg [7:0] SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6;
	
	wire [7:0] wResult;
	wire wZero, wCarry_out, wOverflow;
	wire [3:0] wUnitsA, wTensA, wUnitB, wTensB, wUnitsResult, wTensResult;
	wire [1:0] wHundredsA, wHundredsB, wHundredsResult;
	wire [7:0] Display1, Display2, Display3, Display4, Display5, Display6;
	
	parameter IDLE = 2'b00;
	parameter WITH_A = 2'b01;
	parameter WITH_B = 2'b10;
	parameter RESULT = 2'b11;
	
	ALU8 a1(A, B, Operation, wCarry_out, wZero, wResult, wOverflow);
	
	Binary_to_BCD b1(A, wUnitsA, wTensA, wHundredsA);
	Binary_to_BCD b2(B, wUnitsB, wTensB, wHundredsB);
	Binary_to_BCD b3(wResult, wUnitsResult, wTensResult, wHundredsResult);
	
	DecoderDisplay d1(state, 0, 0, wUnitsA, wTensA, wHundredsA, Display1, Display2);
	DecoderDisplay d2(state, 0, 0, wUnitsB, wTensB, wHundredsB, Display3, Display4);
	DecoderDisplay d3(state, wZero, wOverflow, wUnitsResult, wTensResult, wHundredsResult, Display5, Display6);
	
	always @(posedge Enter, posedge Clear) begin
		case (state)
			IDLE:
			if(Enter) begin
				state <= WITH_A;
				A <= Switchs[7:0];
			end
			WITH_A:
			if(Enter) begin
				state <= WITH_B;
				B <= Switchs[7:0];
			end
			else if(Clear) begin
				state <= IDLE;
				A <= 0;
			end
			WITH_B:
			if(Enter) begin
				state <= RESULT;
				Operation <= Switchs[11:8];
			end
			else if(Clear) begin
				state <= IDLE;
				A <= 0;
				B <= 0;
			end
			RESULT:
			if(Enter) begin
				state <= WITH_A;
				A <= wResult;
				B <= 0;
				Operation <= 0;
			end	
			else if(Clear) begin
				state <= IDLE;
				A <= 0;
				B <= 0;
				Operation <= 0;
			end
			default: begin
				state <= IDLE;
				A <= 0;
				B <= 0;
				Operation <= 0;
			end
		endcase
	end
	
	always @(state) begin
		case(state)
			IDLE: begin
				SSegments1 <= 0;
				SSegments2 <= 0;
				SSegments3 <= 0;
				SSegments4 <= 0;
				SSegments5 <= 0;
				SSegments6 <= 0;
				
				Leds <= 4'b0001;
			end
			WITH_A: begin
				SSegments1 <= Display1;
				SSegments2 <= Display2;
				
				Leds <= 4'b0011;
			end
			WITH_B: begin
				SSegments3 <= Display3;
				SSegments4 <= Display4;
				
				Leds <= 4'b0111;
			end
			RESULT: begin
				SSegments1 <= Display5;
				SSegments2 <= Display6;
				
				Leds <= 4'b1111;
			end
			default: begin
				SSegments1 <= 0;
				SSegments2 <= 0;
				SSegments3 <= 0;
				SSegments4 <= 0;
				SSegments5 <= 0;
				SSegments6 <= 0;
				
				Leds <= 4'b0001;
			end
		endcase
	end
endmodule
