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

    always @(posedge clock)
        if(CompStart == 0) BestDist<=8'hff;
        else if(newBest == 1)
        begin
            BestDist <= newDist;
            motionX <= vectorX;
            motionY <= vectorY;
        end
            
    always @(BestDist or PEready)
    begin
        case (PEready)
            1: newDist = PEout[7:0];
            2: newDist = PEout[15:8];
            4: newDist = PEout[23:16];
            8: newDist = PEout[31:24];
            16: newDist = PEout[39:32];
            32: newDist = PEout[47:40];
            64: newDist = PEout[55:48];
            128: newDist = PEout[63:56];
            256: newDist = PEout[71:64];
            512: newDist = PEout[79:72];
            1024: newDist = PEout[87:80];
            2048: newDist = PEout[95:88];
            4096: newDist = PEout[103:96];
            8192: newDist = PEout[111:104];
            16384: newDist = PEout[119:112];
            32768: newDist = PEout[127:120];
        endcase
        if( (|PEready == 0) || (CompStart == 0)) // no PE is ready
            newBest = 0; 
        else if (newDist < BestDist) 
            newBest = 1;
        else 
            newBest = 0;
    end
endmodule   

module comparator_tb;
    reg clock;
    reg CompStart;
    reg [127:0] PEout;
    reg [15:0] PEready;
    reg [3:0] vectorX, vectorY;
    reg pflag;
    wire [7:0] BestDist;
    wire [3:0] motionX, motionY;

    integer i;

    always #10 clock <= ~clock;

    task display_pe();  // displays a readable form of sample PE to console
    begin
        $display("PE0:  %2h", PEout[7:0]);
        $display("PE1:  %2h", PEout[15:8]);
        $display("PE2:  %2h", PEout[23:16]);
        $display("PE3:  %2h", PEout[31:24]);
        $display("PE4:  %2h", PEout[39:32]);
        $display("PE5:  %2h", PEout[47:40]);
        $display("PE6:  %2h", PEout[55:48]);
        $display("PE7:  %2h", PEout[63:56]);
        $display("PE8:  %2h", PEout[71:64]);
        $display("PE9:  %2h", PEout[79:72]);
        $display("PE10: %2h", PEout[87:80]);
        $display("PE11: %2h", PEout[95:88]);
        $display("PE12: %2h", PEout[103:96]);
        $display("PE13: %2h", PEout[111:104]);
        $display("PE14: %2h", PEout[119:112]);
        $display("PE15: %2h", PEout[127:120]);
    end
    endtask

    initial begin
        clock = 0;
        CompStart = 0;
        PEready = 1;
        vectorX = 0;
        vectorY = 0;
        #15;   // propagation
        $monitor("PEready: %16b, BestDist: %2h, motionx: %h, motiony: %h", PEready, BestDist, motionX, motionY);
        std::randomize(PEout);
        CompStart = 1;
        display_pe();
        for (i = 0; i < 16; i = i + 1)
        begin
            @(posedge clock);
            #10;
            PEready = PEready << 1; // cycles through individual PEs
        end
        $display("BestDist: %2h", BestDist);
        $finish;
    end
    
    Comparator dut(clock, CompStart, PEout, PEready, vectorX, vectorY, 
                    BestDist, motionX, motionY);
endmodule
