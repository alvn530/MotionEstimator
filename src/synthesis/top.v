`include "pe.v"
`include "control.v"
`include "comparator.v"

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
    wire [127:0] PEOut;
    wire [7:0] Rpipe, Rpipe0, Rpipe1, Rpipe2, Rpipe3, Rpipe4, Rpipe5, Rpipe6, Rpipe7, Rpipe8, Rpipe9, Rpipe10, Rpipe11, Rpipe12, Rpipe13, Rpipe14;

    PE pe0 (clock, R, S1, S2, S1S2mux[0], newDist[0], PEOut[7:0], Rpipe0);
    PE pe1 (clock, Rpipe0, S1, S2, S1S2mux[1], newDist[1], PEOut[15:8], Rpipe1);
    PE pe2 (clock, Rpipe1, S1, S2, S1S2mux[2], newDist[2], PEOut[23:16], Rpipe2);
    PE pe3 (clock, Rpipe2, S1, S2, S1S2mux[3], newDist[3], PEOut[31:24], Rpipe3);
    PE pe4 (clock, Rpipe3, S1, S2, S1S2mux[4], newDist[4], PEOut[39:32], Rpipe4);
    PE pe5 (clock, Rpipe4, S1, S2, S1S2mux[5], newDist[5], PEOut[47:40], Rpipe5);
    PE pe6 (clock, Rpipe5, S1, S2, S1S2mux[6], newDist[6], PEOut[55:48], Rpipe6);
    PE pe7 (clock, Rpipe6, S1, S2, S1S2mux[7], newDist[7], PEOut[63:56], Rpipe7);
    PE pe8 (clock, Rpipe7, S1, S2, S1S2mux[8], newDist[8], PEOut[71:64], Rpipe8);
    PE pe9 (clock, Rpipe8, S1, S2, S1S2mux[9], newDist[9], PEOut[79:72], Rpipe9);
    PE pe10 (clock, Rpipe9, S1, S2, S1S2mux[10], newDist[10], PEOut[87:80], Rpipe10);
    PE pe11 (clock, Rpipe10, S1, S2, S1S2mux[11], newDist[11], PEOut[95:88], Rpipe11);
    PE pe12 (clock, Rpipe11, S1, S2, S1S2mux[12], newDist[12], PEOut[103:96], Rpipe12);
    PE pe13 (clock, Rpipe12, S1, S2, S1S2mux[13], newDist[13], PEOut[111:104], Rpipe13);
    PE pe14 (clock, Rpipe13, S1, S2, S1S2mux[14], newDist[14], PEOut[119:112], Rpipe14);
    PE pe15 (clock, Rpipe14, S1, S2, S1S2mux[15], newDist[15], PEOut[127:120], Rpipe);

    control ctl_u(clock, start, S1S2mux, newDist, CompStart, PEready, VectorX, VectorY, AddressR, AddressS1, AddressS2);
    Comparator comp_u(clock, CompStart, PEOut, PEready, VectorX, VectorY, BestDist, motionX, motionY);
endmodule