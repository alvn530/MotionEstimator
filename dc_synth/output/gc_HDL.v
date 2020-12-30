/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP4
// Date      : Thu Dec  3 11:27:57 2020
/////////////////////////////////////////////////////////////


module PE_15_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  INVX0_LVT U1 ( .A(B[0]), .Y(n1) );
  INVX1_LVT U2 ( .A(n1), .Y(n2) );
  XOR2X1_HVT U3 ( .A1(A[0]), .A2(n2), .Y(SUM[0]) );
  AND2X1_LVT U4 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_15 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_15_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  OR4X1_LVT U3 ( .A1(n21), .A2(n20), .A3(R[5]), .A4(n19), .Y(n4) );
  INVX0_HVT U4 ( .A(n4), .Y(n8) );
  MUX21X1_LVT U5 ( .A1(s1[1]), .A2(s2[1]), .S0(n7), .Y(difference[1]) );
  MUX21X1_LVT U7 ( .A1(s1[3]), .A2(s2[3]), .S0(n8), .Y(difference[3]) );
  MUX21X1_LVT U8 ( .A1(s1[0]), .A2(s2[0]), .S0(n9), .Y(difference[0]) );
  XOR2X1_LVT U9 ( .A1(s1s2mux), .A2(R[0]), .Y(n19) );
  MUX21X1_HVT U10 ( .A1(N36), .A2(difference[2]), .S0(n6), .Y(n23) );
  NBUFFX2_HVT U11 ( .A(n9), .Y(n2) );
  INVX0_LVT U12 ( .A(n4), .Y(n9) );
  AND2X1_HVT U13 ( .A1(Carry), .A2(n12), .Y(n11) );
  MUX21X1_LVT U14 ( .A1(N41), .A2(difference[7]), .S0(n6), .Y(n28) );
  AND2X1_LVT U15 ( .A1(Carry), .A2(n12), .Y(n3) );
  MUX21X1_HVT U16 ( .A1(N35), .A2(difference[1]), .S0(n5), .Y(n22) );
  INVX0_LVT U17 ( .A(n4), .Y(n7) );
  INVX0_HVT U18 ( .A(n12), .Y(n6) );
  OR2X1_LVT U19 ( .A1(n22), .A2(n3), .Y(AccumulateIn[1]) );
  OR2X1_LVT U20 ( .A1(n23), .A2(n10), .Y(AccumulateIn[2]) );
  INVX0_LVT U21 ( .A(n12), .Y(n5) );
  OR2X1_LVT U22 ( .A1(n29), .A2(n11), .Y(AccumulateIn[0]) );
  OR2X1_LVT U23 ( .A1(n28), .A2(n10), .Y(AccumulateIn[7]) );
  OR2X1_LVT U24 ( .A1(n27), .A2(n10), .Y(AccumulateIn[6]) );
  OR2X1_LVT U25 ( .A1(n26), .A2(n3), .Y(AccumulateIn[5]) );
  OR2X1_LVT U26 ( .A1(n25), .A2(n3), .Y(AccumulateIn[4]) );
  OR2X1_LVT U27 ( .A1(n24), .A2(n11), .Y(AccumulateIn[3]) );
  INVX0_LVT U28 ( .A(newDist), .Y(n12) );
  MUX21X1_HVT U29 ( .A1(N40), .A2(difference[6]), .S0(n5), .Y(n27) );
  MUX21X1_HVT U30 ( .A1(N39), .A2(difference[5]), .S0(n5), .Y(n26) );
  MUX21X1_HVT U31 ( .A1(N38), .A2(difference[4]), .S0(n6), .Y(n25) );
  MUX21X1_HVT U32 ( .A1(N37), .A2(difference[3]), .S0(n6), .Y(n24) );
  AND2X1_LVT U33 ( .A1(Carry), .A2(n12), .Y(n10) );
  MUX21X1_HVT U34 ( .A1(N34), .A2(difference[0]), .S0(n5), .Y(n29) );
  MUX21X1_HVT U35 ( .A1(s1[7]), .A2(s2[7]), .S0(n8), .Y(difference[7]) );
  MUX21X1_HVT U36 ( .A1(s1[6]), .A2(s2[6]), .S0(n2), .Y(difference[6]) );
  MUX21X1_HVT U37 ( .A1(s1[5]), .A2(s2[5]), .S0(n8), .Y(difference[5]) );
  MUX21X1_HVT U38 ( .A1(s1[4]), .A2(s2[4]), .S0(n2), .Y(difference[4]) );
  MUX21X1_HVT U39 ( .A1(s1[2]), .A2(s2[2]), .S0(n7), .Y(difference[2]) );
  INVX1_LVT U40 ( .A(R[4]), .Y(n16) );
  INVX1_LVT U41 ( .A(R[2]), .Y(n15) );
  INVX1_LVT U42 ( .A(R[7]), .Y(n14) );
  INVX1_LVT U43 ( .A(R[6]), .Y(n13) );
  NAND4X0_LVT U44 ( .A1(n16), .A2(n15), .A3(n14), .A4(n13), .Y(n21) );
  INVX1_LVT U45 ( .A(R[3]), .Y(n18) );
  INVX1_LVT U46 ( .A(R[1]), .Y(n17) );
  NAND2X0_LVT U47 ( .A1(n18), .A2(n17), .Y(n20) );
endmodule


module PE_14_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_14 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  PE_14_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  DFFSSRX1_HVT \Accumulate_reg[7]  ( .D(n36), .SETB(n29), .RSTB(1'b1), .CLK(
        clock), .Q(Accumulate[7]) );
  DFFSSRX1_LVT \Accumulate_reg[6]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[6]), .CLK(clock), .Q(Accumulate[6]) );
  DFFSSRX1_LVT \Accumulate_reg[5]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[5]), .CLK(clock), .Q(Accumulate[5]) );
  DFFSSRX1_LVT \Accumulate_reg[4]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[4]), .CLK(clock), .Q(Accumulate[4]) );
  DFFSSRX1_LVT \Accumulate_reg[3]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[3]), .CLK(clock), .Q(Accumulate[3]) );
  DFFSSRX1_LVT \Accumulate_reg[1]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[1]), .CLK(clock), .Q(Accumulate[1]) );
  DFFSSRX1_LVT \Accumulate_reg[2]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[2]), .CLK(clock), .Q(Accumulate[2]) );
  DFFSSRX1_LVT \Accumulate_reg[0]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[0]), .CLK(clock), .Q(Accumulate[0]) );
  AND2X1_LVT U3 ( .A1(Carry), .A2(n18), .Y(n4) );
  OR2X1_LVT U4 ( .A1(n37), .A2(n4), .Y(AccumulateIn[0]) );
  OR2X1_LVT U5 ( .A1(n31), .A2(n4), .Y(AccumulateIn[2]) );
  OR2X1_LVT U7 ( .A1(n30), .A2(n4), .Y(AccumulateIn[1]) );
  OR2X1_LVT U8 ( .A1(n32), .A2(n5), .Y(AccumulateIn[3]) );
  OR2X1_LVT U9 ( .A1(n33), .A2(n5), .Y(AccumulateIn[4]) );
  INVX1_LVT U10 ( .A(n34), .Y(n3) );
  OR2X1_LVT U11 ( .A1(n35), .A2(n5), .Y(AccumulateIn[6]) );
  NOR4X1_LVT U12 ( .A1(n27), .A2(n26), .A3(R[5]), .A4(n25), .Y(n2) );
  MUX21X1_HVT U13 ( .A1(N36), .A2(difference[2]), .S0(n15), .Y(n31) );
  MUX21X1_HVT U14 ( .A1(N37), .A2(difference[3]), .S0(n14), .Y(n32) );
  NAND2X0_HVT U15 ( .A1(n3), .A2(n29), .Y(AccumulateIn[5]) );
  XOR2X1_LVT U16 ( .A1(s1s2mux), .A2(R[0]), .Y(n25) );
  INVX0_LVT U17 ( .A(n29), .Y(n5) );
  INVX0_HVT U18 ( .A(n18), .Y(n15) );
  INVX0_HVT U19 ( .A(newDist), .Y(n18) );
  INVX0_HVT U28 ( .A(n18), .Y(n14) );
  NBUFFX2_HVT U29 ( .A(n28), .Y(n16) );
  NBUFFX2_LVT U30 ( .A(n28), .Y(n17) );
  MUX21X1_HVT U31 ( .A1(s1[7]), .A2(s2[7]), .S0(n16), .Y(difference[7]) );
  MUX21X1_HVT U32 ( .A1(s1[6]), .A2(s2[6]), .S0(n2), .Y(difference[6]) );
  MUX21X1_HVT U33 ( .A1(s1[5]), .A2(s2[5]), .S0(n16), .Y(difference[5]) );
  MUX21X1_HVT U34 ( .A1(s1[4]), .A2(s2[4]), .S0(n2), .Y(difference[4]) );
  MUX21X1_HVT U35 ( .A1(s1[3]), .A2(s2[3]), .S0(n16), .Y(difference[3]) );
  MUX21X1_LVT U36 ( .A1(s1[1]), .A2(s2[1]), .S0(n2), .Y(difference[1]) );
  MUX21X1_HVT U37 ( .A1(N35), .A2(difference[1]), .S0(n14), .Y(n30) );
  MUX21X1_HVT U38 ( .A1(s1[2]), .A2(s2[2]), .S0(n17), .Y(difference[2]) );
  INVX1_LVT U39 ( .A(R[4]), .Y(n22) );
  INVX1_LVT U40 ( .A(R[2]), .Y(n21) );
  INVX1_LVT U41 ( .A(R[7]), .Y(n20) );
  INVX1_LVT U42 ( .A(R[6]), .Y(n19) );
  NAND4X0_LVT U43 ( .A1(n22), .A2(n21), .A3(n20), .A4(n19), .Y(n27) );
  INVX1_LVT U44 ( .A(R[3]), .Y(n24) );
  INVX1_LVT U45 ( .A(R[1]), .Y(n23) );
  NAND2X0_LVT U46 ( .A1(n24), .A2(n23), .Y(n26) );
  NOR4X1_LVT U47 ( .A1(n27), .A2(n26), .A3(R[5]), .A4(n25), .Y(n28) );
  MUX21X1_LVT U48 ( .A1(s1[0]), .A2(s2[0]), .S0(n17), .Y(difference[0]) );
  NAND2X0_LVT U49 ( .A1(Carry), .A2(n18), .Y(n29) );
  MUX21X1_LVT U50 ( .A1(N38), .A2(difference[4]), .S0(n15), .Y(n33) );
  MUX21X1_LVT U51 ( .A1(N39), .A2(difference[5]), .S0(n14), .Y(n34) );
  MUX21X1_LVT U52 ( .A1(N40), .A2(difference[6]), .S0(n15), .Y(n35) );
  MUX21X1_LVT U53 ( .A1(N41), .A2(difference[7]), .S0(n14), .Y(n36) );
  MUX21X1_LVT U54 ( .A1(N34), .A2(difference[0]), .S0(n15), .Y(n37) );
endmodule


