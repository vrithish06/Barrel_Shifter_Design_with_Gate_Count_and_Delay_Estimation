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

module barrel_shift_16bit (in, ctrl, dir, arithmetic, out);
  input [15:0] in;            // Input data
  input [3:0] ctrl;           // Shift amount
  input dir;                  // Direction: 0 = right, 1 = left
  input arithmetic;           // Arithmetic shift control: 1 = enabled, 0 = disabled
  output [15:0] out;          // Shifted output
  wire [15:0] x, y, z;
  wire [15:0] shifted_result;

  // 8-bit shift
  mux2 mux_15(in[15], dir ? (arithmetic ? in[15] : 1'b0) : in[7], ctrl[3], x[15]);
  mux2 mux_14(in[14], dir ? (arithmetic ? in[15] : 1'b0) : in[6], ctrl[3], x[14]);
  mux2 mux_13(in[13], dir ? (arithmetic ? in[15] : 1'b0) : in[5], ctrl[3], x[13]);
  mux2 mux_12(in[12], dir ? (arithmetic ? in[15] : 1'b0) : in[4], ctrl[3], x[12]);
  mux2 mux_11(in[11], dir ?  (arithmetic ? in[15] : 1'b0) : in[3], ctrl[3], x[11]);
  mux2 mux_10(in[10], dir ?  (arithmetic ? in[15] : 1'b0) : in[2], ctrl[3], x[10]);
  mux2 mux_9(in[9], dir ?  (arithmetic ? in[15] : 1'b0) : in[1], ctrl[3], x[9]);
  mux2 mux_8(in[8], dir ?  (arithmetic ? in[15] : 1'b0) : in[0], ctrl[3], x[8]);
  mux2 mux_7(in[7], dir ? in[15] : 1'b0, ctrl[3], x[7]);
  mux2 mux_6(in[6], dir ? in[14] : 1'b0, ctrl[3], x[6]);
  mux2 mux_5(in[5], dir ? in[13] : 1'b0, ctrl[3], x[5]);
  mux2 mux_4(in[4], dir ? in[12] : 1'b0, ctrl[3], x[4]);
  mux2 mux_3(in[3], dir ? in[11] : 1'b0, ctrl[3], x[3]);
  mux2 mux_2(in[2], dir ? in[10] : 1'b0, ctrl[3], x[2]);
  mux2 mux_1(in[1], dir ? in[9] : 1'b0, ctrl[3], x[1]);
  mux2 mux_0(in[0], dir ? in[8] : 1'b0, ctrl[3], x[0]);

  // 4-bit shift
  mux2 mux_31(x[15], dir ? (arithmetic ? in[15] : 1'b0) : x[11], ctrl[2], y[15]);
  mux2 mux_30(x[14], dir ? (arithmetic ? in[15] : 1'b0) : x[10], ctrl[2], y[14]);
  mux2 mux_29(x[13], dir ? (arithmetic ? in[15] : 1'b0) : x[9], ctrl[2], y[13]);
  mux2 mux_28(x[12], dir ? (arithmetic ? in[15] : 1'b0) : x[8], ctrl[2], y[12]);
  mux2 mux_27(x[11], dir ? x[15] : x[7], ctrl[2], y[11]);
  mux2 mux_26(x[10], dir ? x[14] : x[6], ctrl[2], y[10]);
  mux2 mux_25(x[9], dir ? x[13] : x[5], ctrl[2], y[9]);
  mux2 mux_24(x[8], dir ? x[12] : x[4], ctrl[2], y[8]);
  mux2 mux_23(x[7], dir ? x[11] : x[3], ctrl[2], y[7]);
  mux2 mux_22(x[6], dir ? x[10] : x[2], ctrl[2], y[6]);
  mux2 mux_21(x[5], dir ? x[9] : x[1], ctrl[2], y[5]);
  mux2 mux_20(x[4], dir ? x[8] : x[0], ctrl[2], y[4]);
  mux2 mux_19(x[3], dir ? x[7] : 1'b0, ctrl[2], y[3]);
  mux2 mux_18(x[2], dir ? x[6] : 1'b0, ctrl[2], y[2]);
  mux2 mux_17(x[1], dir ? x[5] : 1'b0, ctrl[2], y[1]);
  mux2 mux_16(x[0], dir ? x[4] : 1'b0, ctrl[2], y[0]);

  // 2-bit shift
  mux2 mux_47(y[15], dir ? (arithmetic ? in[15] : 1'b0) : y[13], ctrl[1], z[15]);
  mux2 mux_46(y[14], dir ? (arithmetic ? in[15] : 1'b0) : y[12], ctrl[1], z[14]);
  mux2 mux_45(y[13], dir ? y[15] : y[11], ctrl[1], z[13]);
  mux2 mux_44(y[12], dir ? y[14] : y[10], ctrl[1], z[12]);
  mux2 mux_43(y[11], dir ? y[13] : y[9], ctrl[1], z[11]);
  mux2 mux_42(y[10], dir ? y[12] : y[8], ctrl[1], z[10]);
  mux2 mux_41(y[9], dir ? y[11] : y[7], ctrl[1], z[9]);
  mux2 mux_40(y[8], dir ? y[10] : y[6], ctrl[1], z[8]);
  mux2 mux_39(y[7], dir ? y[9] : y[5], ctrl[1], z[7]);
  mux2 mux_38(y[6], dir ? y[8] : y[4], ctrl[1], z[6]);
  mux2 mux_37(y[5], dir ? y[7] : y[3], ctrl[1], z[5]);
  mux2 mux_36(y[4], dir ? y[6] : y[2], ctrl[1], z[4]);
  mux2 mux_35(y[3], dir ? y[5] : y[1], ctrl[1], z[3]);
  mux2 mux_34(y[2], dir ? y[4] : y[0], ctrl[1], z[2]);
  mux2 mux_33(y[1], dir ? y[3] : 1'b0, ctrl[1], z[1]);
  mux2 mux_32(y[0], dir ? y[2] : 1'b0, ctrl[1], z[0]);

  // 1-bit shift
  mux2 mux_63(z[15], dir ? (arithmetic ? in[15] : 1'b0) : z[14], ctrl[0], shifted_result[15]);
  mux2 mux_62(z[14], dir ? z[15] : z[13], ctrl[0], shifted_result[14]);
  mux2 mux_61(z[13], dir ? z[14] : z[12], ctrl[0], shifted_result[13]);
  mux2 mux_60(z[12], dir ? z[13] : z[11], ctrl[0], shifted_result[12]);
  mux2 mux_59(z[11], dir ? z[12] : z[10], ctrl[0], shifted_result[11]);
  mux2 mux_58(z[10], dir ? z[11] : z[9], ctrl[0], shifted_result[10]);
  mux2 mux_57(z[9], dir ? z[10] : z[8], ctrl[0], shifted_result[9]);
  mux2 mux_56(z[8], dir ? z[9] : z[7], ctrl[0], shifted_result[8]);
  mux2 mux_55(z[7], dir ? z[8] : z[6], ctrl[0], shifted_result[7]);
  mux2 mux_54(z[6], dir ? z[7] : z[5], ctrl[0], shifted_result[6]);
  mux2 mux_53(z[5], dir ? z[6] : z[4], ctrl[0], shifted_result[5]);
  mux2 mux_52(z[4], dir ? z[5] : z[3], ctrl[0], shifted_result[4]);
  mux2 mux_51(z[3], dir ? z[4] : z[2], ctrl[0], shifted_result[3]);
  mux2 mux_50(z[2], dir ? z[3] : z[1], ctrl[0], shifted_result[2]);
  mux2 mux_49(z[1], dir ? z[2] : z[0], ctrl[0], shifted_result[1]);
  mux2 mux_48(z[0], dir ? z[1] : 1'b0, ctrl[0], shifted_result[0]);

  assign out = shifted_result;

endmodule

`timescale 100 ns / 100 ps
module tb_barrel_shift_16bit;
  reg [15:0] in;
  reg [3:0] ctrl;
  reg dir;        // Direction control (0 for right, 1 for left)
  reg arithmetic; // Arithmetic shift control (1 for arithmetic shift)
  wire [15:0] out;

  // Instantiate the barrel shifter with arithmetic control
  barrel_shift_16bit bs(.in(in), .ctrl(ctrl), .dir(dir), .arithmetic(arithmetic), .out(out));

  initial begin
    $dumpfile("tb_project.vcd");
    $dumpvars(0, tb_barrel_shift_16bit);
    $display($time, " << Starting the Simulation >>");

    // Test cases for right shifts with arithmetic and logical shift
    dir = 0; arithmetic = 1;
    in = 16'b1101000000010001; ctrl = 4'd2; #5;  // Arithmetic right shift
    in = 16'b1101000000010001; ctrl = 4'd4; #5;  // Arithmetic right shift
    in = 16'b1101000000010001; ctrl = 4'd8; #5;  // Arithmetic right shift

    dir = 0; arithmetic = 0;
    in = 16'b1101000000010001; ctrl = 4'd2; #5;  // Logical right shift
    in = 16'b1101000000010001; ctrl = 4'd4; #5;  // Logical right shift
    in = 16'b1101000000010001; ctrl = 4'd8; #5;  // Logical right shift

    // Test cases for left shifts with arithmetic and logical shift
    dir = 1; arithmetic = 1;
    in = 16'b1101000000010001; ctrl = 4'd2; #5;  // Arithmetic left shift
    in = 16'b1101000000010001; ctrl = 4'd4; #5;  // Arithmetic left shift
    in = 16'b1101000000010001; ctrl = 4'd8; #5;  // Arithmetic left shift

    dir = 1; arithmetic = 0;
    in = 16'b1101000000010001; ctrl = 4'd2; #5;  // Logical left shift
    in = 16'b1101000000010001; ctrl = 4'd4; #5;  // Logical left shift
    in = 16'b1101000000010001; ctrl = 4'd8; #5;  // Logical left shift

    $finish;
  end

  initial begin
    $monitor($time, " dir=%b, arithmetic=%b, Input=%b, Control=%d, Output=%b", dir, arithmetic, in, ctrl, out);
  end
endmodule

