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