module PE_13_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(B[0]), .A2(A[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_13 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_13_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  XNOR2X1_LVT U3 ( .A1(s1s2mux), .A2(n6), .Y(n18) );
  INVX1_LVT U4 ( .A(R[0]), .Y(n6) );
  OR2X1_LVT U5 ( .A1(n22), .A2(n7), .Y(AccumulateIn[1]) );
  OR2X1_LVT U7 ( .A1(n26), .A2(n8), .Y(AccumulateIn[5]) );
  OR2X1_LVT U8 ( .A1(n27), .A2(n7), .Y(AccumulateIn[6]) );
  OR2X1_LVT U9 ( .A1(n28), .A2(n8), .Y(AccumulateIn[7]) );
  OR2X1_LVT U10 ( .A1(n29), .A2(n7), .Y(AccumulateIn[0]) );
  INVX1_LVT U11 ( .A(newDist), .Y(n11) );
  MUX21X1_LVT U12 ( .A1(s1[0]), .A2(s2[0]), .S0(n3), .Y(difference[0]) );
  NAND2X0_LVT U13 ( .A1(Carry), .A2(n11), .Y(n2) );
  NBUFFX2_LVT U14 ( .A(n21), .Y(n4) );
  MUX21X1_LVT U15 ( .A1(s1[3]), .A2(s2[3]), .S0(n5), .Y(difference[3]) );
  NOR4X1_LVT U16 ( .A1(n20), .A2(n19), .A3(R[5]), .A4(n18), .Y(n3) );
  NBUFFX2_HVT U17 ( .A(n21), .Y(n5) );
  MUX21X1_HVT U18 ( .A1(N36), .A2(difference[2]), .S0(n10), .Y(n23) );
  MUX21X1_LVT U19 ( .A1(s1[1]), .A2(s2[1]), .S0(n3), .Y(difference[1]) );
  MUX21X1_LVT U20 ( .A1(s1[2]), .A2(s2[2]), .S0(n4), .Y(difference[2]) );
  MUX21X1_HVT U21 ( .A1(N34), .A2(difference[0]), .S0(n10), .Y(n29) );
  INVX0_LVT U22 ( .A(n11), .Y(n10) );
  INVX1_LVT U23 ( .A(n11), .Y(n9) );
  OR2X1_LVT U24 ( .A1(n23), .A2(n8), .Y(AccumulateIn[2]) );
  OR2X1_LVT U25 ( .A1(n24), .A2(n7), .Y(AccumulateIn[3]) );
  OR2X1_LVT U26 ( .A1(n25), .A2(n8), .Y(AccumulateIn[4]) );
  INVX0_LVT U27 ( .A(n2), .Y(n7) );
  INVX0_LVT U28 ( .A(n2), .Y(n8) );
  MUX21X1_HVT U29 ( .A1(s1[7]), .A2(s2[7]), .S0(n4), .Y(difference[7]) );
  MUX21X1_HVT U30 ( .A1(s1[6]), .A2(s2[6]), .S0(n5), .Y(difference[6]) );
  MUX21X1_HVT U31 ( .A1(s1[5]), .A2(s2[5]), .S0(n4), .Y(difference[5]) );
  MUX21X1_HVT U32 ( .A1(s1[4]), .A2(s2[4]), .S0(n5), .Y(difference[4]) );
  INVX1_LVT U33 ( .A(R[4]), .Y(n15) );
  INVX1_LVT U34 ( .A(R[2]), .Y(n14) );
  INVX1_LVT U35 ( .A(R[7]), .Y(n13) );
  INVX1_LVT U36 ( .A(R[6]), .Y(n12) );
  NAND4X0_LVT U37 ( .A1(n15), .A2(n14), .A3(n13), .A4(n12), .Y(n20) );
  INVX1_LVT U38 ( .A(R[3]), .Y(n17) );
  INVX1_LVT U39 ( .A(R[1]), .Y(n16) );
  NAND2X0_LVT U40 ( .A1(n17), .A2(n16), .Y(n19) );
  NOR4X1_LVT U41 ( .A1(n20), .A2(n19), .A3(R[5]), .A4(n18), .Y(n21) );
  MUX21X1_LVT U42 ( .A1(N35), .A2(difference[1]), .S0(n9), .Y(n22) );
  MUX21X1_LVT U43 ( .A1(N37), .A2(difference[3]), .S0(n10), .Y(n24) );
  MUX21X1_LVT U44 ( .A1(N38), .A2(difference[4]), .S0(n10), .Y(n25) );
  MUX21X1_LVT U45 ( .A1(N39), .A2(difference[5]), .S0(n9), .Y(n26) );
  MUX21X1_LVT U46 ( .A1(N40), .A2(difference[6]), .S0(n9), .Y(n27) );
  MUX21X1_LVT U47 ( .A1(N41), .A2(difference[7]), .S0(n9), .Y(n28) );
endmodule


module PE_12_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_12 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  PE_12_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  DFFSSRX1_HVT \Accumulate_reg[7]  ( .D(n32), .SETB(n25), .RSTB(1'b1), .CLK(
        clock), .Q(Accumulate[7]) );
  DFFSSRX1_LVT \Accumulate_reg[6]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[6]), .CLK(clock), .Q(Accumulate[6]) );
  DFFSSRX1_LVT \Accumulate_reg[4]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[4]), .CLK(clock), .Q(Accumulate[4]) );
  DFFX1_HVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_HVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_HVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  DFFX1_HVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_HVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  NBUFFX2_LVT U3 ( .A(n5), .Y(n3) );
  OR3X1_LVT U4 ( .A1(n23), .A2(n22), .A3(R[5]), .Y(n2) );
  MUX21X1_LVT U5 ( .A1(N34), .A2(difference[0]), .S0(n9), .Y(n33) );
  INVX1_LVT U7 ( .A(n14), .Y(n9) );
  XOR2X1_LVT U8 ( .A1(R[0]), .A2(s1s2mux), .Y(n21) );
  NBUFFX2_LVT U9 ( .A(n5), .Y(n4) );
  AND2X1_LVT U10 ( .A1(Carry), .A2(n14), .Y(n5) );
  NAND2X0_LVT U11 ( .A1(n20), .A2(n19), .Y(n22) );
  NOR2X0_LVT U12 ( .A1(n21), .A2(n2), .Y(n11) );
  NBUFFX2_LVT U13 ( .A(n24), .Y(n13) );
  INVX0_HVT U14 ( .A(newDist), .Y(n14) );
  INVX0_HVT U15 ( .A(n14), .Y(n10) );
  NBUFFX2_HVT U16 ( .A(n24), .Y(n12) );
  NAND2X0_HVT U20 ( .A1(Carry), .A2(n14), .Y(n25) );
  INVX1_LVT U21 ( .A(R[4]), .Y(n18) );
  INVX1_LVT U22 ( .A(R[2]), .Y(n17) );
  INVX1_LVT U23 ( .A(R[7]), .Y(n16) );
  INVX1_LVT U24 ( .A(R[6]), .Y(n15) );
  NAND4X0_LVT U25 ( .A1(n18), .A2(n17), .A3(n16), .A4(n15), .Y(n23) );
  INVX1_LVT U26 ( .A(R[3]), .Y(n20) );
  INVX1_LVT U27 ( .A(R[1]), .Y(n19) );
  NOR4X1_LVT U28 ( .A1(n23), .A2(n22), .A3(R[5]), .A4(n21), .Y(n24) );
  MUX21X1_LVT U29 ( .A1(s1[7]), .A2(s2[7]), .S0(n12), .Y(difference[7]) );
  MUX21X1_LVT U30 ( .A1(s1[6]), .A2(s2[6]), .S0(n13), .Y(difference[6]) );
  MUX21X1_LVT U31 ( .A1(s1[5]), .A2(s2[5]), .S0(n12), .Y(difference[5]) );
  MUX21X1_LVT U32 ( .A1(s1[4]), .A2(s2[4]), .S0(n13), .Y(difference[4]) );
  MUX21X1_LVT U33 ( .A1(s1[3]), .A2(s2[3]), .S0(n12), .Y(difference[3]) );
  MUX21X1_LVT U34 ( .A1(s1[2]), .A2(s2[2]), .S0(n13), .Y(difference[2]) );
  MUX21X1_LVT U35 ( .A1(s1[1]), .A2(s2[1]), .S0(n11), .Y(difference[1]) );
  MUX21X1_LVT U36 ( .A1(s1[0]), .A2(s2[0]), .S0(n11), .Y(difference[0]) );
  MUX21X1_LVT U37 ( .A1(N35), .A2(difference[1]), .S0(n10), .Y(n26) );
  OR2X1_LVT U38 ( .A1(n26), .A2(n5), .Y(AccumulateIn[1]) );
  MUX21X1_LVT U39 ( .A1(N36), .A2(difference[2]), .S0(n10), .Y(n27) );
  OR2X1_LVT U40 ( .A1(n27), .A2(n4), .Y(AccumulateIn[2]) );
  MUX21X1_LVT U41 ( .A1(N37), .A2(difference[3]), .S0(n9), .Y(n28) );
  OR2X1_LVT U42 ( .A1(n28), .A2(n3), .Y(AccumulateIn[3]) );
  MUX21X1_LVT U43 ( .A1(N38), .A2(difference[4]), .S0(n10), .Y(n29) );
  OR2X1_LVT U44 ( .A1(n29), .A2(n4), .Y(AccumulateIn[4]) );
  MUX21X1_LVT U45 ( .A1(N39), .A2(difference[5]), .S0(n10), .Y(n30) );
  OR2X1_LVT U46 ( .A1(n30), .A2(n3), .Y(AccumulateIn[5]) );
  MUX21X1_LVT U47 ( .A1(N40), .A2(difference[6]), .S0(n9), .Y(n31) );
  OR2X1_LVT U48 ( .A1(n31), .A2(n4), .Y(AccumulateIn[6]) );
  MUX21X1_LVT U49 ( .A1(N41), .A2(difference[7]), .S0(n9), .Y(n32) );
  OR2X1_LVT U50 ( .A1(n33), .A2(n3), .Y(AccumulateIn[0]) );
endmodule


module PE_11_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_11 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_11_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  OR4X1_LVT U3 ( .A1(n22), .A2(n21), .A3(R[5]), .A4(n20), .Y(n6) );
  XOR2X1_LVT U4 ( .A1(R[0]), .A2(s1s2mux), .Y(n20) );
  MUX21X1_LVT U5 ( .A1(s1[0]), .A2(s2[0]), .S0(n7), .Y(difference[0]) );
  INVX0_LVT U7 ( .A(newDist), .Y(n13) );
  INVX1_LVT U8 ( .A(n6), .Y(n7) );
  INVX0_HVT U9 ( .A(n6), .Y(n9) );
  NBUFFX2_HVT U10 ( .A(n9), .Y(n2) );
  AND2X1_LVT U11 ( .A1(Carry), .A2(n13), .Y(n3) );
  AND2X1_LVT U12 ( .A1(Carry), .A2(n13), .Y(n4) );
  AND2X1_HVT U13 ( .A1(Carry), .A2(n13), .Y(n5) );
  INVX0_HVT U14 ( .A(n13), .Y(n12) );
  MUX21X1_HVT U15 ( .A1(N34), .A2(difference[0]), .S0(n12), .Y(n30) );
  OR2X1_LVT U16 ( .A1(n24), .A2(n5), .Y(AccumulateIn[2]) );
  OR2X1_LVT U17 ( .A1(n25), .A2(n4), .Y(AccumulateIn[3]) );
  OR2X1_LVT U18 ( .A1(n26), .A2(n3), .Y(AccumulateIn[4]) );
  OR2X1_LVT U19 ( .A1(n27), .A2(n4), .Y(AccumulateIn[5]) );
  OR2X1_LVT U20 ( .A1(n28), .A2(n3), .Y(AccumulateIn[6]) );
  OR2X1_LVT U21 ( .A1(n23), .A2(n4), .Y(AccumulateIn[1]) );
  INVX0_HVT U22 ( .A(n6), .Y(n8) );
  INVX0_HVT U23 ( .A(n13), .Y(n10) );
  INVX0_HVT U24 ( .A(n13), .Y(n11) );
  MUX21X1_HVT U25 ( .A1(s1[7]), .A2(s2[7]), .S0(n8), .Y(difference[7]) );
  MUX21X1_HVT U26 ( .A1(s1[6]), .A2(s2[6]), .S0(n2), .Y(difference[6]) );
  MUX21X1_HVT U27 ( .A1(s1[5]), .A2(s2[5]), .S0(n8), .Y(difference[5]) );
  MUX21X1_HVT U28 ( .A1(s1[4]), .A2(s2[4]), .S0(n2), .Y(difference[4]) );
  MUX21X1_HVT U29 ( .A1(s1[3]), .A2(s2[3]), .S0(n8), .Y(difference[3]) );
  MUX21X1_HVT U30 ( .A1(s1[2]), .A2(s2[2]), .S0(n7), .Y(difference[2]) );
  INVX1_LVT U31 ( .A(R[4]), .Y(n17) );
  INVX1_LVT U32 ( .A(R[2]), .Y(n16) );
  INVX1_LVT U33 ( .A(R[7]), .Y(n15) );
  INVX1_LVT U34 ( .A(R[6]), .Y(n14) );
  NAND4X0_LVT U35 ( .A1(n17), .A2(n16), .A3(n15), .A4(n14), .Y(n22) );
  INVX1_LVT U36 ( .A(R[3]), .Y(n19) );
  INVX1_LVT U37 ( .A(R[1]), .Y(n18) );
  NAND2X0_LVT U38 ( .A1(n19), .A2(n18), .Y(n21) );
  MUX21X1_LVT U39 ( .A1(s1[1]), .A2(s2[1]), .S0(n9), .Y(difference[1]) );
  MUX21X1_LVT U40 ( .A1(N35), .A2(difference[1]), .S0(n11), .Y(n23) );
  MUX21X1_LVT U41 ( .A1(N36), .A2(difference[2]), .S0(n12), .Y(n24) );
  MUX21X1_LVT U42 ( .A1(N37), .A2(difference[3]), .S0(n11), .Y(n25) );
  MUX21X1_LVT U43 ( .A1(N38), .A2(difference[4]), .S0(n10), .Y(n26) );
  MUX21X1_LVT U44 ( .A1(N39), .A2(difference[5]), .S0(n10), .Y(n27) );
  MUX21X1_LVT U45 ( .A1(N40), .A2(difference[6]), .S0(n10), .Y(n28) );
  MUX21X1_LVT U46 ( .A1(N41), .A2(difference[7]), .S0(n11), .Y(n29) );
  OR2X1_LVT U47 ( .A1(n29), .A2(n3), .Y(AccumulateIn[7]) );
  OR2X1_LVT U48 ( .A1(n30), .A2(n5), .Y(AccumulateIn[0]) );
endmodule


module PE_10_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_10 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_10_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  AND2X1_LVT U3 ( .A1(Carry), .A2(n10), .Y(n2) );
  AND2X1_HVT U4 ( .A1(Carry), .A2(n10), .Y(n3) );
  INVX1_LVT U5 ( .A(n10), .Y(n5) );
  INVX1_LVT U7 ( .A(n10), .Y(n4) );
  NBUFFX2_HVT U8 ( .A(n20), .Y(n7) );
  XOR2X1_LVT U9 ( .A1(R[0]), .A2(s1s2mux), .Y(n17) );
  INVX0_LVT U10 ( .A(newDist), .Y(n10) );
  NBUFFX2_LVT U11 ( .A(n20), .Y(n6) );
  NBUFFX2_HVT U12 ( .A(n20), .Y(n8) );
  AND2X1_LVT U13 ( .A1(Carry), .A2(n10), .Y(n9) );
  INVX1_LVT U14 ( .A(R[4]), .Y(n14) );
  INVX1_LVT U15 ( .A(R[2]), .Y(n13) );
  INVX1_LVT U16 ( .A(R[7]), .Y(n12) );
  INVX1_LVT U17 ( .A(R[6]), .Y(n11) );
  NAND4X0_LVT U18 ( .A1(n14), .A2(n13), .A3(n12), .A4(n11), .Y(n19) );
  INVX1_LVT U19 ( .A(R[3]), .Y(n16) );
  INVX1_LVT U20 ( .A(R[1]), .Y(n15) );
  NAND2X0_LVT U21 ( .A1(n16), .A2(n15), .Y(n18) );
  NOR4X1_LVT U22 ( .A1(n19), .A2(n18), .A3(R[5]), .A4(n17), .Y(n20) );
  MUX21X1_LVT U23 ( .A1(s1[7]), .A2(s2[7]), .S0(n7), .Y(difference[7]) );
  MUX21X1_LVT U24 ( .A1(s1[6]), .A2(s2[6]), .S0(n8), .Y(difference[6]) );
  MUX21X1_LVT U25 ( .A1(s1[5]), .A2(s2[5]), .S0(n7), .Y(difference[5]) );
  MUX21X1_LVT U26 ( .A1(s1[4]), .A2(s2[4]), .S0(n8), .Y(difference[4]) );
  MUX21X1_LVT U27 ( .A1(s1[3]), .A2(s2[3]), .S0(n7), .Y(difference[3]) );
  MUX21X1_LVT U28 ( .A1(s1[2]), .A2(s2[2]), .S0(n8), .Y(difference[2]) );
  MUX21X1_LVT U29 ( .A1(s1[1]), .A2(s2[1]), .S0(n6), .Y(difference[1]) );
  MUX21X1_LVT U30 ( .A1(s1[0]), .A2(s2[0]), .S0(n6), .Y(difference[0]) );
  MUX21X1_LVT U31 ( .A1(N35), .A2(difference[1]), .S0(n5), .Y(n21) );
  OR2X1_LVT U32 ( .A1(n21), .A2(n9), .Y(AccumulateIn[1]) );
  MUX21X1_LVT U33 ( .A1(N36), .A2(difference[2]), .S0(n5), .Y(n22) );
  OR2X1_LVT U34 ( .A1(n22), .A2(n9), .Y(AccumulateIn[2]) );
  MUX21X1_LVT U35 ( .A1(N37), .A2(difference[3]), .S0(n5), .Y(n23) );
  OR2X1_LVT U36 ( .A1(n23), .A2(n2), .Y(AccumulateIn[3]) );
  MUX21X1_LVT U37 ( .A1(N38), .A2(difference[4]), .S0(n4), .Y(n24) );
  OR2X1_LVT U38 ( .A1(n24), .A2(n3), .Y(AccumulateIn[4]) );
  MUX21X1_LVT U39 ( .A1(N39), .A2(difference[5]), .S0(n5), .Y(n25) );
  OR2X1_LVT U40 ( .A1(n25), .A2(n2), .Y(AccumulateIn[5]) );
  MUX21X1_LVT U41 ( .A1(N40), .A2(difference[6]), .S0(n4), .Y(n26) );
  OR2X1_LVT U42 ( .A1(n26), .A2(n3), .Y(AccumulateIn[6]) );
  MUX21X1_LVT U43 ( .A1(N41), .A2(difference[7]), .S0(n4), .Y(n27) );
  OR2X1_LVT U44 ( .A1(n27), .A2(n2), .Y(AccumulateIn[7]) );
  MUX21X1_LVT U45 ( .A1(N34), .A2(difference[0]), .S0(n4), .Y(n28) );
  OR2X1_LVT U46 ( .A1(n28), .A2(n9), .Y(AccumulateIn[0]) );
endmodule


