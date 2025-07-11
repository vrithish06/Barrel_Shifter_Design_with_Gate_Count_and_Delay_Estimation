module and_gate (
    input wire a,  // Input A
    input wire b,  // Input B
    output wire out // Output
);

assign out = a & b; // AND operation

endmodule
module or_gate (
    input wire a,  // Input A
    input wire b,  // Input B
    output wire out // Output
);

assign out = a | b; // OR operation

endmodule
module mux2 (
    input wire i0,   // Input i0
    input wire i1,   // Input i1
    input wire j,    // Control signal
    output wire o    // Output
);

wire and1_out, and2_out; // Intermediate outputs of AND gates

// First AND gate: i0 AND NOT(j)
and (and1_out, i0, ~j);

// Second AND gate: i1 AND j
and (and2_out, i1, j);

// OR gate: Combine the outputs of the two AND gates
or (o, and1_out, and2_out);

endmodule

module barrel_shift_32bit (in, ctrl, dir, arithmetic, out);
  input [31:0] in;            // Input data
  input [4:0] ctrl;           // Shift amount
  input dir;                  // Direction: 1 = right, 0 = left
  input arithmetic;           // Arithmetic shift control: 1 = enabled, 0 = disabled
  output [31:0] out;          // Shifted output
  wire [31:0] w,x,y,z;
  wire [31:0] shifted_result;
 
 // 16-bit shift
