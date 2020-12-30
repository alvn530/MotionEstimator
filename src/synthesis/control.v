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