module PE_9_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_9 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_9_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  XOR2X2_LVT U3 ( .A1(s1s2mux), .A2(n9), .Y(n8) );
  INVX0_LVT U4 ( .A(n11), .Y(n17) );
  OR2X1_LVT U5 ( .A1(n27), .A2(n13), .Y(AccumulateIn[3]) );
  OR2X1_LVT U7 ( .A1(n30), .A2(n13), .Y(AccumulateIn[6]) );
  AND4X1_LVT U8 ( .A1(n7), .A2(n2), .A3(n6), .A4(n8), .Y(n5) );
  INVX1_LVT U9 ( .A(R[0]), .Y(n9) );
  INVX1_LVT U10 ( .A(R[5]), .Y(n6) );
  AND4X1_LVT U11 ( .A1(n22), .A2(n21), .A3(n20), .A4(n19), .Y(n7) );
  OR2X1_LVT U12 ( .A1(n25), .A2(n12), .Y(AccumulateIn[1]) );
  OR2X1_LVT U13 ( .A1(n26), .A2(n12), .Y(AccumulateIn[2]) );
  OR2X1_LVT U14 ( .A1(n29), .A2(n12), .Y(AccumulateIn[5]) );
  OR2X1_LVT U15 ( .A1(n32), .A2(n12), .Y(AccumulateIn[0]) );
  INVX1_LVT U16 ( .A(n11), .Y(n16) );
  INVX0_LVT U17 ( .A(n10), .Y(n13) );
  AND2X1_LVT U18 ( .A1(n24), .A2(n23), .Y(n2) );
  NBUFFX2_LVT U19 ( .A(n5), .Y(n3) );
  MUX21X1_LVT U20 ( .A1(s1[3]), .A2(s2[3]), .S0(n17), .Y(difference[3]) );
  NBUFFX2_LVT U21 ( .A(n16), .Y(n4) );
  MUX21X1_HVT U22 ( .A1(N36), .A2(difference[2]), .S0(n15), .Y(n26) );
  MUX21X1_LVT U23 ( .A1(N41), .A2(difference[7]), .S0(n14), .Y(n31) );
  NAND4X0_LVT U24 ( .A1(n7), .A2(n2), .A3(n6), .A4(n8), .Y(n11) );
  MUX21X1_HVT U25 ( .A1(N35), .A2(difference[1]), .S0(n15), .Y(n25) );
  NAND2X0_LVT U26 ( .A1(Carry), .A2(n18), .Y(n10) );
  INVX0_LVT U27 ( .A(n18), .Y(n14) );
  INVX1_LVT U28 ( .A(n18), .Y(n15) );
  OR2X1_LVT U29 ( .A1(n31), .A2(n13), .Y(AccumulateIn[7]) );
  INVX0_LVT U30 ( .A(n10), .Y(n12) );
  INVX0_LVT U31 ( .A(newDist), .Y(n18) );
  OR2X1_LVT U32 ( .A1(n28), .A2(n13), .Y(AccumulateIn[4]) );
  MUX21X1_HVT U33 ( .A1(N40), .A2(difference[6]), .S0(n15), .Y(n30) );
  MUX21X1_HVT U34 ( .A1(N39), .A2(difference[5]), .S0(n15), .Y(n29) );
  MUX21X1_HVT U35 ( .A1(N38), .A2(difference[4]), .S0(n14), .Y(n28) );
  MUX21X1_HVT U36 ( .A1(N37), .A2(difference[3]), .S0(n14), .Y(n27) );
  MUX21X1_HVT U37 ( .A1(N34), .A2(difference[0]), .S0(n14), .Y(n32) );
  MUX21X1_HVT U38 ( .A1(s1[7]), .A2(s2[7]), .S0(n3), .Y(difference[7]) );
  MUX21X1_HVT U39 ( .A1(s1[6]), .A2(s2[6]), .S0(n17), .Y(difference[6]) );
  MUX21X1_HVT U40 ( .A1(s1[5]), .A2(s2[5]), .S0(n3), .Y(difference[5]) );
  MUX21X1_HVT U41 ( .A1(s1[4]), .A2(s2[4]), .S0(n17), .Y(difference[4]) );
  MUX21X1_HVT U42 ( .A1(s1[2]), .A2(s2[2]), .S0(n4), .Y(difference[2]) );
  INVX1_LVT U43 ( .A(R[4]), .Y(n22) );
  INVX1_LVT U44 ( .A(R[2]), .Y(n21) );
  INVX1_LVT U45 ( .A(R[7]), .Y(n20) );
  INVX1_LVT U46 ( .A(R[6]), .Y(n19) );
  INVX1_LVT U47 ( .A(R[3]), .Y(n24) );
  INVX1_LVT U48 ( .A(R[1]), .Y(n23) );
  MUX21X1_LVT U49 ( .A1(s1[1]), .A2(s2[1]), .S0(n5), .Y(difference[1]) );
  MUX21X1_LVT U50 ( .A1(s1[0]), .A2(s2[0]), .S0(n16), .Y(difference[0]) );
endmodule


module PE_8_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_8 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_8_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  MUX21X1_LVT U3 ( .A1(N34), .A2(difference[0]), .S0(n4), .Y(n28) );
  AND2X1_LVT U4 ( .A1(Carry), .A2(n10), .Y(n2) );
  INVX0_HVT U5 ( .A(newDist), .Y(n10) );
  INVX0_HVT U7 ( .A(n10), .Y(n4) );
  NBUFFX2_HVT U8 ( .A(n20), .Y(n6) );
  INVX0_LVT U9 ( .A(n10), .Y(n3) );
  NBUFFX2_LVT U10 ( .A(n20), .Y(n5) );
  NBUFFX2_HVT U11 ( .A(n20), .Y(n7) );
  NBUFFX2_HVT U12 ( .A(n2), .Y(n8) );
  NBUFFX2_HVT U13 ( .A(n2), .Y(n9) );
  XOR2X1_LVT U14 ( .A1(R[0]), .A2(s1s2mux), .Y(n17) );
  INVX1_LVT U15 ( .A(R[4]), .Y(n14) );
  INVX1_LVT U16 ( .A(R[2]), .Y(n13) );
  INVX1_LVT U17 ( .A(R[7]), .Y(n12) );
  INVX1_LVT U18 ( .A(R[6]), .Y(n11) );
  NAND4X0_LVT U19 ( .A1(n14), .A2(n13), .A3(n12), .A4(n11), .Y(n19) );
  INVX1_LVT U20 ( .A(R[3]), .Y(n16) );
  INVX1_LVT U21 ( .A(R[1]), .Y(n15) );
  NAND2X0_LVT U22 ( .A1(n16), .A2(n15), .Y(n18) );
  NOR4X1_LVT U23 ( .A1(n19), .A2(n18), .A3(R[5]), .A4(n17), .Y(n20) );
  MUX21X1_LVT U24 ( .A1(s1[7]), .A2(s2[7]), .S0(n6), .Y(difference[7]) );
  MUX21X1_LVT U25 ( .A1(s1[6]), .A2(s2[6]), .S0(n7), .Y(difference[6]) );
  MUX21X1_LVT U26 ( .A1(s1[5]), .A2(s2[5]), .S0(n6), .Y(difference[5]) );
  MUX21X1_LVT U27 ( .A1(s1[4]), .A2(s2[4]), .S0(n7), .Y(difference[4]) );
  MUX21X1_LVT U28 ( .A1(s1[3]), .A2(s2[3]), .S0(n6), .Y(difference[3]) );
  MUX21X1_LVT U29 ( .A1(s1[2]), .A2(s2[2]), .S0(n7), .Y(difference[2]) );
  MUX21X1_LVT U30 ( .A1(s1[1]), .A2(s2[1]), .S0(n5), .Y(difference[1]) );
  MUX21X1_LVT U31 ( .A1(s1[0]), .A2(s2[0]), .S0(n5), .Y(difference[0]) );
  MUX21X1_LVT U32 ( .A1(N35), .A2(difference[1]), .S0(n3), .Y(n21) );
  OR2X1_LVT U33 ( .A1(n21), .A2(n8), .Y(AccumulateIn[1]) );
  MUX21X1_LVT U34 ( .A1(N36), .A2(difference[2]), .S0(n4), .Y(n22) );
  OR2X1_LVT U35 ( .A1(n22), .A2(n8), .Y(AccumulateIn[2]) );
  MUX21X1_LVT U36 ( .A1(N37), .A2(difference[3]), .S0(n3), .Y(n23) );
  OR2X1_LVT U37 ( .A1(n23), .A2(n8), .Y(AccumulateIn[3]) );
  MUX21X1_LVT U38 ( .A1(N38), .A2(difference[4]), .S0(n4), .Y(n24) );
  OR2X1_LVT U39 ( .A1(n24), .A2(n8), .Y(AccumulateIn[4]) );
  MUX21X1_LVT U40 ( .A1(N39), .A2(difference[5]), .S0(n3), .Y(n25) );
  OR2X1_LVT U41 ( .A1(n25), .A2(n9), .Y(AccumulateIn[5]) );
  MUX21X1_LVT U42 ( .A1(N40), .A2(difference[6]), .S0(n4), .Y(n26) );
  OR2X1_LVT U43 ( .A1(n26), .A2(n9), .Y(AccumulateIn[6]) );
  MUX21X1_LVT U44 ( .A1(N41), .A2(difference[7]), .S0(n3), .Y(n27) );
  OR2X1_LVT U45 ( .A1(n27), .A2(n9), .Y(AccumulateIn[7]) );
  OR2X1_LVT U46 ( .A1(n28), .A2(n9), .Y(AccumulateIn[0]) );
endmodule


module PE_7_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  NBUFFX2_LVT U1 ( .A(B[0]), .Y(n1) );
  XOR2X1_HVT U2 ( .A1(A[0]), .A2(n1), .Y(SUM[0]) );
  AND2X1_LVT U3 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_7 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_7_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  MUX21X1_HVT U3 ( .A1(N34), .A2(difference[0]), .S0(n8), .Y(n30) );
  XNOR2X1_LVT U4 ( .A1(n3), .A2(s1s2mux), .Y(n19) );
  INVX1_LVT U5 ( .A(R[0]), .Y(n3) );
  OR2X1_LVT U7 ( .A1(n26), .A2(n4), .Y(AccumulateIn[4]) );
  INVX1_LVT U8 ( .A(newDist), .Y(n12) );
  MUX21X1_LVT U9 ( .A1(s1[0]), .A2(s2[0]), .S0(n2), .Y(difference[0]) );
  MUX21X1_HVT U10 ( .A1(N38), .A2(difference[4]), .S0(n9), .Y(n26) );
  MUX21X1_HVT U11 ( .A1(N39), .A2(difference[5]), .S0(n8), .Y(n27) );
  MUX21X1_HVT U12 ( .A1(N40), .A2(difference[6]), .S0(n8), .Y(n28) );
  AND2X1_HVT U13 ( .A1(Carry), .A2(n12), .Y(n4) );
  NBUFFX2_LVT U14 ( .A(n5), .Y(n10) );
  NOR4X0_LVT U15 ( .A1(n21), .A2(n19), .A3(R[5]), .A4(n20), .Y(n22) );
  NBUFFX2_LVT U16 ( .A(n22), .Y(n7) );
  NBUFFX2_LVT U17 ( .A(n22), .Y(n6) );
  NOR4X1_LVT U18 ( .A1(n21), .A2(n20), .A3(R[5]), .A4(n19), .Y(n2) );
  INVX1_LVT U19 ( .A(n12), .Y(n9) );
  INVX1_LVT U20 ( .A(n12), .Y(n8) );
  AND2X1_LVT U21 ( .A1(Carry), .A2(n12), .Y(n5) );
  OR2X1_LVT U22 ( .A1(n23), .A2(n10), .Y(AccumulateIn[1]) );
  OR2X1_LVT U23 ( .A1(n24), .A2(n10), .Y(AccumulateIn[2]) );
  OR2X1_LVT U24 ( .A1(n25), .A2(n10), .Y(AccumulateIn[3]) );
  OR2X1_LVT U25 ( .A1(n28), .A2(n4), .Y(AccumulateIn[6]) );
  OR2X1_LVT U26 ( .A1(n27), .A2(n11), .Y(AccumulateIn[5]) );
  OR2X1_LVT U27 ( .A1(n29), .A2(n11), .Y(AccumulateIn[7]) );
  OR2X1_LVT U28 ( .A1(n30), .A2(n4), .Y(AccumulateIn[0]) );
  NBUFFX2_HVT U29 ( .A(n5), .Y(n11) );
  MUX21X1_HVT U30 ( .A1(s1[7]), .A2(s2[7]), .S0(n2), .Y(difference[7]) );
  MUX21X1_HVT U31 ( .A1(s1[6]), .A2(s2[6]), .S0(n7), .Y(difference[6]) );
  MUX21X1_HVT U32 ( .A1(s1[5]), .A2(s2[5]), .S0(n7), .Y(difference[5]) );
  MUX21X1_HVT U33 ( .A1(s1[4]), .A2(s2[4]), .S0(n2), .Y(difference[4]) );
  MUX21X1_HVT U34 ( .A1(s1[3]), .A2(s2[3]), .S0(n7), .Y(difference[3]) );
  MUX21X1_HVT U35 ( .A1(s1[2]), .A2(s2[2]), .S0(n6), .Y(difference[2]) );
  INVX1_LVT U36 ( .A(R[4]), .Y(n16) );
  INVX1_LVT U37 ( .A(R[2]), .Y(n15) );
  INVX1_LVT U38 ( .A(R[7]), .Y(n14) );
  INVX1_LVT U39 ( .A(R[6]), .Y(n13) );
  NAND4X0_LVT U40 ( .A1(n16), .A2(n15), .A3(n14), .A4(n13), .Y(n21) );
  INVX1_LVT U41 ( .A(R[3]), .Y(n18) );
  INVX1_LVT U42 ( .A(R[1]), .Y(n17) );
  NAND2X0_LVT U43 ( .A1(n18), .A2(n17), .Y(n20) );
  MUX21X1_LVT U44 ( .A1(s1[1]), .A2(s2[1]), .S0(n6), .Y(difference[1]) );
  MUX21X1_LVT U45 ( .A1(N35), .A2(difference[1]), .S0(n9), .Y(n23) );
  MUX21X1_LVT U46 ( .A1(N36), .A2(difference[2]), .S0(n9), .Y(n24) );
  MUX21X1_LVT U47 ( .A1(N37), .A2(difference[3]), .S0(n9), .Y(n25) );
  MUX21X1_LVT U48 ( .A1(N41), .A2(difference[7]), .S0(n8), .Y(n29) );
endmodule


