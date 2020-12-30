module PE (clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe);
	input clock;
	input [7:0] R, s1, s2;	// from memory
	input s1s2mux, newDist;	// from control
	output [7:0] Accumulate, Rpipe;
	reg [7:0] Accumulate, AccumulateIn, difference, Rpipe;
	reg Carry;

	always @(posedge clock) Rpipe <= R;
	always @(posedge clock) Accumulate <= AccumulateIn;

	always@(R or s1 or s2 or s1s2mux or newDist or Accumulate)
  	begin
  		difference = R - s1s2mux ? s1 : s2;
		if (difference < 0) difference = 0 - difference;	// absolute subtraction
		{Carry,AccumulateIn} = Accumulate + difference;
		if(Carry == 1) AccumulateIn = 8'hff;	// saturated
		if(newDist == 1) AccumulateIn = difference;	// starting new Distortion calculation
	end
endmodule

module Comparator(clock, CompStart, PEout, PEready, vectorX, vectorY, BestDist,
                    motionX, motionY);
    input clock, CompStart;
    input [127:0] PEout;
    input [15:0] PEready;
    input [3:0] vectorX, vectorY;
    output reg [7:0] BestDist;
    output reg [3:0] motionX, motionY;
    reg [7:0] newDist;
    reg newBest;
    integer count;

    always @(posedge clock)
        if(CompStart == 0) BestDist <= 8'hff;
        else if(newBest == 1)
        begin
            BestDist <= newDist;
            motionX <= vectorX;
            motionY <= vectorY;
        end
            
    always @(PEready)
    begin
        for (count = 0; count < 16; count = count + 1)
        begin
            case (count)
                0: newDist = PEout[7:0];
                1: newDist = PEout[15:8];
                2: newDist = PEout[23:16];
                3: newDist = PEout[31:24];
                4: newDist = PEout[39:32];
                5: newDist = PEout[47:40];
                6: newDist = PEout[55:48];
                7: newDist = PEout[63:56];
                8: newDist = PEout[71:64];
                9: newDist = PEout[79:72];
                10: newDist = PEout[87:80];
                11: newDist = PEout[95:88];
                12: newDist = PEout[103:96];
                13: newDist = PEout[111:104];
                14: newDist = PEout[119:112];
                15: newDist = PEout[127:120];
            endcase
            if( (PEready == 0) || (CompStart == 0)) // no PE is ready
                newBest = 0; 
            else if (newDist < BestDist) 
                newBest = 1;
            else 
                newBest = 0;
        end
    end
endmodule  

module control (clock, start, S1S2mux, NewDist, CompStart, PEready, VectorX,
                VectorY, AddressR, AddressS1, AddressS2);
    input clock, start;
    output reg [15:0] S1S2mux, NewDist;
    output reg CompStart;
    output reg [15:0] PEready;
    output reg [3:0] VectorX,VectorY;
    output reg [7:0] AddressR;
    output reg [9:0] AddressS1,AddressS2;
    reg [12:0] count;
    reg completed;
    integer i;

    always@(posedge clock) begin
        if(start == 0) 
            count <= 0;
        else if (completed == 0) 
            count <= count + 1;
    end
    
    always@(count) 
    begin
        for (i = 0; i < 16; i = i + 1)
        begin
            NewDist[i] = (count[7:0] == 1);
            PEready[i] = (NewDist[i] && (count >= 256));
            S1S2mux[i] = (count[3:0] > i);
            CompStart = count >= 256;
        end
        AddressR = count[7:0];
        AddressS1 = (count[11:8] + count[7:4]) * 32 + count[3:0];
        AddressS2 = (count[11:8] + count[7:4]) * 16 + count[3:0];
        VectorX = count[3:0] - 7;
        VectorY = count[11:8] - 7;
        completed = (count == (16 * (256 + 1)));
    end
endmodule

