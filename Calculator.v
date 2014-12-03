module Calculator(clock, Switchs, Enter, Clear, SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6, Leds);
	input [11:0] Switchs;
	input Enter, Clear, clock;
	output [7:0] SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6;
	output [3:0] Leds;
	
	reg [7:0] A, B, OUT;
	reg [3:0] Operation, Leds;
	reg [1:0] state = IDLE;
	reg [7:0] SSegments1, SSegments2, SSegments3, SSegments4, SSegments5, SSegments6;
	reg rEnter, rClear;
	reg [7:0] Temp;
	
	wire [7:0] wResult;
	wire wZero, wCarry_out, wOverflow;
	wire [3:0] wUnitsA, wTensA, wUnitB, wTensB, wUnitsResult, wTensResult;
	wire [1:0] wHundredsA, wHundredsB, wHundredsResult;
	wire [7:0] Display1, Display2, Display3, Display4, Display5, Display6;
	
	parameter reg_delay = 1'b1;
	parameter IDLE = 2'b00;
	parameter WITH_A = 2'b01;
	parameter WITH_B = 2'b10;
	parameter RESULT = 2'b11;
	
	assign wResult = Temp;
	
	ALU8 a1(A, B, Operation, wCarry_out, wZero, wResult, wOverflow);
	
	Binary_to_BCD b1(A, wUnitsA, wTensA, wHundredsA);
	Binary_to_BCD b2(B, wUnitsB, wTensB, wHundredsB);
	Binary_to_BCD b3(wResult, wUnitsResult, wTensResult, wHundredsResult);
	
	DecoderDisplay d1(clock, 0, 0, wUnitsA, wTensA, wHundredsA, Display1, Display2);
	DecoderDisplay d2(clock, 0, 0, wUnitsB, wTensB, wHundredsB, Display3, Display4);
	DecoderDisplay d3(clock, wZero, wOverflow, wUnitsResult, wTensResult, wHundredsResult, Display5, Display6);
	
	always @(posedge clock) begin
		if(Enter)
			rEnter <= #(reg_delay) 1'b1;
		if(Clear)
			rClear <= #(reg_delay) 1'b1;
		case (state)
			IDLE: 
				if(rEnter) begin
					state <= #(reg_delay) WITH_A;
					rEnter <= #(reg_delay) 1'b0;
					A <= #(reg_delay) Switchs[7:0];
				end
			WITH_A:
				if(rEnter) begin
					state <= #(reg_delay) WITH_B;
					rEnter <= #(reg_delay) 0;
					B <= #(reg_delay) Switchs[7:0];
				end
				else if(rClear) begin
					state <= #(reg_delay) IDLE;
					rClear <= #(reg_delay) 0;
					A <= #(reg_delay) 0;
				end
			WITH_B:
				if(rEnter) begin
					state <= #(reg_delay) RESULT;
					rEnter <= #(reg_delay) 0;
					Operation <= #(reg_delay) Switchs[11:8];
				end
				else if(rClear) begin
					state <= #(reg_delay) IDLE;
					rClear <= #(reg_delay) 0;
					A <= #(reg_delay) 0;
					B <= #(reg_delay) 0;
				end
			RESULT: begin
				if(rEnter) begin
					state <= #(reg_delay) WITH_A;
					rEnter <= #(reg_delay) 0;
					A <= #(reg_delay) wResult;
					B <= #(reg_delay) 0;
					Operation <= #(reg_delay) 0;
					Temp <= #(reg_delay) 0;
				end
				else if(rClear) begin
					state <= #(reg_delay) IDLE;
					rClear <= #(reg_delay) 0;
					A <= #(reg_delay) 0;
					B <= #(reg_delay) 0;
					Operation <= #(reg_delay) 0;
					Temp <= #(reg_delay) 0;
				end	
			end	
			default: begin 
				state <= #(reg_delay) IDLE;
			end
		endcase
	end
	
	
	always @(state) begin
		case(state)
			IDLE: begin
				SSegments1 <= #(reg_delay) 0;
				SSegments2 <= #(reg_delay) 0;
				SSegments3 <= #(reg_delay) 0;
				SSegments4 <= #(reg_delay) 0;
				SSegments5 <= #(reg_delay) 0;
				SSegments6 <= #(reg_delay) 0;
				
				Leds <= #(reg_delay) 4'b0001;
			end
			WITH_A: begin
				SSegments1 <= #(reg_delay) Display1;
				SSegments2 <= #(reg_delay) Display2;
				
				Leds <= #(reg_delay) 4'b0011;
			end
			WITH_B: begin
				SSegments3 <= #(reg_delay) Display3;
				SSegments4 <= #(reg_delay) Display4;
				
				Leds <= #(reg_delay) 4'b0111;
			end
			RESULT: begin
				SSegments1 <= #(reg_delay) Display5;
				SSegments2 <= #(reg_delay) Display6;
				
				Leds <= #(reg_delay) 4'b1111;
			end
			default: begin
				SSegments1 <= #(reg_delay) 0;
				SSegments2 <= #(reg_delay) 0;
				SSegments3 <= #(reg_delay) 0;
				SSegments4 <= #(reg_delay) 0;
				SSegments5 <= #(reg_delay) 0;
				SSegments6 <= #(reg_delay) 0;
				
				Leds <= #(reg_delay) 4'b0001;
			end
		endcase
	end
endmodule