module PE_6_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(B[0]), .A2(A[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_6 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_6_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  MUX21X1_LVT U3 ( .A1(s1[1]), .A2(s2[1]), .S0(n5), .Y(difference[1]) );
  AND2X1_LVT U4 ( .A1(Carry), .A2(n10), .Y(n2) );
  XOR2X1_LVT U5 ( .A1(s1s2mux), .A2(R[0]), .Y(n17) );
  INVX1_LVT U7 ( .A(newDist), .Y(n10) );
  MUX21X1_HVT U8 ( .A1(N38), .A2(difference[4]), .S0(n7), .Y(n24) );
  MUX21X1_HVT U9 ( .A1(N39), .A2(difference[5]), .S0(n7), .Y(n25) );
  MUX21X1_HVT U10 ( .A1(N40), .A2(difference[6]), .S0(n7), .Y(n26) );
  MUX21X1_HVT U11 ( .A1(N41), .A2(difference[7]), .S0(n7), .Y(n27) );
  MUX21X1_HVT U12 ( .A1(N35), .A2(difference[1]), .S0(n8), .Y(n21) );
  NBUFFX2_LVT U13 ( .A(n20), .Y(n6) );
  NBUFFX2_LVT U14 ( .A(n20), .Y(n5) );
  MUX21X1_LVT U15 ( .A1(s1[0]), .A2(s2[0]), .S0(n6), .Y(difference[0]) );
  MUX21X1_HVT U16 ( .A1(N34), .A2(difference[0]), .S0(n8), .Y(n28) );
  AND2X1_LVT U17 ( .A1(Carry), .A2(n10), .Y(n3) );
  OR2X1_LVT U18 ( .A1(n21), .A2(n3), .Y(AccumulateIn[1]) );
  OR2X1_LVT U19 ( .A1(n22), .A2(n3), .Y(AccumulateIn[2]) );
  OR2X1_LVT U20 ( .A1(n23), .A2(n2), .Y(AccumulateIn[3]) );
  OR2X1_LVT U21 ( .A1(n24), .A2(n3), .Y(AccumulateIn[4]) );
  OR2X1_LVT U22 ( .A1(n25), .A2(n2), .Y(AccumulateIn[5]) );
  OR2X1_LVT U23 ( .A1(n26), .A2(n2), .Y(AccumulateIn[6]) );
  OR2X1_LVT U24 ( .A1(n27), .A2(n2), .Y(AccumulateIn[7]) );
  OR2X1_LVT U25 ( .A1(n28), .A2(n3), .Y(AccumulateIn[0]) );
  NBUFFX2_HVT U26 ( .A(n20), .Y(n4) );
  NBUFFX2_LVT U27 ( .A(n9), .Y(n7) );
  NBUFFX2_LVT U28 ( .A(n9), .Y(n8) );
  INVX0_LVT U29 ( .A(n10), .Y(n9) );
  MUX21X1_HVT U30 ( .A1(s1[7]), .A2(s2[7]), .S0(n4), .Y(difference[7]) );
  MUX21X1_HVT U31 ( .A1(s1[6]), .A2(s2[6]), .S0(n5), .Y(difference[6]) );
  MUX21X1_HVT U32 ( .A1(s1[5]), .A2(s2[5]), .S0(n4), .Y(difference[5]) );
  MUX21X1_HVT U33 ( .A1(s1[4]), .A2(s2[4]), .S0(n5), .Y(difference[4]) );
  MUX21X1_HVT U34 ( .A1(s1[3]), .A2(s2[3]), .S0(n4), .Y(difference[3]) );
  MUX21X1_HVT U35 ( .A1(s1[2]), .A2(s2[2]), .S0(n6), .Y(difference[2]) );
  INVX1_LVT U36 ( .A(R[4]), .Y(n14) );
  INVX1_LVT U37 ( .A(R[2]), .Y(n13) );
  INVX1_LVT U38 ( .A(R[7]), .Y(n12) );
  INVX1_LVT U39 ( .A(R[6]), .Y(n11) );
  NAND4X0_LVT U40 ( .A1(n14), .A2(n13), .A3(n12), .A4(n11), .Y(n19) );
  INVX1_LVT U41 ( .A(R[3]), .Y(n16) );
  INVX1_LVT U42 ( .A(R[1]), .Y(n15) );
  NAND2X0_LVT U43 ( .A1(n16), .A2(n15), .Y(n18) );
  NOR4X1_LVT U44 ( .A1(n19), .A2(n18), .A3(R[5]), .A4(n17), .Y(n20) );
  MUX21X1_LVT U45 ( .A1(N36), .A2(difference[2]), .S0(n8), .Y(n22) );
  MUX21X1_LVT U46 ( .A1(N37), .A2(difference[3]), .S0(n8), .Y(n23) );
endmodule


module PE_5_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(carry[1]), .CI(B[1]), .CO(carry[2]), .S(
        SUM[1]) );
  INVX1_LVT U1 ( .A(B[0]), .Y(n1) );
  INVX1_LVT U2 ( .A(n1), .Y(n2) );
  XOR2X1_HVT U3 ( .A1(A[0]), .A2(n2), .Y(SUM[0]) );
  AND2X1_LVT U4 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_5 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_5_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  MUX21X1_LVT U3 ( .A1(s1[0]), .A2(s2[0]), .S0(n16), .Y(difference[0]) );
  XOR2X1_LVT U4 ( .A1(s1s2mux), .A2(n10), .Y(n8) );
  INVX1_LVT U5 ( .A(R[0]), .Y(n10) );
  INVX1_LVT U7 ( .A(R[5]), .Y(n6) );
  AND4X1_LVT U8 ( .A1(n22), .A2(n21), .A3(n20), .A4(n19), .Y(n7) );
  INVX1_LVT U9 ( .A(n12), .Y(n17) );
  AND2X1_LVT U10 ( .A1(Carry), .A2(n18), .Y(n2) );
  AND2X1_LVT U11 ( .A1(n24), .A2(n23), .Y(n3) );
  AND4X1_LVT U12 ( .A1(n7), .A2(n3), .A3(n6), .A4(n8), .Y(n5) );
  INVX1_LVT U13 ( .A(n12), .Y(n16) );
  NBUFFX2_HVT U14 ( .A(n16), .Y(n4) );
  MUX21X1_LVT U15 ( .A1(s1[2]), .A2(s2[2]), .S0(n4), .Y(difference[2]) );
  MUX21X1_HVT U16 ( .A1(N36), .A2(difference[2]), .S0(n14), .Y(n26) );
  MUX21X1_HVT U17 ( .A1(N39), .A2(difference[5]), .S0(n15), .Y(n29) );
  MUX21X1_HVT U18 ( .A1(N37), .A2(difference[3]), .S0(n15), .Y(n27) );
  MUX21X1_LVT U19 ( .A1(s1[3]), .A2(s2[3]), .S0(n17), .Y(difference[3]) );
  NAND4X0_LVT U20 ( .A1(n8), .A2(n3), .A3(n6), .A4(n7), .Y(n12) );
  OR2X1_LVT U21 ( .A1(n26), .A2(n2), .Y(AccumulateIn[2]) );
  NBUFFX2_LVT U22 ( .A(n11), .Y(n9) );
  OR2X1_LVT U23 ( .A1(n30), .A2(n13), .Y(AccumulateIn[6]) );
  OR2X1_LVT U24 ( .A1(n31), .A2(n2), .Y(AccumulateIn[7]) );
  OR2X1_LVT U25 ( .A1(n32), .A2(n9), .Y(AccumulateIn[0]) );
  MUX21X1_HVT U26 ( .A1(N40), .A2(difference[6]), .S0(n14), .Y(n30) );
  OR2X1_LVT U27 ( .A1(n25), .A2(n9), .Y(AccumulateIn[1]) );
  OR2X1_LVT U28 ( .A1(n27), .A2(n2), .Y(AccumulateIn[3]) );
  OR2X1_LVT U29 ( .A1(n29), .A2(n9), .Y(AccumulateIn[5]) );
  INVX0_LVT U30 ( .A(n18), .Y(n14) );
  INVX0_LVT U31 ( .A(n18), .Y(n15) );
  INVX0_HVT U32 ( .A(newDist), .Y(n18) );
  AND2X1_LVT U33 ( .A1(Carry), .A2(n18), .Y(n11) );
  OR2X1_HVT U34 ( .A1(n28), .A2(n13), .Y(AccumulateIn[4]) );
  NBUFFX2_LVT U35 ( .A(n11), .Y(n13) );
  MUX21X1_HVT U36 ( .A1(N34), .A2(difference[0]), .S0(n15), .Y(n32) );
  MUX21X1_LVT U37 ( .A1(s1[1]), .A2(s2[1]), .S0(n5), .Y(difference[1]) );
  MUX21X1_HVT U38 ( .A1(s1[7]), .A2(s2[7]), .S0(n17), .Y(difference[7]) );
  MUX21X1_HVT U39 ( .A1(s1[6]), .A2(s2[6]), .S0(n5), .Y(difference[6]) );
  MUX21X1_HVT U40 ( .A1(s1[5]), .A2(s2[5]), .S0(n17), .Y(difference[5]) );
  MUX21X1_HVT U41 ( .A1(s1[4]), .A2(s2[4]), .S0(n5), .Y(difference[4]) );
  INVX1_LVT U42 ( .A(R[4]), .Y(n22) );
  INVX1_LVT U43 ( .A(R[2]), .Y(n21) );
  INVX1_LVT U44 ( .A(R[7]), .Y(n20) );
  INVX1_LVT U45 ( .A(R[6]), .Y(n19) );
  INVX1_LVT U46 ( .A(R[3]), .Y(n24) );
  INVX1_LVT U47 ( .A(R[1]), .Y(n23) );
  MUX21X1_LVT U48 ( .A1(N35), .A2(difference[1]), .S0(n14), .Y(n25) );
  MUX21X1_LVT U49 ( .A1(N38), .A2(difference[4]), .S0(n14), .Y(n28) );
  MUX21X1_LVT U50 ( .A1(N41), .A2(difference[7]), .S0(n15), .Y(n31) );
endmodule


module PE_4_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  DELLN1X2_LVT U1 ( .A(B[0]), .Y(n1) );
  XOR2X1_HVT U2 ( .A1(A[0]), .A2(n1), .Y(SUM[0]) );
  AND2X1_LVT U3 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_4 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_4_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  XNOR2X1_LVT U3 ( .A1(s1s2mux), .A2(n5), .Y(n21) );
  INVX1_LVT U4 ( .A(R[0]), .Y(n5) );
  DELLN1X2_HVT U5 ( .A(difference[0]), .Y(n13) );
  INVX0_LVT U7 ( .A(newDist), .Y(n14) );
  MUX21X1_LVT U8 ( .A1(s1[1]), .A2(s2[1]), .S0(n2), .Y(difference[1]) );
  NOR4X1_LVT U9 ( .A1(n23), .A2(n22), .A3(R[5]), .A4(n21), .Y(n2) );
  INVX0_LVT U10 ( .A(n4), .Y(n10) );
  NBUFFX2_HVT U11 ( .A(n6), .Y(n3) );
  OR4X2_LVT U12 ( .A1(n23), .A2(n22), .A3(R[5]), .A4(n21), .Y(n4) );
  INVX1_LVT U13 ( .A(n14), .Y(n8) );
  AND2X1_LVT U14 ( .A1(Carry), .A2(n14), .Y(n6) );
  INVX1_LVT U15 ( .A(n14), .Y(n7) );
  OR2X1_LVT U16 ( .A1(n24), .A2(n12), .Y(AccumulateIn[1]) );
  OR2X1_LVT U17 ( .A1(n25), .A2(n12), .Y(AccumulateIn[2]) );
  OR2X1_LVT U18 ( .A1(n26), .A2(n12), .Y(AccumulateIn[3]) );
  OR2X1_LVT U19 ( .A1(n27), .A2(n11), .Y(AccumulateIn[4]) );
  OR2X1_LVT U20 ( .A1(n28), .A2(n3), .Y(AccumulateIn[5]) );
  OR2X1_LVT U21 ( .A1(n29), .A2(n11), .Y(AccumulateIn[6]) );
  OR2X1_LVT U22 ( .A1(n30), .A2(n3), .Y(AccumulateIn[7]) );
  OR2X1_LVT U23 ( .A1(n31), .A2(n11), .Y(AccumulateIn[0]) );
  INVX0_LVT U24 ( .A(n4), .Y(n9) );
  NBUFFX2_HVT U25 ( .A(n6), .Y(n11) );
  NBUFFX2_HVT U26 ( .A(n6), .Y(n12) );
  MUX21X1_HVT U27 ( .A1(s1[7]), .A2(s2[7]), .S0(n10), .Y(difference[7]) );
  MUX21X1_HVT U28 ( .A1(s1[6]), .A2(s2[6]), .S0(n2), .Y(difference[6]) );
  MUX21X1_HVT U29 ( .A1(s1[5]), .A2(s2[5]), .S0(n10), .Y(difference[5]) );
  MUX21X1_HVT U30 ( .A1(s1[4]), .A2(s2[4]), .S0(n2), .Y(difference[4]) );
  MUX21X1_HVT U31 ( .A1(s1[3]), .A2(s2[3]), .S0(n10), .Y(difference[3]) );
  MUX21X1_HVT U32 ( .A1(s1[2]), .A2(s2[2]), .S0(n9), .Y(difference[2]) );
  INVX1_LVT U33 ( .A(R[4]), .Y(n18) );
  INVX1_LVT U34 ( .A(R[2]), .Y(n17) );
  INVX1_LVT U35 ( .A(R[7]), .Y(n16) );
  INVX1_LVT U36 ( .A(R[6]), .Y(n15) );
  NAND4X0_LVT U37 ( .A1(n18), .A2(n17), .A3(n16), .A4(n15), .Y(n23) );
  INVX1_LVT U38 ( .A(R[3]), .Y(n20) );
  INVX1_LVT U39 ( .A(R[1]), .Y(n19) );
  NAND2X0_LVT U40 ( .A1(n20), .A2(n19), .Y(n22) );
  MUX21X1_LVT U41 ( .A1(s1[0]), .A2(s2[0]), .S0(n9), .Y(difference[0]) );
  MUX21X1_LVT U42 ( .A1(N35), .A2(difference[1]), .S0(n8), .Y(n24) );
  MUX21X1_LVT U43 ( .A1(N36), .A2(difference[2]), .S0(n8), .Y(n25) );
  MUX21X1_LVT U44 ( .A1(N37), .A2(difference[3]), .S0(n8), .Y(n26) );
  MUX21X1_LVT U45 ( .A1(N38), .A2(difference[4]), .S0(n7), .Y(n27) );
  MUX21X1_LVT U46 ( .A1(N39), .A2(difference[5]), .S0(n7), .Y(n28) );
  MUX21X1_LVT U47 ( .A1(N40), .A2(difference[6]), .S0(n7), .Y(n29) );
  MUX21X1_LVT U48 ( .A1(N41), .A2(difference[7]), .S0(n7), .Y(n30) );
  MUX21X1_LVT U49 ( .A1(N34), .A2(n13), .S0(n8), .Y(n31) );
endmodule


module PE_3_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  DELLN1X2_LVT U1 ( .A(B[0]), .Y(n1) );
  XOR2X1_LVT U2 ( .A1(A[0]), .A2(n1), .Y(SUM[0]) );
  AND2X1_LVT U3 ( .A1(B[0]), .A2(A[0]), .Y(carry[1]) );
endmodule


module PE_3 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  PE_3_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  DFFSSRX1_HVT \Accumulate_reg[0]  ( .D(n43), .SETB(n2), .RSTB(1'b1), .CLK(
        clock), .Q(Accumulate[0]) );
  DFFSSRX1_LVT \Accumulate_reg[7]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[7]), .CLK(clock), .Q(Accumulate[7]) );
  DFFSSRX1_LVT \Accumulate_reg[6]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[6]), .CLK(clock), .Q(Accumulate[6]) );
  DFFSSRX1_LVT \Accumulate_reg[5]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[5]), .CLK(clock), .Q(Accumulate[5]) );
  DFFSSRX1_LVT \Accumulate_reg[4]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[4]), .CLK(clock), .Q(Accumulate[4]) );
  DFFSSRX1_LVT \Accumulate_reg[3]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[3]), .CLK(clock), .Q(Accumulate[3]) );
  DFFSSRX1_LVT \Accumulate_reg[2]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[2]), .CLK(clock), .Q(Accumulate[2]) );
  DFFSSRX1_LVT \Accumulate_reg[1]  ( .D(n36), .SETB(n2), .RSTB(1'b1), .CLK(
        clock), .Q(Accumulate[1]) );
  NAND2X0_LVT U3 ( .A1(s2[2]), .A2(n8), .Y(n12) );
  INVX1_LVT U4 ( .A(newDist), .Y(n26) );
  NAND2X0_LVT U5 ( .A1(Carry), .A2(n26), .Y(n2) );
  AND2X1_LVT U8 ( .A1(Carry), .A2(n26), .Y(n4) );
  MUX21X1_HVT U9 ( .A1(N39), .A2(difference[5]), .S0(n24), .Y(n40) );
  MUX21X1_LVT U10 ( .A1(s1[0]), .A2(s2[0]), .S0(n5), .Y(difference[0]) );
  NOR4X1_LVT U11 ( .A1(n35), .A2(n34), .A3(R[5]), .A4(n33), .Y(n5) );
  NOR4X1_LVT U12 ( .A1(n35), .A2(n34), .A3(R[5]), .A4(n33), .Y(n6) );
  NAND2X0_HVT U13 ( .A1(n12), .A2(n11), .Y(n7) );
  MUX21X1_LVT U14 ( .A1(s2[3]), .A2(s1[3]), .S0(n15), .Y(difference[3]) );
  INVX0_LVT U15 ( .A(n15), .Y(n25) );
  OR4X1_HVT U16 ( .A1(n35), .A2(n34), .A3(R[5]), .A4(n33), .Y(n15) );
  MUX21X1_LVT U17 ( .A1(s1[6]), .A2(s2[6]), .S0(n9), .Y(difference[6]) );
  MUX21X1_LVT U18 ( .A1(s1[4]), .A2(s2[4]), .S0(n9), .Y(difference[4]) );
  INVX0_HVT U19 ( .A(n10), .Y(n9) );
  NBUFFX2_LVT U20 ( .A(n6), .Y(n8) );
  INVX0_LVT U21 ( .A(n8), .Y(n10) );
  NAND2X0_LVT U22 ( .A1(s1[2]), .A2(n10), .Y(n11) );
  NAND2X0_LVT U23 ( .A1(n12), .A2(n11), .Y(difference[2]) );
  MUX21X1_HVT U24 ( .A1(N36), .A2(n7), .S0(n24), .Y(n37) );
  NBUFFX2_HVT U25 ( .A(n4), .Y(n13) );
  NBUFFX2_HVT U26 ( .A(n4), .Y(n14) );
  XOR2X2_LVT U27 ( .A1(s1s2mux), .A2(R[0]), .Y(n33) );
  INVX0_LVT U28 ( .A(n26), .Y(n24) );
  INVX0_LVT U29 ( .A(n26), .Y(n23) );
  MUX21X1_LVT U30 ( .A1(s1[1]), .A2(s2[1]), .S0(n6), .Y(difference[1]) );
  OR2X1_HVT U31 ( .A1(n37), .A2(n14), .Y(AccumulateIn[2]) );
  OR2X1_HVT U32 ( .A1(n38), .A2(n13), .Y(AccumulateIn[3]) );
  OR2X1_HVT U33 ( .A1(n39), .A2(n14), .Y(AccumulateIn[4]) );
  OR2X1_HVT U34 ( .A1(n40), .A2(n13), .Y(AccumulateIn[5]) );
  OR2X1_HVT U35 ( .A1(n41), .A2(n14), .Y(AccumulateIn[6]) );
  OR2X1_HVT U36 ( .A1(n42), .A2(n13), .Y(AccumulateIn[7]) );
  MUX21X1_HVT U44 ( .A1(N35), .A2(difference[1]), .S0(n23), .Y(n36) );
  MUX21X1_HVT U45 ( .A1(s1[7]), .A2(s2[7]), .S0(n25), .Y(difference[7]) );
  MUX21X1_HVT U46 ( .A1(s1[5]), .A2(s2[5]), .S0(n25), .Y(difference[5]) );
  INVX1_LVT U47 ( .A(R[4]), .Y(n30) );
  INVX1_LVT U48 ( .A(R[2]), .Y(n29) );
  INVX1_LVT U49 ( .A(R[7]), .Y(n28) );
  INVX1_LVT U50 ( .A(R[6]), .Y(n27) );
  NAND4X0_LVT U51 ( .A1(n30), .A2(n29), .A3(n28), .A4(n27), .Y(n35) );
  INVX1_LVT U52 ( .A(R[3]), .Y(n32) );
  INVX1_LVT U53 ( .A(R[1]), .Y(n31) );
  NAND2X0_LVT U54 ( .A1(n32), .A2(n31), .Y(n34) );
  MUX21X1_LVT U55 ( .A1(N37), .A2(difference[3]), .S0(n24), .Y(n38) );
  MUX21X1_LVT U56 ( .A1(N38), .A2(difference[4]), .S0(n23), .Y(n39) );
  MUX21X1_LVT U57 ( .A1(N40), .A2(difference[6]), .S0(n24), .Y(n41) );
  MUX21X1_LVT U58 ( .A1(N41), .A2(difference[7]), .S0(n23), .Y(n42) );
  MUX21X1_LVT U59 ( .A1(N34), .A2(difference[0]), .S0(n23), .Y(n43) );
