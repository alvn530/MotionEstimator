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
            PEready[i] = (NewDist[i] && !(count < 256));
            S1S2mux[i] = (count[3:0] > i);
            CompStart = (!(count < 256));
        end
        AddressR = count[7:0];
        AddressS1 = (count[11:8] + count[7:4]) * 32 + count[3:0];
        AddressS2 = (count[11:8] + count[7:4]) * 16 + count[3:0];
        VectorX = count[3:0] - 7;
        VectorY = (count[11:8]) - 7;
        completed = (count == (16 * (256 + 1)));
    end
endmodule

module control_tb;
    reg clock, start;
    wire [15:0] S1S2mux, NewDist;
    wire CompStart;
    wire [15:0] PEready;
    wire [3:0] VectorX,VectorY;
    wire [7:0] AddressR;
    wire [9:0] AddressS1,AddressS2;

    integer i;

    always #10 clock <= ~clock;

    initial begin
        clock = 0;
        start = 0;
        #20;
        start = 1;
        #87654;  // we just need to get to the point where compstart is first called
        $finish;
    end

    initial begin
        $monitor("NewDist: %4h, PEReady: %4h, S1S2Mux: %b, AddressR: %2h,\nAddressS1: %3h, AddressS2: %3h, CompStart: %b, VectorX: %h, VectorY: %h", NewDist, PEready, S1S2mux, AddressR, AddressS1, AddressS2, CompStart, VectorX, VectorY);
    end

    control dut(clock, start, S1S2mux, NewDist, CompStart, PEready, VectorX,
                VectorY, AddressR, AddressS1, AddressS2);
endmodule