// Motion Detector topmodule
module top(clock, start, R, S1, S2, AddressR, AddressS1, AddressS2, BestDist, motionX, motionY);
    // External Non-Memory I/O
    input clock;
    input start;
    output [7:0] BestDist;
    output [3:0] motionX, motionY;

    // Interfacing with external memory
    input [7:0] R, S1, S2;
    output [7:0] AddressR;
    output [9:0] AddressS1, AddressS2;

    // Internal I/O
    wire [3:0] VectorX, VectorY;
    wire [15:0] S1S2mux, newDist, PEready;
    wire CompStart;
    wire [127:0] Accumulate;
    wire [7:0] Rpipe, Rpipe0, Rpipe1, Rpipe2, Rpipe3, Rpipe4, Rpipe5, Rpipe6, Rpipe7, Rpipe8, Rpipe9, Rpipe10, Rpipe11, Rpipe12, Rpipe13, Rpipe14;

    PE pe0 (clock, R, S1, S2, S1S2mux[0], newDist[0], Accumulate[7:0], Rpipe0);
    PE pe1 (clock, Rpipe0, S1, S2, S1S2mux[1], newDist[1], Accumulate[15:8], Rpipe1);
    PE pe2 (clock, Rpipe1, S1, S2, S1S2mux[2], newDist[2], Accumulate[23:16], Rpipe2);
    PE pe3 (clock, Rpipe2, S1, S2, S1S2mux[3], newDist[3], Accumulate[31:24], Rpipe3);
    PE pe4 (clock, Rpipe3, S1, S2, S1S2mux[4], newDist[4], Accumulate[39:32], Rpipe4);
    PE pe5 (clock, Rpipe4, S1, S2, S1S2mux[5], newDist[5], Accumulate[47:40], Rpipe5);
    PE pe6 (clock, Rpipe5, S1, S2, S1S2mux[6], newDist[6], Accumulate[55:48], Rpipe6);
    PE pe7 (clock, Rpipe6, S1, S2, S1S2mux[7], newDist[7], Accumulate[63:56], Rpipe7);
    PE pe8 (clock, Rpipe7, S1, S2, S1S2mux[8], newDist[8], Accumulate[71:64], Rpipe8);
    PE pe9 (clock, Rpipe8, S1, S2, S1S2mux[9], newDist[9], Accumulate[79:72], Rpipe9);
    PE pe10 (clock, Rpipe9, S1, S2, S1S2mux[10], newDist[10], Accumulate[87:80], Rpipe10);
    PE pe11 (clock, Rpipe10, S1, S2, S1S2mux[11], newDist[11], Accumulate[95:88], Rpipe11);
    PE pe12 (clock, Rpipe11, S1, S2, S1S2mux[12], newDist[12], Accumulate[103:96], Rpipe12);
    PE pe13 (clock, Rpipe12, S1, S2, S1S2mux[13], newDist[13], Accumulate[111:104], Rpipe13);
    PE pe14 (clock, Rpipe13, S1, S2, S1S2mux[14], newDist[14], Accumulate[119:112], Rpipe14);
    PE pe15 (clock, Rpipe14, S1, S2, S1S2mux[15], newDist[15], Accumulate[127:120], Rpipe);

    control ctl_u(clock, start, S1S2mux, newDist, CompStart, PEready, VectorX, VectorY, AddressR, AddressS1, AddressS2);
    Comparator comp_u(clock, CompStart, Accumulate, PEready, VectorX, VectorY, BestDist, motionX, motionY);
endmodule

// Reference Block Memory
module ROM_R (clock, Rmem, AddressR, R);
    input clock;
    input reg [7:0] Rmem[255:0];
    input [7:0] AddressR;
    output reg [7:0] R;
    always @(posedge clock) 
        R <= Rmem[AddressR];
endmodule

// Search Block Memory
module ROM_S (clock, Smem, AddressS1, AddressS2, S1, S2);
    input clock;
    input reg [7:0] Smem[1023:0];
    input [9:0] AddressS1, AddressS2;
    output reg [7:0] S1, S2;
        
    always @(posedge clock) 
    begin
        S1 <= Smem[AddressS1];
        S2 <= Smem[AddressS2];
    end
endmodule

// Testbench
module top_tb;
    reg clock;
    reg start;
    reg [7:0] s_mem [1023:0];
    reg [7:0] r_mem [255:0];
    wire [7:0] BestDist;
    wire [3:0] motionX, motionY;
    wire [7:0] R, S1, S2;
    wire [7:0] AddressR;
    wire [9:0] AddressS1, AddressS2;

    always #10 clock <= ~clock;

    initial begin
        $readmemh("rmem_data.hex", r_mem);
        $readmemh("smem_data.hex", s_mem);

        clock = 0;
        start = 0;
        #100;

        $monitor("start: %b, AddressR: %2h, R: %2h, AddressS1: %2h, S1: %2h, AddressS2: %2h, S2: %2h\nBestDist: %2h, motionX: %h, motionY: %h", start, AddressR, R, AddressS1, S1, AddressS2, S2, BestDist, motionX, motionY);

        @(posedge clock);
        #1;
        start = 1;

        #12345;
        $finish;
    end

    top dut(clock, start, R, S1, S2, AddressR, AddressS1, AddressS2, BestDist, motionX, motionY);
    ROM_R rom_r(clock, r_mem, AddressR, R);
    ROM_S rom_s(clock, s_mem, AddressS1, AddressS2, S1, S2);
endmodule