mux2 mux_31(in[31], dir ? (arithmetic ? in[31] : 1'b0) : in[15], ctrl[4], w[31]);
mux2 mux_30(in[30], dir ? (arithmetic ? in[31] : 1'b0) : in[14], ctrl[4], w[30]);
mux2 mux_29(in[29], dir ? (arithmetic ? in[31] : 1'b0) : in[13], ctrl[4], w[29]);
mux2 mux_28(in[28], dir ? (arithmetic ? in[31] : 1'b0) : in[12], ctrl[4], w[28]);
mux2 mux_27(in[27], dir ? (arithmetic ? in[31] : 1'b0) : in[11], ctrl[4], w[27]);
mux2 mux_26(in[26], dir ? (arithmetic ? in[31] : 1'b0) : in[10], ctrl[4], w[26]);
mux2 mux_25(in[25], dir ? (arithmetic ? in[31] : 1'b0) : in[9], ctrl[4], w[25]);
mux2 mux_24(in[24], dir ? (arithmetic ? in[31] : 1'b0) : in[8], ctrl[4], w[24]);
mux2 mux_23(in[23], dir ? (arithmetic ? in[31] : 1'b0) : in[7], ctrl[4], w[23]);
mux2 mux_22(in[22], dir ? (arithmetic ? in[31] : 1'b0) : in[6], ctrl[4], w[22]);
mux2 mux_21(in[21], dir ? (arithmetic ? in[31] : 1'b0) : in[5], ctrl[4], w[21]);
mux2 mux_20(in[20], dir ? (arithmetic ? in[31] : 1'b0) : in[4], ctrl[4], w[20]);
mux2 mux_19(in[19], dir ? (arithmetic ? in[31] : 1'b0) : in[3], ctrl[4], w[19]);
mux2 mux_18(in[18], dir ? (arithmetic ? in[31] : 1'b0) : in[2], ctrl[4], w[18]);
mux2 mux_17(in[17], dir ? (arithmetic ? in[31] : 1'b0) : in[1], ctrl[4], w[17]);
mux2 mux_16(in[16], dir ? (arithmetic ? in[31] : 1'b0) : in[0], ctrl[4], w[16]);
mux2 mux_15(in[15], dir ? in[31] : 1'b0, ctrl[4], w[15]);
mux2 mux_14(in[14], dir ? in[30] : 1'b0, ctrl[4], w[14]);
mux2 mux_13(in[13], dir ? in[29] : 1'b0, ctrl[4], w[13]);
mux2 mux_12(in[12], dir ? in[28] : 1'b0, ctrl[4], w[12]);
mux2 mux_11(in[11], dir ? in[27] : 1'b0, ctrl[4], w[11]);
mux2 mux_10(in[10], dir ? in[26] : 1'b0, ctrl[4], w[10]);
mux2 mux_9(in[9], dir ? in[25] : 1'b0, ctrl[4], w[9]);
mux2 mux_8(in[8], dir ? in[24] : 1'b0, ctrl[4], w[8]);
mux2 mux_7(in[7], dir ? in[23] : 1'b0, ctrl[4], w[7]);
mux2 mux_6(in[6], dir ? in[22] : 1'b0, ctrl[4], w[6]);
mux2 mux_5(in[5], dir ? in[21] : 1'b0, ctrl[4], w[5]);
mux2 mux_4(in[4], dir ? in[20] : 1'b0, ctrl[4], w[4]);
mux2 mux_3(in[3], dir ? in[19] : 1'b0, ctrl[4], w[3]);
mux2 mux_2(in[2], dir ? in[18] : 1'b0, ctrl[4], w[2]);
mux2 mux_1(in[1], dir ? in[17] : 1'b0, ctrl[4], w[1]);
mux2 mux_0(in[0], dir ? in[16] : 1'b0, ctrl[4], w[0]);

 // 8-bit shift
 mux2 mux_63(w[31], dir ? (arithmetic ? w[31] : 1'b0) : w[23], ctrl[3], x[31]);
mux2 mux_62(w[30], dir ? (arithmetic ? w[31] : 1'b0) : w[24], ctrl[3], x[30]);
mux2 mux_61(w[29], dir ? (arithmetic ? w[31] : 1'b0) : w[23], ctrl[3], x[29]);
mux2 mux_60(w[28], dir ? (arithmetic ? w[31] : 1'b0) : w[22], ctrl[3], x[28]);
mux2 mux_59(w[27], dir ? (arithmetic ? w[31] : 1'b0) : w[21], ctrl[3], x[27]);
mux2 mux_58(w[26], dir ? (arithmetic ? w[31] : 1'b0) : w[20], ctrl[3], x[26]);
mux2 mux_57(w[25], dir ? (arithmetic ? w[31] : 1'b0) : w[18], ctrl[3], x[25]);
mux2 mux_56(w[24], dir ? (arithmetic ? w[31] : 1'b0) : w[18], ctrl[3], x[24]);
mux2 mux_55(w[23], dir ? w[31] : w[17], ctrl[3], x[23]);
mux2 mux_54(w[22], dir ? w[30] : w[16], ctrl[3], x[22]);
mux2 mux_53(w[21], dir ? w[29] : w[15], ctrl[3], x[21]);
mux2 mux_52(w[20], dir ? w[28] : w[14], ctrl[3], x[20]);
mux2 mux_51(w[19], dir ? w[27] : w[13], ctrl[3], x[19]);
mux2 mux_50(w[18], dir ? w[26] : w[12], ctrl[3], x[18]);
mux2 mux_49(w[17], dir ? w[25] : w[9], ctrl[3], x[17]);
mux2 mux_48(w[16], dir ? w[24] : w[8], ctrl[3], x[16]);
mux2 mux_47(w[15], dir ? w[23] : w[7], ctrl[3], x[15]);
mux2 mux_46(w[14], dir ? w[22] : w[6], ctrl[3], x[14]);
mux2 mux_45(w[13], dir ? w[21] : w[5], ctrl[3], x[13]);
mux2 mux_44(w[12], dir ? w[20] : w[4], ctrl[3], x[12]);
mux2 mux_43(w[11], dir ? w[19] : w[3], ctrl[3], x[11]);
mux2 mux_42(w[10], dir ? w[18] : w[2], ctrl[3], x[10]);
mux2 mux_41(w[9], dir ? w[17] : w[1], ctrl[3], x[9]);
mux2 mux_40(w[8], dir ? w[16] : w[0], ctrl[3], x[8]);
mux2 mux_39(w[7], dir ? w[15] : 1'b0, ctrl[3], x[7]);
mux2 mux_38(w[6], dir ? w[14] : 1'b0, ctrl[3], x[6]);
mux2 mux_37(w[5], dir ? w[13] : 1'b0, ctrl[3], x[5]);
mux2 mux_36(w[4], dir ? w[12] : 1'b0, ctrl[3], x[4]);
mux2 mux_35(w[3], dir ? w[11] : 1'b0, ctrl[3], x[3]);
mux2 mux_34(w[2], dir ? w[10] : 1'b0, ctrl[3], x[2]);
mux2 mux_33(w[1], dir ? w[9] : 1'b0, ctrl[3], x[1]);
mux2 mux_32(w[0], dir ? w[8] : 1'b0, ctrl[3], x[0]);

  
 // 4-bit shift
mux2 mux_95(x[31], dir ? (arithmetic ? x[31] : 1'b0) : x[27], ctrl[2], y[31]);
mux2 mux_94(x[30], dir ? (arithmetic ? x[31] : 1'b0) : x[26], ctrl[2], y[30]);
mux2 mux_93(x[29], dir ? (arithmetic ? x[31] : 1'b0) : x[25], ctrl[2], y[29]);
mux2 mux_92(x[28], dir ? (arithmetic ? x[31] : 1'b0) : x[24], ctrl[2], y[28]);
mux2 mux_91(x[27], dir ? x[31] : x[23], ctrl[2], y[27]);
mux2 mux_90(x[26], dir ? x[30] : x[22], ctrl[2], y[26]);
mux2 mux_89(x[25], dir ? x[29] : x[21], ctrl[2], y[25]);
mux2 mux_88(x[24], dir ? x[28] : x[20], ctrl[2], y[24]);
mux2 mux_87(x[23], dir ? x[27] : x[19], ctrl[2], y[23]);
mux2 mux_86(x[22], dir ? x[26] : x[18], ctrl[2], y[22]);
mux2 mux_85(x[21], dir ? x[25] : x[17], ctrl[2], y[21]);
mux2 mux_84(x[20], dir ? x[24] : x[16], ctrl[2], y[20]);
mux2 mux_83(x[19], dir ? x[23] : x[15], ctrl[2], y[19]);
mux2 mux_82(x[18], dir ? x[22] : x[14], ctrl[2], y[18]);
mux2 mux_81(x[17], dir ? x[21] : x[13], ctrl[2], y[17]);
mux2 mux_80(x[16], dir ? x[20] : x[12], ctrl[2], y[16]);
mux2 mux_79(x[15], dir ? x[19] : x[11], ctrl[2], y[15]);
mux2 mux_78(x[14], dir ? x[18] : x[10], ctrl[2], y[14]);
mux2 mux_77(x[13], dir ? x[17] : x[9], ctrl[2], y[13]);
mux2 mux_76(x[12], dir ? x[16] : x[8], ctrl[2], y[12]);
mux2 mux_75(x[11], dir ? x[15] : x[7], ctrl[2], y[11]);
mux2 mux_74(x[10], dir ? x[14] : x[6], ctrl[2], y[10]);
mux2 mux_73(x[9], dir ? x[13] : x[5], ctrl[2], y[9]);
mux2 mux_72(x[8], dir ? x[12] : x[4], ctrl[2], y[8]);
mux2 mux_71(x[7], dir ? x[11] : x[3], ctrl[2], y[7]);
mux2 mux_70(x[6], dir ? x[10] : x[2], ctrl[2], y[6]);
mux2 mux_69(x[5], dir ? x[9] : x[1], ctrl[2], y[5]);
mux2 mux_68(x[4], dir ? x[8] : x[0], ctrl[2], y[4]);
mux2 mux_67(x[3], dir ? x[7] : 1'b0, ctrl[2], y[3]);
mux2 mux_66(x[2], dir ? x[6] : 1'b0, ctrl[2], y[2]);
mux2 mux_65(x[1], dir ? x[5] : 1'b0, ctrl[2], y[1]);
mux2 mux_64(x[0], dir ? x[4] : 1'b0, ctrl[2], y[0]);
 
 // 2-bit shift
mux2 mux_127(y[31], dir ? (arithmetic ? y[31] : 1'b0) : y[29], ctrl[1], z[31]);
mux2 mux_126(y[30], dir ? (arithmetic ? y[31] : 1'b0) : y[28], ctrl[1], z[30]);
mux2 mux_125(y[29], dir ? y[31] : y[27], ctrl[1], z[29]);
mux2 mux_124(y[28], dir ? y[30] : y[26], ctrl[1], z[28]);
mux2 mux_123(y[27], dir ? y[29] : y[25], ctrl[1], z[27]);
mux2 mux_122(y[26], dir ? y[28] : y[24], ctrl[1], z[26]);
mux2 mux_121(y[25], dir ? y[27] : y[23], ctrl[1], z[25]);
mux2 mux_120(y[24], dir ? y[26] : y[22], ctrl[1], z[24]);
mux2 mux_119(y[23], dir ? y[25] : y[21], ctrl[1], z[23]);
mux2 mux_118(y[22], dir ? y[24] : y[20], ctrl[1], z[22]);
mux2 mux_117(y[21], dir ? y[23] : y[19], ctrl[1], z[21]);
mux2 mux_116(y[20], dir ? y[22] : y[18], ctrl[1], z[20]);
mux2 mux_115(y[19], dir ? y[21] : y[17], ctrl[1], z[19]);
mux2 mux_114(y[18], dir ? y[20] : y[16], ctrl[1], z[18]);
mux2 mux_113(y[17], dir ? y[19] : y[15], ctrl[1], z[17]);
mux2 mux_112(y[16], dir ? y[18] : y[14], ctrl[1], z[16]);
mux2 mux_111(y[15], dir ? y[17] : y[13], ctrl[1], z[15]);
mux2 mux_110(y[14], dir ? y[16] : y[12], ctrl[1], z[14]);
mux2 mux_109(y[13], dir ? y[15] : y[11], ctrl[1], z[13]);
mux2 mux_108(y[12], dir ? y[14] : y[10], ctrl[1], z[12]);
mux2 mux_107(y[11], dir ? y[13] : y[9], ctrl[1], z[11]);
mux2 mux_106(y[10], dir ? y[12] : y[8], ctrl[1], z[10]);
mux2 mux_105(y[9], dir ? y[11] : y[7], ctrl[1], z[9]);
mux2 mux_104(y[8], dir ? y[10] : y[6], ctrl[1], z[8]);
mux2 mux_103(y[7], dir ? y[9] : y[5], ctrl[1], z[7]);
mux2 mux_102(y[6], dir ? y[8] : y[4], ctrl[1], z[6]);
mux2 mux_101(y[5], dir ? y[7] : y[3], ctrl[1], z[5]);
mux2 mux_100(y[4], dir ? y[6] : y[2], ctrl[1], z[4]);
mux2 mux_99(y[3], dir ? y[5] : y[1], ctrl[1], z[3]);
mux2 mux_98(y[2], dir ? y[4] : y[0], ctrl[1], z[2]);
mux2 mux_97(y[1], dir ? y[3] : 1'b0, ctrl[1], z[1]);
mux2 mux_96(y[0], dir ? y[2] : 1'b0, ctrl[1], z[0]);

 // 1-bit shift
mux2 mux_159(z[31], dir ? (arithmetic ? in[31] : 1'b0) : z[30], ctrl[0], shifted_result[31]);
mux2 mux_158(z[30], dir ? z[31] : z[29], ctrl[0], shifted_result[30]);
mux2 mux_157(z[29], dir ? z[30] : z[28], ctrl[0], shifted_result[29]);
mux2 mux_156(z[28], dir ? z[29] : z[27], ctrl[0], shifted_result[28]);
mux2 mux_155(z[27], dir ? z[28] : z[26], ctrl[0], shifted_result[27]);
mux2 mux_154(z[26], dir ? z[27] : z[25], ctrl[0], shifted_result[26]);
mux2 mux_153(z[25], dir ? z[26] : z[24], ctrl[0], shifted_result[25]);
mux2 mux_152(z[24], dir ? z[25] : z[23], ctrl[0], shifted_result[24]);
mux2 mux_151(z[23], dir ? z[24] : z[22], ctrl[0], shifted_result[23]);
mux2 mux_150(z[22], dir ? z[23] : z[21], ctrl[0], shifted_result[22]);
mux2 mux_149(z[21], dir ? z[22] : z[20], ctrl[0], shifted_result[21]);
mux2 mux_148(z[20], dir ? z[21] : z[19], ctrl[0], shifted_result[20]);
mux2 mux_147(z[19], dir ? z[20] : z[18], ctrl[0], shifted_result[19]);
mux2 mux_146(z[18], dir ? z[19] : z[17], ctrl[0], shifted_result[18]);
mux2 mux_145(z[17], dir ? z[18] : z[16], ctrl[0], shifted_result[17]);
mux2 mux_144(z[16], dir ? z[17] : z[15], ctrl[0], shifted_result[16]);
mux2 mux_143(z[15], dir ? z[16] : z[14], ctrl[0], shifted_result[15]);
mux2 mux_142(z[14], dir ? z[15] : z[13], ctrl[0], shifted_result[14]);
mux2 mux_141(z[13], dir ? z[14] : z[12], ctrl[0], shifted_result[13]);
mux2 mux_140(z[12], dir ? z[13] : z[11], ctrl[0], shifted_result[12]);
mux2 mux_139(z[11], dir ? z[12] : z[10], ctrl[0], shifted_result[11]);
mux2 mux_138(z[10], dir ? z[11] : z[9], ctrl[0], shifted_result[10]);
mux2 mux_137(z[9], dir ? z[10] : z[8], ctrl[0], shifted_result[9]);
mux2 mux_136(z[8], dir ? z[9] : z[7], ctrl[0], shifted_result[8]);
mux2 mux_135(z[7], dir ? z[8] : z[6], ctrl[0], shifted_result[7]);
mux2 mux_134(z[6], dir ? z[7] : z[5], ctrl[0], shifted_result[6]);
mux2 mux_133(z[5], dir ? z[6] : z[4], ctrl[0], shifted_result[5]);
mux2 mux_132(z[4], dir ? z[5] : z[3], ctrl[0], shifted_result[4]);
mux2 mux_131(z[3], dir ? z[4] : z[2], ctrl[0], shifted_result[3]);
mux2 mux_130(z[2], dir ? z[3] : z[1], ctrl[0], shifted_result[2]);
mux2 mux_129(z[1], dir ? z[2] : z[0], ctrl[0], shifted_result[1]);
mux2 mux_128(z[0], dir ? z[1] : 1'b0, ctrl[0], shifted_result[0]);

    assign out = shifted_result;
endmodule
`timescale 100 ns / 100 ps
module tb_barrel_shift_32bit;
  reg [31:0] in;            // 32-bit input
  reg [4:0] ctrl;           // Control signal (5-bit to accommodate 32-bit shifts)
  reg dir;                  // Direction control (0 for right, 1 for left)
  reg arithmetic;           // Arithmetic shift control (1 for arithmetic shift)
  wire [31:0] out;          // 32-bit output

  // Instantiate the barrel shifter with arithmetic control
  barrel_shift_32bit bs(.in(in), .ctrl(ctrl), .dir(dir), .arithmetic(arithmetic), .out(out));

  initial begin
    $dumpfile("tb_project_32bit.vcd");
    $dumpvars(0, tb_barrel_shift_32bit);
    $display($time, " << Starting the Simulation >>");

    // Right shifts with arithmetic shift (dir=0, arithmetic=1)
    dir = 0; arithmetic = 1; // Arithmetic right shift
    in = 32'b11010000000100011110000000011001; ctrl = 5'd2; #5;
    in = 32'b11010000000100011110000000011001; ctrl = 5'd4; #5;

    dir = 1; arithmetic = 1; // Logical left shift
    in = 32'b11010000000100011110000000011001; ctrl = 5'd2; #5;
    in = 32'b11010000000100011110000000011001; ctrl = 5'd8; #5;

    dir = 0; arithmetic = 1; // Logical right shift
    in = 32'b11010000000100011110000000011001; ctrl = 5'd4; #5;
    in = 32'b11010000000100011110000000011001; ctrl = 5'd16; #5;

    dir = 0; arithmetic = 1; // Arithmetic right shift
    in = 32'b11010000000100011110000000011001; ctrl = 5'd8; #5;


    dir = 0; arithmetic = 1;
    in = 32'b11010000000100011001000001000101; ctrl = 5'd2; #5;  // Arithmetic right shift
    in = 32'b11010000000100011001000001000101; ctrl = 5'd4; #5;  // Arithmetic right shift

    // Left shifts (dir=1)
    dir = 1; arithmetic = 0; 
    in = 32'b11010000000100011001000001000101; ctrl = 5'd2; #5;  // Left shift (logical)
    in = 32'b11010000000100011001000001000101; ctrl = 5'd8; #5;  // Left shift (logical)

    // Right shifts (dir=0) with logical shift (arithmetic=0)
    dir = 1; arithmetic = 1;
    in = 32'b11010000000100011001000001000101; ctrl = 5'd2; #5;  // Logical right shift
    in = 32'b11010000000100011001000001000101; ctrl = 5'd16; #5;  // Logical right shift

    // Arithmetic right shift (dir=0, arithmetic=1)
    dir = 0; arithmetic = 1;
    in = 32'b11010000000100011001000001000101; ctrl = 5'd2; #5;  // Arithmetic right shift
    in = 32'b11010000000100011001000001000101; ctrl = 5'd4; #5;  // Arithmetic right shift

    $finish;
  end

  initial begin
    $monitor($time, " dir=%b, arithmetic=%b, Input=%b, Control=%d, Output=%b", dir, arithmetic, in, ctrl, out);
  end
endmodule