endmodule


module PE_2_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(carry[1]), .CI(B[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(B[0]), .A2(A[0]), .Y(carry[1]) );
endmodule


module PE_2 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  PE_2_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  DFFSSRX1_LVT \Accumulate_reg[4]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[4]), .CLK(clock), .Q(Accumulate[4]) );
  DFFSSRX1_LVT \Accumulate_reg[3]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[3]), .CLK(clock), .Q(Accumulate[3]) );
  DFFSSRX1_LVT \Accumulate_reg[7]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[7]), .CLK(clock), .Q(Accumulate[7]) );
  DFFSSRX1_LVT \Accumulate_reg[6]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[6]), .CLK(clock), .Q(Accumulate[6]) );
  DFFX1_HVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFSSRX1_LVT \Accumulate_reg[1]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[1]), .CLK(clock), .Q(Accumulate[1]) );
  DFFSSRX1_LVT \Accumulate_reg[2]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[2]), .CLK(clock), .Q(Accumulate[2]) );
  DFFSSRX1_LVT \Accumulate_reg[0]  ( .D(1'b0), .SETB(1'b0), .RSTB(
        AccumulateIn[0]), .CLK(clock), .Q(Accumulate[0]) );
  DFFSSRX1_LVT \Accumulate_reg[5]  ( .D(n36), .SETB(n31), .RSTB(1'b1), .CLK(
        clock), .Q(Accumulate[5]) );
  NOR2X0_LVT U3 ( .A1(n27), .A2(n2), .Y(n18) );
  OR2X1_LVT U4 ( .A1(n32), .A2(n4), .Y(AccumulateIn[1]) );
  OR2X1_LVT U5 ( .A1(n37), .A2(n5), .Y(AccumulateIn[6]) );
  OR2X1_LVT U7 ( .A1(n38), .A2(n5), .Y(AccumulateIn[7]) );
  OR2X1_LVT U8 ( .A1(n34), .A2(n3), .Y(AccumulateIn[3]) );
  OR2X1_LVT U9 ( .A1(n35), .A2(n3), .Y(AccumulateIn[4]) );
  OR3X1_LVT U10 ( .A1(n29), .A2(n28), .A3(R[5]), .Y(n2) );
  MUX21X1_HVT U11 ( .A1(N35), .A2(difference[1]), .S0(n14), .Y(n32) );
  MUX21X1_HVT U12 ( .A1(N36), .A2(difference[2]), .S0(n15), .Y(n33) );
  MUX21X1_HVT U13 ( .A1(N37), .A2(difference[3]), .S0(n14), .Y(n34) );
  AND2X1_LVT U14 ( .A1(Carry), .A2(n20), .Y(n4) );
  MUX21X1_HVT U15 ( .A1(N38), .A2(difference[4]), .S0(n15), .Y(n35) );
  INVX0_HVT U16 ( .A(n31), .Y(n3) );
  MUX21X1_HVT U17 ( .A1(N39), .A2(difference[5]), .S0(n14), .Y(n36) );
  INVX0_LVT U18 ( .A(n20), .Y(n14) );
  NBUFFX2_LVT U19 ( .A(n30), .Y(n17) );
  NBUFFX2_LVT U20 ( .A(n30), .Y(n16) );
  INVX0_LVT U21 ( .A(n31), .Y(n5) );
  INVX0_LVT U22 ( .A(newDist), .Y(n20) );
  INVX0_HVT U23 ( .A(n20), .Y(n15) );
  OR2X1_LVT U24 ( .A1(n33), .A2(n4), .Y(AccumulateIn[2]) );
  INVX0_LVT U25 ( .A(R[0]), .Y(n19) );
  OR2X1_LVT U26 ( .A1(n39), .A2(n4), .Y(AccumulateIn[0]) );
  NAND2X0_LVT U35 ( .A1(n20), .A2(Carry), .Y(n31) );
  XNOR2X1_LVT U36 ( .A1(n19), .A2(s1s2mux), .Y(n27) );
  MUX21X1_HVT U37 ( .A1(N41), .A2(difference[7]), .S0(n15), .Y(n38) );
  MUX21X1_HVT U38 ( .A1(N40), .A2(difference[6]), .S0(n14), .Y(n37) );
  MUX21X1_HVT U39 ( .A1(N34), .A2(difference[0]), .S0(n15), .Y(n39) );
  MUX21X1_HVT U40 ( .A1(s1[7]), .A2(s2[7]), .S0(n18), .Y(difference[7]) );
  MUX21X1_HVT U41 ( .A1(s1[6]), .A2(s2[6]), .S0(n17), .Y(difference[6]) );
  MUX21X1_HVT U42 ( .A1(s1[5]), .A2(s2[5]), .S0(n17), .Y(difference[5]) );
  MUX21X1_HVT U43 ( .A1(s1[4]), .A2(s2[4]), .S0(n18), .Y(difference[4]) );
  MUX21X1_HVT U44 ( .A1(s1[3]), .A2(s2[3]), .S0(n16), .Y(difference[3]) );
  MUX21X1_HVT U45 ( .A1(s1[2]), .A2(s2[2]), .S0(n16), .Y(difference[2]) );
  INVX1_LVT U46 ( .A(R[4]), .Y(n24) );
  INVX1_LVT U47 ( .A(R[2]), .Y(n23) );
  INVX1_LVT U48 ( .A(R[7]), .Y(n22) );
  INVX1_LVT U49 ( .A(R[6]), .Y(n21) );
  NAND4X0_LVT U50 ( .A1(n24), .A2(n23), .A3(n22), .A4(n21), .Y(n29) );
  INVX1_LVT U51 ( .A(R[3]), .Y(n26) );
  INVX1_LVT U52 ( .A(R[1]), .Y(n25) );
  NAND2X0_LVT U53 ( .A1(n26), .A2(n25), .Y(n28) );
  NOR4X1_LVT U54 ( .A1(n29), .A2(n28), .A3(R[5]), .A4(n27), .Y(n30) );
  MUX21X1_LVT U55 ( .A1(s1[1]), .A2(s2[1]), .S0(n17), .Y(difference[1]) );
  MUX21X1_LVT U56 ( .A1(s1[0]), .A2(s2[0]), .S0(n18), .Y(difference[0]) );
endmodule


module PE_1_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_1 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, Carry, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  PE_1_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  MUX21X1_LVT U3 ( .A1(s1[2]), .A2(s2[2]), .S0(n9), .Y(difference[2]) );
  XOR2X1_LVT U4 ( .A1(s1s2mux), .A2(R[0]), .Y(n18) );
  NOR4X1_LVT U5 ( .A1(n20), .A2(n19), .A3(R[5]), .A4(n18), .Y(n10) );
  OR2X1_LVT U7 ( .A1(n22), .A2(n4), .Y(AccumulateIn[1]) );
  OR2X1_LVT U8 ( .A1(n23), .A2(n5), .Y(AccumulateIn[2]) );
  OR2X1_LVT U9 ( .A1(n24), .A2(n5), .Y(AccumulateIn[3]) );
  OR2X1_LVT U10 ( .A1(n25), .A2(n2), .Y(AccumulateIn[4]) );
  OR2X1_LVT U11 ( .A1(n26), .A2(n4), .Y(AccumulateIn[5]) );
  OR2X1_LVT U12 ( .A1(n27), .A2(n2), .Y(AccumulateIn[6]) );
  OR2X1_LVT U13 ( .A1(n28), .A2(n4), .Y(AccumulateIn[7]) );
  OR2X1_LVT U14 ( .A1(n29), .A2(n5), .Y(AccumulateIn[0]) );
  INVX1_LVT U15 ( .A(newDist), .Y(n11) );
  INVX0_LVT U16 ( .A(n3), .Y(n2) );
  MUX21X1_LVT U17 ( .A1(s1[0]), .A2(s2[0]), .S0(n21), .Y(difference[0]) );
  NAND2X0_LVT U18 ( .A1(Carry), .A2(n11), .Y(n3) );
  INVX0_LVT U19 ( .A(n11), .Y(n7) );
  INVX0_LVT U20 ( .A(n11), .Y(n8) );
  INVX0_LVT U21 ( .A(n11), .Y(n6) );
  INVX0_LVT U22 ( .A(n3), .Y(n4) );
  INVX0_LVT U23 ( .A(n3), .Y(n5) );
  NOR4X1_LVT U24 ( .A1(n20), .A2(n19), .A3(R[5]), .A4(n18), .Y(n9) );
  MUX21X1_HVT U25 ( .A1(N34), .A2(difference[0]), .S0(n6), .Y(n29) );
  MUX21X1_HVT U26 ( .A1(s1[4]), .A2(s2[4]), .S0(n9), .Y(difference[4]) );
  MUX21X1_HVT U27 ( .A1(s1[5]), .A2(s2[5]), .S0(n10), .Y(difference[5]) );
  MUX21X1_HVT U28 ( .A1(s1[6]), .A2(s2[6]), .S0(n10), .Y(difference[6]) );
  MUX21X1_HVT U29 ( .A1(s1[7]), .A2(s2[7]), .S0(n9), .Y(difference[7]) );
  MUX21X1_HVT U30 ( .A1(s1[3]), .A2(s2[3]), .S0(n21), .Y(difference[3]) );
  INVX1_LVT U31 ( .A(R[4]), .Y(n15) );
  INVX1_LVT U32 ( .A(R[2]), .Y(n14) );
  INVX1_LVT U33 ( .A(R[7]), .Y(n13) );
  INVX1_LVT U34 ( .A(R[6]), .Y(n12) );
  NAND4X0_LVT U35 ( .A1(n15), .A2(n14), .A3(n13), .A4(n12), .Y(n20) );
  INVX1_LVT U36 ( .A(R[3]), .Y(n17) );
  INVX1_LVT U37 ( .A(R[1]), .Y(n16) );
  NAND2X0_LVT U38 ( .A1(n17), .A2(n16), .Y(n19) );
  NOR4X1_LVT U39 ( .A1(n20), .A2(n19), .A3(R[5]), .A4(n18), .Y(n21) );
  MUX21X1_LVT U40 ( .A1(s1[1]), .A2(s2[1]), .S0(n10), .Y(difference[1]) );
  MUX21X1_LVT U41 ( .A1(N35), .A2(difference[1]), .S0(n7), .Y(n22) );
  MUX21X1_LVT U42 ( .A1(N36), .A2(difference[2]), .S0(n8), .Y(n23) );
  MUX21X1_LVT U43 ( .A1(N37), .A2(difference[3]), .S0(n7), .Y(n24) );
  MUX21X1_LVT U44 ( .A1(N38), .A2(difference[4]), .S0(n8), .Y(n25) );
  MUX21X1_LVT U45 ( .A1(N39), .A2(difference[5]), .S0(n7), .Y(n26) );
  MUX21X1_LVT U46 ( .A1(N40), .A2(difference[6]), .S0(n8), .Y(n27) );
  MUX21X1_LVT U47 ( .A1(N41), .A2(difference[7]), .S0(n6), .Y(n28) );
endmodule


module PE_0_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  FADDX1_LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  FADDX1_LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  FADDX1_LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  FADDX1_LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  FADDX1_LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  FADDX1_LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  FADDX1_LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  XOR2X1_HVT U1 ( .A1(A[0]), .A2(B[0]), .Y(SUM[0]) );
  AND2X1_LVT U2 ( .A1(A[0]), .A2(B[0]), .Y(carry[1]) );
endmodule


module PE_0 ( clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe );
  input [7:0] R;
  input [7:0] s1;
  input [7:0] s2;
  output [7:0] Accumulate;
  output [7:0] Rpipe;
  input clock, s1s2mux, newDist;
  wire   N6, N7, N8, N9, N10, N11, N12, N13, N34, N35, N36, N37, N38, N39, N40,
         N41, Carry, \sub_14/carry[7] , \sub_14/carry[6] , \sub_14/carry[5] ,
         \sub_14/carry[4] , \sub_14/carry[3] , \sub_14/carry[2] ,
         \sub_14/carry[1] , n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n13, n16,
         n17, n18, n19, n20;
  wire   [7:0] AccumulateIn;
  wire   [7:0] difference;

  DFFX1_LVT \Rpipe_reg[7]  ( .D(R[7]), .CLK(clock), .Q(Rpipe[7]) );
  DFFX1_LVT \Rpipe_reg[6]  ( .D(R[6]), .CLK(clock), .Q(Rpipe[6]) );
  DFFX1_LVT \Rpipe_reg[5]  ( .D(R[5]), .CLK(clock), .Q(Rpipe[5]) );
  DFFX1_LVT \Rpipe_reg[4]  ( .D(R[4]), .CLK(clock), .Q(Rpipe[4]) );
  DFFX1_LVT \Rpipe_reg[3]  ( .D(R[3]), .CLK(clock), .Q(Rpipe[3]) );
  DFFX1_LVT \Rpipe_reg[2]  ( .D(R[2]), .CLK(clock), .Q(Rpipe[2]) );
  DFFX1_LVT \Rpipe_reg[1]  ( .D(R[1]), .CLK(clock), .Q(Rpipe[1]) );
  DFFX1_LVT \Rpipe_reg[0]  ( .D(R[0]), .CLK(clock), .Q(Rpipe[0]) );
  DFFX1_LVT \Accumulate_reg[0]  ( .D(AccumulateIn[0]), .CLK(clock), .Q(
        Accumulate[0]) );
  DFFX1_LVT \Accumulate_reg[7]  ( .D(AccumulateIn[7]), .CLK(clock), .Q(
        Accumulate[7]) );
  DFFX1_LVT \Accumulate_reg[6]  ( .D(AccumulateIn[6]), .CLK(clock), .Q(
        Accumulate[6]) );
  DFFX1_LVT \Accumulate_reg[5]  ( .D(AccumulateIn[5]), .CLK(clock), .Q(
        Accumulate[5]) );
  DFFX1_LVT \Accumulate_reg[4]  ( .D(AccumulateIn[4]), .CLK(clock), .Q(
        Accumulate[4]) );
  DFFX1_LVT \Accumulate_reg[3]  ( .D(AccumulateIn[3]), .CLK(clock), .Q(
        Accumulate[3]) );
  DFFX1_LVT \Accumulate_reg[2]  ( .D(AccumulateIn[2]), .CLK(clock), .Q(
        Accumulate[2]) );
  DFFX1_LVT \Accumulate_reg[1]  ( .D(AccumulateIn[1]), .CLK(clock), .Q(
        Accumulate[1]) );
  AO221X1_LVT U3 ( .A1(n9), .A2(difference[7]), .A3(N41), .A4(n7), .A5(n4), 
        .Y(AccumulateIn[7]) );
  AO22X1_LVT U5 ( .A1(s1[7]), .A2(n11), .A3(s2[7]), .A4(n2), .Y(difference[7])
         );
  AO221X1_LVT U10 ( .A1(n9), .A2(difference[6]), .A3(N40), .A4(n8), .A5(n5), 
        .Y(AccumulateIn[6]) );
  AO22X1_LVT U12 ( .A1(s1[6]), .A2(n13), .A3(s2[6]), .A4(n2), .Y(difference[6]) );
  AO221X1_LVT U13 ( .A1(n9), .A2(difference[5]), .A3(N39), .A4(n7), .A5(n6), 
        .Y(AccumulateIn[5]) );
  AO22X1_LVT U15 ( .A1(s1[5]), .A2(n11), .A3(s2[5]), .A4(n2), .Y(difference[5]) );
  AO221X1_LVT U16 ( .A1(n9), .A2(difference[4]), .A3(N38), .A4(n8), .A5(n5), 
        .Y(AccumulateIn[4]) );
  AO22X1_LVT U18 ( .A1(s1[4]), .A2(n13), .A3(s2[4]), .A4(n2), .Y(difference[4]) );
  AO221X1_LVT U19 ( .A1(n9), .A2(difference[3]), .A3(N37), .A4(n7), .A5(n6), 
        .Y(AccumulateIn[3]) );
  AO22X1_LVT U21 ( .A1(s1[3]), .A2(n11), .A3(s2[3]), .A4(n2), .Y(difference[3]) );
  AO221X1_LVT U22 ( .A1(n9), .A2(difference[2]), .A3(N36), .A4(n7), .A5(n5), 
        .Y(AccumulateIn[2]) );
  AO22X1_LVT U24 ( .A1(s1[2]), .A2(n13), .A3(s2[2]), .A4(n17), .Y(
        difference[2]) );
  AO221X1_LVT U25 ( .A1(newDist), .A2(difference[1]), .A3(N35), .A4(n8), .A5(
        n4), .Y(AccumulateIn[1]) );
  AO22X1_LVT U27 ( .A1(s1[1]), .A2(n10), .A3(s2[1]), .A4(n17), .Y(
        difference[1]) );
  AO221X1_LVT U28 ( .A1(newDist), .A2(difference[0]), .A3(N34), .A4(n7), .A5(
        n4), .Y(AccumulateIn[0]) );
  AND2X1_LVT U29 ( .A1(Carry), .A2(n8), .Y(n20) );
  AO22X1_LVT U31 ( .A1(s1[0]), .A2(n10), .A3(s2[0]), .A4(n17), .Y(
        difference[0]) );
  NOR4X1_LVT U33 ( .A1(N9), .A2(N8), .A3(N7), .A4(N6), .Y(n18) );
  NOR4X1_LVT U34 ( .A1(N13), .A2(N12), .A3(N11), .A4(N10), .Y(n19) );
  PE_0_DW01_add_0 add_16 ( .A({1'b0, Accumulate}), .B({1'b0, difference}), 
        .CI(1'b0), .SUM({Carry, N41, N40, N39, N38, N37, N36, N35, N34}) );
  INVX0_HVT U4 ( .A(n3), .Y(n13) );
  INVX0_LVT U7 ( .A(n13), .Y(n2) );
  INVX0_LVT U8 ( .A(n3), .Y(n10) );
  INVX0_HVT U9 ( .A(n8), .Y(n9) );
  INVX0_HVT U11 ( .A(n3), .Y(n11) );
  INVX0_HVT U14 ( .A(newDist), .Y(n7) );
  INVX1_LVT U17 ( .A(newDist), .Y(n8) );
  AND2X1_LVT U20 ( .A1(n19), .A2(n18), .Y(n3) );
  XNOR2X1_LVT U23 ( .A1(R[7]), .A2(\sub_14/carry[7] ), .Y(N13) );
  OR2X1_HVT U26 ( .A1(R[5]), .A2(\sub_14/carry[5] ), .Y(\sub_14/carry[6] ) );
  OR2X1_HVT U30 ( .A1(R[1]), .A2(\sub_14/carry[1] ), .Y(\sub_14/carry[2] ) );
  OR2X1_HVT U32 ( .A1(R[2]), .A2(\sub_14/carry[2] ), .Y(\sub_14/carry[3] ) );
  OR2X1_HVT U35 ( .A1(R[3]), .A2(\sub_14/carry[3] ), .Y(\sub_14/carry[4] ) );
  OR2X1_HVT U36 ( .A1(R[4]), .A2(\sub_14/carry[4] ), .Y(\sub_14/carry[5] ) );
  NBUFFX2_LVT U37 ( .A(n20), .Y(n4) );
  NBUFFX2_LVT U38 ( .A(n20), .Y(n5) );
  NBUFFX2_HVT U39 ( .A(n20), .Y(n6) );
  OR2X1_LVT U40 ( .A1(R[6]), .A2(\sub_14/carry[6] ), .Y(\sub_14/carry[7] ) );
  XNOR2X1_LVT U41 ( .A1(\sub_14/carry[4] ), .A2(R[4]), .Y(N10) );
  XNOR2X1_LVT U42 ( .A1(n16), .A2(R[0]), .Y(N6) );
  XNOR2X1_LVT U43 ( .A1(\sub_14/carry[5] ), .A2(R[5]), .Y(N11) );
  XNOR2X1_LVT U44 ( .A1(\sub_14/carry[1] ), .A2(R[1]), .Y(N7) );
  OR2X1_LVT U45 ( .A1(R[0]), .A2(n16), .Y(\sub_14/carry[1] ) );
  XNOR2X1_LVT U46 ( .A1(\sub_14/carry[6] ), .A2(R[6]), .Y(N12) );
  XNOR2X1_LVT U47 ( .A1(\sub_14/carry[2] ), .A2(R[2]), .Y(N8) );
  XNOR2X1_LVT U48 ( .A1(\sub_14/carry[3] ), .A2(R[3]), .Y(N9) );
  INVX1_LVT U49 ( .A(s1s2mux), .Y(n16) );
  INVX1_LVT U50 ( .A(n10), .Y(n17) );
endmodule


module control_DW01_inc_0 ( A, SUM );
  input [12:0] A;
  output [12:0] SUM;

  wire   [12:2] carry;

  HADDX1_LVT U1_1_7 ( .A0(A[7]), .B0(carry[7]), .C1(carry[8]), .SO(SUM[7]) );
  HADDX1_LVT U1_1_6 ( .A0(A[6]), .B0(carry[6]), .C1(carry[7]), .SO(SUM[6]) );
  HADDX1_LVT U1_1_5 ( .A0(A[5]), .B0(carry[5]), .C1(carry[6]), .SO(SUM[5]) );
  HADDX1_LVT U1_1_4 ( .A0(A[4]), .B0(carry[4]), .C1(carry[5]), .SO(SUM[4]) );
  HADDX1_LVT U1_1_3 ( .A0(A[3]), .B0(carry[3]), .C1(carry[4]), .SO(SUM[3]) );
  HADDX1_LVT U1_1_9 ( .A0(A[9]), .B0(carry[9]), .C1(carry[10]), .SO(SUM[9]) );
  HADDX1_LVT U1_1_10 ( .A0(A[10]), .B0(carry[10]), .C1(carry[11]), .SO(SUM[10]) );
  HADDX1_HVT U1_1_11 ( .A0(A[11]), .B0(carry[11]), .C1(carry[12]), .SO(SUM[11]) );
  HADDX1_LVT U1_1_8 ( .A0(A[8]), .B0(carry[8]), .C1(carry[9]), .SO(SUM[8]) );
  HADDX1_LVT U1_1_1 ( .A0(A[1]), .B0(A[0]), .C1(carry[2]), .SO(SUM[1]) );
  HADDX1_LVT U1_1_2 ( .A0(A[2]), .B0(carry[2]), .C1(carry[3]), .SO(SUM[2]) );
  XOR2X1_LVT U1 ( .A1(carry[12]), .A2(A[12]), .Y(SUM[12]) );
  INVX1_LVT U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module control ( clock, start, S1S2mux, NewDist, CompStart, PEready, VectorX, 
        VectorY, AddressR, AddressS1, AddressS2 );
  output [15:0] S1S2mux;
  output [15:0] NewDist;
  output [15:0] PEready;
  output [3:0] VectorX;
  output [3:0] VectorY;
  output [7:0] AddressR;
  output [9:0] AddressS1;
  output [9:0] AddressS2;
  input clock, start;
  output CompStart;
  wire   n76, AddressS2_0, n78, n79, n80, N4, N5, N6, N7, N8, N9, N10, N11,
         N12, N13, N14, N15, N16, n53, n55, n77, n61, n65, n66,
         \r114/carry[3] , \r114/carry[2] , \r114/carry[1] , n2, n3, n4, n6, n7,
         n9, n10, n11, \AddressS1[0] , n13, n14, n15, n16, n17, n19, n20, n21,
         n23, n24, n25, n26, n27, n32, \NewDist[1] , \NewDist[3] ,
         \NewDist[8] , n36, n37, n38, n40, \PEready[14] , \PEready[11] ,
         \PEready[12] , n52, n57, n58, n59, n60, n62, n63, n64, n67, n68, n69,
         n70, n71, n72, n73;
  wire   [12:8] count;
  assign AddressS1[9] = AddressS2[8];
  assign AddressS1[8] = AddressS2[7];
  assign AddressS1[7] = AddressS2[6];
  assign AddressS1[6] = AddressS2[5];
  assign AddressS1[5] = AddressS2[4];
  assign AddressS1[3] = AddressS2[3];
  assign AddressR[3] = AddressS2[3];
  assign AddressR[2] = AddressS2[2];
  assign AddressS1[2] = AddressS2[2];
  assign AddressS1[1] = AddressS2[1];
  assign S1S2mux[15] = 1'b0;
  assign AddressS2[0] = \AddressS1[0] ;
  assign AddressR[0] = \AddressS1[0] ;
  assign AddressS1[0] = \AddressS1[0] ;
  assign NewDist[4] = \NewDist[1] ;
  assign NewDist[9] = \NewDist[1] ;
  assign NewDist[2] = \NewDist[1] ;
  assign NewDist[10] = \NewDist[1] ;
  assign NewDist[1] = \NewDist[1] ;
  assign NewDist[13] = \NewDist[3] ;
  assign NewDist[14] = \NewDist[3] ;
  assign NewDist[5] = \NewDist[3] ;
  assign NewDist[0] = \NewDist[3] ;
  assign NewDist[3] = \NewDist[3] ;
  assign NewDist[11] = \NewDist[8] ;
  assign NewDist[6] = \NewDist[8] ;
  assign NewDist[7] = \NewDist[8] ;
  assign NewDist[12] = \NewDist[8] ;
  assign NewDist[8] = \NewDist[8] ;
  assign PEready[0] = \PEready[14] ;
  assign PEready[2] = \PEready[14] ;
  assign PEready[6] = \PEready[14] ;
  assign PEready[13] = \PEready[14] ;
  assign PEready[14] = \PEready[14] ;
  assign PEready[1] = \PEready[11] ;
  assign PEready[3] = \PEready[11] ;
  assign PEready[4] = \PEready[11] ;
  assign PEready[9] = \PEready[11] ;
  assign PEready[10] = \PEready[11] ;
  assign PEready[11] = \PEready[11] ;
  assign PEready[5] = \PEready[12] ;
  assign PEready[15] = \PEready[12] ;
  assign PEready[8] = \PEready[12] ;
  assign PEready[7] = \PEready[12] ;
  assign PEready[12] = \PEready[12] ;
  assign AddressS2[9] = 1'b0;
  assign AddressS1[4] = 1'b0;

  DFFSSRX1_LVT \count_reg[12]  ( .D(N16), .SETB(n61), .RSTB(start), .CLK(clock), .Q(count[12]), .QN(n53) );
  DFFSSRX1_LVT \count_reg[4]  ( .D(N8), .SETB(n61), .RSTB(start), .CLK(clock), 
        .Q(AddressR[4]), .QN(n55) );
  DFFSSRX1_LVT \count_reg[5]  ( .D(N9), .SETB(1'b1), .RSTB(n73), .CLK(clock), 
        .Q(AddressR[5]), .QN(n2) );
  DFFSSRX1_LVT \count_reg[6]  ( .D(N10), .SETB(1'b1), .RSTB(n73), .CLK(clock), 
        .Q(AddressR[6]), .QN(n4) );
  DFFSSRX1_LVT \count_reg[7]  ( .D(N11), .SETB(1'b1), .RSTB(n73), .CLK(clock), 
        .Q(AddressR[7]), .QN(n3) );
  DFFSSRX1_LVT \count_reg[8]  ( .D(N12), .SETB(1'b1), .RSTB(n73), .CLK(clock), 
        .Q(count[8]), .QN(VectorY[0]) );
  control_DW01_inc_0 add_18 ( .A({count, AddressR[7:4], AddressS2[3:2], 
        AddressR[1], n57}), .SUM({N16, N15, N14, N13, N12, N11, N10, N9, N8, 
        N7, N6, N5, N4}) );
  DFFSSRX1_HVT \count_reg[10]  ( .D(1'b0), .SETB(n64), .RSTB(N14), .CLK(clock), 
        .Q(count[10]), .QN(n59) );
  DFFSSRX1_HVT \count_reg[9]  ( .D(1'b0), .SETB(n64), .RSTB(N13), .CLK(clock), 
        .Q(count[9]), .QN(n60) );
  DFFSSRX1_LVT \count_reg[1]  ( .D(1'b0), .SETB(n64), .RSTB(N5), .CLK(clock), 
        .Q(n80), .QN(n16) );
  DFFX1_LVT \count_reg[3]  ( .D(n27), .CLK(clock), .Q(n78), .QN(n40) );
  DFFSSRX1_LVT \count_reg[2]  ( .D(1'b0), .SETB(n64), .RSTB(N6), .CLK(clock), 
        .Q(n79), .QN(n36) );
  DFFSSRX1_LVT \count_reg[0]  ( .D(N4), .SETB(1'b1), .RSTB(n73), .CLK(clock), 
        .Q(AddressS2_0), .QN(n77) );
  DFFSSRX1_LVT \count_reg[11]  ( .D(N15), .SETB(1'b1), .RSTB(n73), .CLK(clock), 
        .Q(count[11]), .QN(n6) );
  NAND2X1_LVT U4 ( .A1(n80), .A2(n79), .Y(n19) );
  AO21X1_LVT U5 ( .A1(AddressS2[1]), .A2(n20), .A3(S1S2mux[7]), .Y(S1S2mux[5])
         );
  AO21X1_LVT U10 ( .A1(\AddressS1[0] ), .A2(n9), .A3(S1S2mux[5]), .Y(
        S1S2mux[4]) );
  NBUFFX2_LVT U11 ( .A(n52), .Y(AddressS2[3]) );
  AND4X1_LVT U12 ( .A1(AddressR[4]), .A2(count[12]), .A3(n25), .A4(n62), .Y(
        n63) );
  INVX0_LVT U14 ( .A(n17), .Y(n11) );
  INVX0_LVT U15 ( .A(S1S2mux[0]), .Y(n62) );
  INVX0_HVT U16 ( .A(n17), .Y(n67) );
  AND4X1_LVT U17 ( .A1(n55), .A2(n58), .A3(n68), .A4(n26), .Y(n24) );
  INVX0_LVT U18 ( .A(n36), .Y(n20) );
  NBUFFX2_LVT U19 ( .A(n24), .Y(NewDist[15]) );
  NBUFFX2_LVT U20 ( .A(n20), .Y(AddressS2[2]) );
  NAND2X0_LVT U21 ( .A1(n77), .A2(n68), .Y(S1S2mux[0]) );
  NBUFFX2_LVT U22 ( .A(n76), .Y(S1S2mux[3]) );
  INVX1_LVT U23 ( .A(n57), .Y(VectorX[0]) );
  NBUFFX2_LVT U24 ( .A(\AddressS1[0] ), .Y(n57) );
  INVX1_LVT U25 ( .A(n20), .Y(n7) );
  INVX0_LVT U26 ( .A(n11), .Y(AddressR[1]) );
  OAI21X2_LVT U27 ( .A1(n70), .A2(n7), .A3(n10), .Y(S1S2mux[6]) );
  OR2X1_LVT U28 ( .A1(n77), .A2(n11), .Y(n70) );
  INVX1_LVT U29 ( .A(n16), .Y(n17) );
  NBUFFX2_LVT U30 ( .A(n79), .Y(n9) );
  INVX0_LVT U31 ( .A(n21), .Y(n10) );
  NBUFFX2_LVT U32 ( .A(n78), .Y(S1S2mux[7]) );
  AO21X1_LVT U33 ( .A1(AddressS2[1]), .A2(S1S2mux[7]), .A3(n38), .Y(S1S2mux[9]) );
  NBUFFX2_LVT U34 ( .A(n80), .Y(AddressS2[1]) );
  NBUFFX2_HVT U35 ( .A(n13), .Y(n52) );
  NOR2X0_LVT U36 ( .A1(n10), .A2(n19), .Y(S1S2mux[13]) );
  INVX0_LVT U37 ( .A(n15), .Y(\AddressS1[0] ) );
  NBUFFX2_HVT U38 ( .A(AddressS2_0), .Y(n58) );
  INVX0_LVT U39 ( .A(AddressS2_0), .Y(n15) );
  NBUFFX2_LVT U40 ( .A(n78), .Y(n13) );
  FADDX1_HVT U41 ( .A(count[11]), .B(AddressR[7]), .CI(\r114/carry[3] ), .CO(
        AddressS2[8]), .S(AddressS2[7]) );
  NAND2X0_LVT U42 ( .A1(n53), .A2(n25), .Y(CompStart) );
  AO21X1_LVT U43 ( .A1(n71), .A2(n52), .A3(S1S2mux[11]), .Y(S1S2mux[10]) );
  OR2X1_LVT U44 ( .A1(n19), .A2(n15), .Y(n14) );
  OR2X1_LVT U45 ( .A1(n10), .A2(n14), .Y(n72) );
  NAND2X0_LVT U46 ( .A1(n69), .A2(n67), .Y(S1S2mux[1]) );
  AO21X1_LVT U47 ( .A1(n58), .A2(n52), .A3(S1S2mux[9]), .Y(S1S2mux[8]) );
  INVX0_LVT U48 ( .A(S1S2mux[1]), .Y(n68) );
  INVX0_LVT U50 ( .A(n70), .Y(n71) );
  NBUFFX2_LVT U51 ( .A(n37), .Y(S1S2mux[11]) );
  INVX0_LVT U52 ( .A(n40), .Y(n21) );
  AO21X1_LVT U53 ( .A1(n37), .A2(n58), .A3(S1S2mux[13]), .Y(S1S2mux[12]) );
  NBUFFX2_HVT U54 ( .A(n23), .Y(\PEready[12] ) );
  NBUFFX2_HVT U55 ( .A(n23), .Y(\PEready[14] ) );
  INVX0_LVT U56 ( .A(n32), .Y(\NewDist[3] ) );
  INVX0_HVT U57 ( .A(n32), .Y(\NewDist[8] ) );
  AND2X1_LVT U58 ( .A1(n24), .A2(CompStart), .Y(n23) );
  AND4X1_LVT U59 ( .A1(VectorY[0]), .A2(n60), .A3(n59), .A4(n6), .Y(n25) );
  XNOR2X1_HVT U60 ( .A1(n7), .A2(n71), .Y(VectorX[2]) );
  AND3X1_LVT U61 ( .A1(n3), .A2(n4), .A3(n2), .Y(n26) );
  XOR2X1_HVT U62 ( .A1(n65), .A2(count[11]), .Y(VectorY[3]) );
  XOR2X1_HVT U63 ( .A1(n67), .A2(VectorX[0]), .Y(VectorX[1]) );
  AND2X1_HVT U64 ( .A1(count[9]), .A2(count[8]), .Y(n66) );
  AND2X1_HVT U65 ( .A1(N7), .A2(n73), .Y(n27) );
  FADDX1_HVT U70 ( .A(count[10]), .B(AddressR[6]), .CI(\r114/carry[2] ), .CO(
        \r114/carry[3] ), .S(AddressS2[6]) );
  XOR2X1_HVT U71 ( .A1(count[10]), .A2(n66), .Y(VectorY[2]) );
  NAND2X0_HVT U72 ( .A1(count[10]), .A2(n66), .Y(n65) );
  FADDX1_HVT U73 ( .A(count[9]), .B(AddressR[5]), .CI(\r114/carry[1] ), .CO(
        \r114/carry[2] ), .S(AddressS2[5]) );
  XNOR2X1_HVT U74 ( .A1(count[9]), .A2(VectorY[0]), .Y(VectorY[1]) );
  NAND2X0_HVT U75 ( .A1(n70), .A2(n69), .Y(S1S2mux[2]) );
  NBUFFX2_LVT U76 ( .A(n23), .Y(\PEready[11] ) );
  INVX1_LVT U77 ( .A(n24), .Y(n32) );
  INVX0_LVT U78 ( .A(n32), .Y(\NewDist[1] ) );
  INVX0_LVT U79 ( .A(n76), .Y(n69) );
  NBUFFX2_LVT U80 ( .A(n38), .Y(n37) );
  AND2X1_LVT U81 ( .A1(n13), .A2(n9), .Y(n38) );
  NAND2X0_HVT U82 ( .A1(n72), .A2(S1S2mux[6]), .Y(VectorX[3]) );
  INVX0_LVT U83 ( .A(n72), .Y(S1S2mux[14]) );
  NAND2X0_LVT U84 ( .A1(n36), .A2(n40), .Y(n76) );
  NAND2X0_LVT U85 ( .A1(n63), .A2(n26), .Y(n61) );
  NAND2X0_LVT U86 ( .A1(start), .A2(n61), .Y(n64) );
  INVX1_LVT U87 ( .A(n64), .Y(n73) );
  AND2X1_HVT U88 ( .A1(count[8]), .A2(AddressR[4]), .Y(\r114/carry[1] ) );
  XOR2X1_HVT U89 ( .A1(count[8]), .A2(AddressR[4]), .Y(AddressS2[4]) );
endmodule


module Comparator ( clock, CompStart, PEout, PEready, vectorX, vectorY, 
        BestDist, motionX, motionY );
  input [127:0] PEout;
  input [15:0] PEready;
  input [3:0] vectorX;
  input [3:0] vectorY;
  output [7:0] BestDist;
  output [3:0] motionX;
  output [3:0] motionY;
  input clock, CompStart;
  wire   N16, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n1, n2, n3, n4, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54;

  AO22X1_LVT U6 ( .A1(vectorX[2]), .A2(n36), .A3(motionX[2]), .A4(n32), .Y(n13) );
  AO22X1_LVT U7 ( .A1(vectorX[3]), .A2(n34), .A3(motionX[3]), .A4(n32), .Y(n14) );
  AO22X1_LVT U9 ( .A1(vectorY[1]), .A2(n34), .A3(motionY[1]), .A4(n33), .Y(n16) );
  AO22X1_LVT U10 ( .A1(vectorY[2]), .A2(n35), .A3(motionY[2]), .A4(n2), .Y(n17) );
  AO22X1_LVT U11 ( .A1(vectorY[3]), .A2(n36), .A3(motionY[3]), .A4(n2), .Y(n18) );
  AO221X1_LVT U12 ( .A1(PEout[127]), .A2(n34), .A3(BestDist[7]), .A4(n32), 
        .A5(n54), .Y(n19) );
  AO221X1_LVT U13 ( .A1(PEout[126]), .A2(n36), .A3(BestDist[6]), .A4(n31), 
        .A5(n54), .Y(n20) );
  AO221X1_LVT U14 ( .A1(PEout[125]), .A2(n35), .A3(BestDist[5]), .A4(n31), 
        .A5(n54), .Y(n21) );
  AO221X1_LVT U15 ( .A1(PEout[124]), .A2(n35), .A3(BestDist[4]), .A4(n2), .A5(
        n54), .Y(n22) );
  AO221X1_LVT U16 ( .A1(PEout[123]), .A2(n36), .A3(BestDist[3]), .A4(n33), 
        .A5(n54), .Y(n23) );
  AO221X1_LVT U17 ( .A1(PEout[122]), .A2(n34), .A3(BestDist[2]), .A4(n31), 
        .A5(n54), .Y(n24) );
  AO221X1_LVT U18 ( .A1(PEout[121]), .A2(n35), .A3(BestDist[1]), .A4(n32), 
        .A5(n54), .Y(n25) );
  AO221X1_LVT U19 ( .A1(PEout[120]), .A2(n34), .A3(BestDist[0]), .A4(n5), .A5(
        n54), .Y(n26) );
  NAND4X0_LVT U21 ( .A1(n7), .A2(n8), .A3(n9), .A4(n10), .Y(n6) );
  NOR4X1_LVT U24 ( .A1(PEready[1]), .A2(PEready[15]), .A3(PEready[14]), .A4(
        PEready[13]), .Y(n8) );
  DFFX1_HVT \BestDist_reg[3]  ( .D(n23), .CLK(clock), .Q(BestDist[3]) );
  DFFX1_HVT \BestDist_reg[1]  ( .D(n25), .CLK(clock), .Q(BestDist[1]) );
  DFFX1_HVT \BestDist_reg[6]  ( .D(n20), .CLK(clock), .Q(BestDist[6]), .QN(n27) );
  DFFX1_HVT \BestDist_reg[5]  ( .D(n21), .CLK(clock), .Q(BestDist[5]) );
  DFFX1_HVT \BestDist_reg[4]  ( .D(n22), .CLK(clock), .Q(BestDist[4]) );
  DFFX1_HVT \BestDist_reg[2]  ( .D(n24), .CLK(clock), .Q(BestDist[2]) );
  DFFX1_HVT \BestDist_reg[0]  ( .D(n26), .CLK(clock), .Q(BestDist[0]), .QN(n29) );
  DFFX1_LVT \motionY_reg[3]  ( .D(n18), .CLK(clock), .Q(motionY[3]) );
  DFFX1_LVT \motionY_reg[1]  ( .D(n16), .CLK(clock), .Q(motionY[1]) );
  DFFX1_LVT \motionX_reg[3]  ( .D(n14), .CLK(clock), .Q(motionX[3]) );
  DFFX1_LVT \motionX_reg[1]  ( .D(n12), .CLK(clock), .Q(motionX[1]) );
  DFFX1_LVT \motionX_reg[0]  ( .D(n11), .CLK(clock), .Q(motionX[0]) );
  DFFX1_LVT \motionX_reg[2]  ( .D(n13), .CLK(clock), .Q(motionX[2]) );
  DFFX1_LVT \motionY_reg[0]  ( .D(n15), .CLK(clock), .Q(motionY[0]) );
  DFFX1_LVT \motionY_reg[2]  ( .D(n17), .CLK(clock), .Q(motionY[2]) );
  DFFX1_LVT \BestDist_reg[7]  ( .D(n19), .CLK(clock), .Q(BestDist[7]) );
  OAI21X1_LVT U3 ( .A1(n27), .A2(PEout[126]), .A3(n28), .Y(n45) );
  INVX1_LVT U4 ( .A(CompStart), .Y(n54) );
  AO22X1_LVT U5 ( .A1(vectorX[1]), .A2(n35), .A3(motionX[1]), .A4(n33), .Y(n12) );
  INVX0_LVT U8 ( .A(n53), .Y(n4) );
  INVX0_HVT U20 ( .A(n37), .Y(n35) );
  INVX0_HVT U22 ( .A(n37), .Y(n34) );
  AND2X1_LVT U23 ( .A1(CompStart), .A2(N16), .Y(n1) );
  INVX1_LVT U25 ( .A(n30), .Y(n2) );
  NAND3X0_LVT U26 ( .A1(n6), .A2(CompStart), .A3(N16), .Y(n5) );
  AO22X1_HVT U27 ( .A1(vectorX[0]), .A2(n53), .A3(motionX[0]), .A4(n33), .Y(
        n11) );
  INVX0_LVT U28 ( .A(n5), .Y(n3) );
  NOR4X0_LVT U29 ( .A1(PEready[12]), .A2(PEready[11]), .A3(PEready[10]), .A4(
        PEready[0]), .Y(n7) );
  NOR4X0_LVT U30 ( .A1(PEready[8]), .A2(PEready[9]), .A3(PEready[7]), .A4(
        PEready[6]), .Y(n10) );
  NOR4X0_LVT U31 ( .A1(PEready[5]), .A2(PEready[4]), .A3(PEready[3]), .A4(
        PEready[2]), .Y(n9) );
  INVX0_LVT U32 ( .A(n5), .Y(n30) );
  AO22X1_HVT U33 ( .A1(vectorY[0]), .A2(n53), .A3(motionY[0]), .A4(n31), .Y(
        n15) );
  AO221X1_LVT U34 ( .A1(BestDist[2]), .A2(n47), .A3(BestDist[3]), .A4(n48), 
        .A5(n40), .Y(n41) );
  AO221X1_LVT U35 ( .A1(BestDist[4]), .A2(n49), .A3(BestDist[5]), .A4(n50), 
        .A5(n42), .Y(n43) );
  INVX0_LVT U36 ( .A(n4), .Y(n36) );
  NOR2X1_LVT U37 ( .A1(n29), .A2(PEout[120]), .Y(n38) );
  NAND2X0_LVT U38 ( .A1(n1), .A2(n6), .Y(n37) );
  AO22X1_LVT U39 ( .A1(BestDist[7]), .A2(n52), .A3(n45), .A4(n44), .Y(N16) );
  OAI221X1_LVT U40 ( .A1(BestDist[6]), .A2(n51), .A3(BestDist[5]), .A4(n50), 
        .A5(n43), .Y(n28) );
  INVX0_LVT U41 ( .A(n3), .Y(n31) );
  INVX0_LVT U42 ( .A(n30), .Y(n32) );
  INVX0_LVT U43 ( .A(n3), .Y(n33) );
  INVX0_LVT U44 ( .A(n37), .Y(n53) );
  AND2X1_HVT U45 ( .A1(n38), .A2(n46), .Y(n39) );
  OA222X1_HVT U46 ( .A1(BestDist[2]), .A2(n47), .A3(BestDist[1]), .A4(n39), 
        .A5(n38), .A6(n46), .Y(n40) );
  OA221X1_HVT U47 ( .A1(BestDist[4]), .A2(n49), .A3(BestDist[3]), .A4(n48), 
        .A5(n41), .Y(n42) );
  OR2X1_HVT U48 ( .A1(n52), .A2(BestDist[7]), .Y(n44) );
  INVX1_LVT U49 ( .A(PEout[121]), .Y(n46) );
  INVX1_LVT U50 ( .A(PEout[122]), .Y(n47) );
  INVX1_LVT U51 ( .A(PEout[123]), .Y(n48) );
  INVX1_LVT U52 ( .A(PEout[124]), .Y(n49) );
  INVX1_LVT U53 ( .A(PEout[125]), .Y(n50) );
  INVX1_LVT U54 ( .A(PEout[126]), .Y(n51) );
  INVX1_LVT U55 ( .A(PEout[127]), .Y(n52) );
endmodule


module top ( clock, start, R, S1, S2, AddressR, AddressS1, AddressS2, BestDist, 
        motionX, motionY );
  input [7:0] R;
  input [7:0] S1;
  input [7:0] S2;
  output [7:0] AddressR;
  output [9:0] AddressS1;
  output [9:0] AddressS2;
  output [7:0] BestDist;
  output [3:0] motionX;
  output [3:0] motionY;
  input clock, start;
  wire   CompStart, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48;
  wire   [15:0] S1S2mux;
  wire   [15:0] newDist;
  wire   [127:0] PEOut;
  wire   [7:0] Rpipe0;
  wire   [7:0] Rpipe1;
  wire   [7:0] Rpipe2;
  wire   [7:0] Rpipe3;
  wire   [7:0] Rpipe4;
  wire   [7:0] Rpipe5;
  wire   [7:0] Rpipe6;
  wire   [7:0] Rpipe7;
  wire   [7:0] Rpipe8;
  wire   [7:0] Rpipe9;
  wire   [7:0] Rpipe10;
  wire   [7:0] Rpipe11;
  wire   [7:0] Rpipe12;
  wire   [7:0] Rpipe13;
  wire   [7:0] Rpipe14;
  wire   [15:0] PEready;
  wire   [3:0] VectorX;
  wire   [3:0] VectorY;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2;
  assign AddressS1[4] = 1'b0;
  assign AddressS2[9] = 1'b0;

  PE_15 pe0 ( .clock(clock), .R(R), .s1({n47, n44, n41, n38, n35, n32, n30, 
        n26}), .s2({n24, n21, n18, n15, n12, n9, n6, n3}), .s1s2mux(S1S2mux[0]), .newDist(newDist[0]), .Accumulate(PEOut[7:0]), .Rpipe(Rpipe0) );
  PE_14 pe1 ( .clock(clock), .R(Rpipe0), .s1({S1[7:2], n29, n27}), .s2({n23, 
        n20, n17, n14, n11, n8, n5, n2}), .s1s2mux(S1S2mux[1]), .newDist(
        newDist[1]), .Accumulate(PEOut[15:8]), .Rpipe(Rpipe1) );
  PE_13 pe2 ( .clock(clock), .R(Rpipe1), .s1({S1[7:2], n29, S1[0]}), .s2({n23, 
        n20, n17, n14, n11, n8, n5, n2}), .s1s2mux(S1S2mux[2]), .newDist(
        newDist[2]), .Accumulate(PEOut[23:16]), .Rpipe(Rpipe2) );
  PE_12 pe3 ( .clock(clock), .R(Rpipe2), .s1({S1[7], n45, S1[5:2], n29, S1[0]}), .s2({n23, n20, n17, n14, n11, n8, n5, n2}), .s1s2mux(S1S2mux[3]), .newDist(
        newDist[3]), .Accumulate(PEOut[31:24]), .Rpipe(Rpipe3) );
  PE_11 pe4 ( .clock(clock), .R(Rpipe3), .s1({n48, S1[6], n42, n39, n36, S1[2], 
        n29, S1[0]}), .s2({n23, n20, n17, n14, n11, n8, n5, n2}), .s1s2mux(
        S1S2mux[4]), .newDist(newDist[4]), .Accumulate(PEOut[39:32]), .Rpipe(
        Rpipe4) );
  PE_10 pe5 ( .clock(clock), .R(Rpipe4), .s1({n47, n44, n41, n38, n35, n32, 
        n29, n26}), .s2({n24, n21, n18, n15, n12, n9, n6, n3}), .s1s2mux(
        S1S2mux[5]), .newDist(newDist[5]), .Accumulate(PEOut[47:40]), .Rpipe(
        Rpipe5) );
  PE_9 pe6 ( .clock(clock), .R(Rpipe5), .s1({n48, n45, n42, n39, n36, n33, n30, 
        n27}), .s2({n23, n20, n17, S2[4:3], n8, S2[1], n2}), .s1s2mux(
        S1S2mux[6]), .newDist(newDist[6]), .Accumulate(PEOut[55:48]), .Rpipe(
        Rpipe6) );
  PE_8 pe7 ( .clock(clock), .R(Rpipe6), .s1({n47, n44, n41, n38, n35, n32, 
        S1[1], n26}), .s2({n24, n21, n18, n15, n12, n9, n6, n3}), .s1s2mux(
        S1S2mux[7]), .newDist(newDist[7]), .Accumulate(PEOut[63:56]), .Rpipe(
        Rpipe7) );
  PE_7 pe8 ( .clock(clock), .R(Rpipe7), .s1({n48, n45, n42, n39, n36, n33, n30, 
        n27}), .s2(S2), .s1s2mux(S1S2mux[8]), .newDist(newDist[8]), 
        .Accumulate(PEOut[71:64]), .Rpipe(Rpipe8) );
  PE_6 pe9 ( .clock(clock), .R(Rpipe8), .s1({n47, n44, n41, n38, n35, n32, 
        S1[1], n26}), .s2({n24, n21, n18, n15, n12, n9, n6, n3}), .s1s2mux(
        S1S2mux[9]), .newDist(newDist[9]), .Accumulate(PEOut[79:72]), .Rpipe(
        Rpipe9) );
  PE_5 pe10 ( .clock(clock), .R(Rpipe9), .s1({n48, n45, n42, n39, n36, n33, 
        n30, n27}), .s2({S2[7:5], n14, S2[3:0]}), .s1s2mux(S1S2mux[10]), 
        .newDist(newDist[10]), .Accumulate(PEOut[87:80]), .Rpipe(Rpipe10) );
  PE_4 pe11 ( .clock(clock), .R(Rpipe10), .s1({n47, n44, n41, n38, n35, n32, 
        S1[1], n26}), .s2({n24, n21, n18, n15, n12, n9, n6, n3}), .s1s2mux(
        S1S2mux[11]), .newDist(newDist[11]), .Accumulate(PEOut[95:88]), 
        .Rpipe(Rpipe11) );
  PE_3 pe12 ( .clock(clock), .R(Rpipe11), .s1({n48, n45, n42, n39, n36, n33, 
        n30, n27}), .s2({S2[7:4], n11, S2[2:0]}), .s1s2mux(S1S2mux[12]), 
        .newDist(newDist[12]), .Accumulate(PEOut[103:96]), .Rpipe(Rpipe12) );
  PE_2 pe13 ( .clock(clock), .R(Rpipe12), .s1({n48, n45, n42, n39, n36, n33, 
        n30, n27}), .s2({S2[7:2], n5, S2[0]}), .s1s2mux(S1S2mux[13]), 
        .newDist(newDist[13]), .Accumulate(PEOut[111:104]), .Rpipe(Rpipe13) );
  PE_1 pe14 ( .clock(clock), .R(Rpipe13), .s1({n47, n44, n41, n38, n35, n32, 
        S1[1], n26}), .s2({n24, n21, n18, n15, n12, n9, n6, n3}), .s1s2mux(
        S1S2mux[14]), .newDist(newDist[14]), .Accumulate(PEOut[119:112]), 
        .Rpipe(Rpipe14) );
  PE_0 pe15 ( .clock(clock), .R(Rpipe14), .s1({S1[7:3], n33, n29, S1[0]}), 
        .s2({n23, n20, n17, n14, n11, n8, n5, n2}), .s1s2mux(1'b0), .newDist(
        newDist[15]), .Accumulate(PEOut[127:120]) );
  control ctl_u ( .clock(clock), .start(start), .S1S2mux({
        SYNOPSYS_UNCONNECTED__0, S1S2mux[14:0]}), .NewDist(newDist), 
        .CompStart(CompStart), .PEready(PEready), .VectorX(VectorX), .VectorY(
        VectorY), .AddressR(AddressR), .AddressS1({AddressS1[9:5], 
        SYNOPSYS_UNCONNECTED__1, AddressS1[3:0]}), .AddressS2({
        SYNOPSYS_UNCONNECTED__2, AddressS2[8:0]}) );
  Comparator comp_u ( .clock(clock), .CompStart(CompStart), .PEout(PEOut), 
        .PEready(PEready), .vectorX(VectorX), .vectorY(VectorY), .BestDist(
        BestDist), .motionX(motionX), .motionY(motionY) );
  INVX0_LVT U1 ( .A(n37), .Y(n38) );
  INVX0_HVT U2 ( .A(n31), .Y(n32) );
  INVX0_HVT U3 ( .A(n34), .Y(n35) );
  INVX0_HVT U4 ( .A(n7), .Y(n9) );
  INVX0_HVT U5 ( .A(n10), .Y(n12) );
  INVX0_HVT U6 ( .A(n13), .Y(n15) );
  INVX0_LVT U7 ( .A(n25), .Y(n26) );
  INVX0_LVT U8 ( .A(n1), .Y(n3) );
  INVX0_LVT U9 ( .A(n4), .Y(n6) );
  INVX0_HVT U10 ( .A(n25), .Y(n27) );
  INVX0_HVT U11 ( .A(n28), .Y(n30) );
  INVX0_HVT U12 ( .A(n1), .Y(n2) );
  INVX0_HVT U13 ( .A(n4), .Y(n5) );
  INVX0_HVT U14 ( .A(n28), .Y(n29) );
  INVX0_LVT U15 ( .A(n7), .Y(n8) );
  INVX0_LVT U16 ( .A(n10), .Y(n11) );
  INVX0_LVT U17 ( .A(n13), .Y(n14) );
  INVX0_HVT U18 ( .A(n31), .Y(n33) );
  INVX0_HVT U19 ( .A(n34), .Y(n36) );
  INVX0_HVT U20 ( .A(n37), .Y(n39) );
  INVX1_LVT U21 ( .A(n40), .Y(n42) );
  INVX1_LVT U22 ( .A(n43), .Y(n45) );
  INVX1_LVT U23 ( .A(n46), .Y(n48) );
  INVX1_LVT U24 ( .A(n16), .Y(n17) );
  INVX1_LVT U25 ( .A(n19), .Y(n20) );
  INVX1_LVT U26 ( .A(n22), .Y(n23) );
  INVX1_LVT U27 ( .A(n16), .Y(n18) );
  INVX1_LVT U28 ( .A(n19), .Y(n21) );
  INVX1_LVT U29 ( .A(n22), .Y(n24) );
  INVX1_LVT U30 ( .A(n40), .Y(n41) );
  INVX1_LVT U31 ( .A(n43), .Y(n44) );
  INVX1_LVT U32 ( .A(n46), .Y(n47) );
  INVX1_LVT U33 ( .A(S1[0]), .Y(n25) );
  INVX1_LVT U34 ( .A(S2[0]), .Y(n1) );
  INVX1_LVT U35 ( .A(S1[1]), .Y(n28) );
  INVX1_LVT U36 ( .A(S2[1]), .Y(n4) );
  INVX1_LVT U37 ( .A(S1[2]), .Y(n31) );
  INVX1_LVT U38 ( .A(S2[2]), .Y(n7) );
  INVX1_LVT U39 ( .A(S1[5]), .Y(n40) );
  INVX1_LVT U40 ( .A(S2[5]), .Y(n16) );
  INVX1_LVT U41 ( .A(S1[3]), .Y(n34) );
  INVX1_LVT U42 ( .A(S2[3]), .Y(n10) );
  INVX1_LVT U43 ( .A(S1[4]), .Y(n37) );
  INVX1_LVT U44 ( .A(S2[4]), .Y(n13) );
  INVX1_LVT U45 ( .A(S1[6]), .Y(n43) );
  INVX1_LVT U46 ( .A(S2[6]), .Y(n19) );
  INVX1_LVT U47 ( .A(S1[7]), .Y(n46) );
  INVX1_LVT U48 ( .A(S2[7]), .Y(n22) );
endmodule

