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

module barrel_shift_8bit (in, ctrl, dir, arithmetic, out);
  input [7:0] in;
  input [3:0] ctrl; // Changed ctrl to 4 bits
  input dir;
  input arithmetic;
  output reg [7:0] out; // Declare out as reg for use in the always block
  wire [7:0] x, y;
  wire [7:0] shifted_result;

  reg error_flag = 0; // Flag to prevent multiple error messages

  // 4-bit shift (First stage of shift)
  mux2 mux_7(in[7], dir ? (arithmetic ? in[7] : 1'b0) : in[3], ctrl[2], x[7]);
  mux2 mux_6(in[6], dir ? (arithmetic ? in[7] : 1'b0) : in[2], ctrl[2], x[6]);
  mux2 mux_5(in[5], dir ? (arithmetic ? in[7] : 1'b0) : in[1], ctrl[2], x[5]);
  mux2 mux_4(in[4], dir ? (arithmetic ? in[7] : 1'b0) : in[0], ctrl[2], x[4]);
  mux2 mux_3(in[3], dir ? in[7] : 1'b0, ctrl[2], x[3]);
  mux2 mux_2(in[2], dir ? in[6] : 1'b0, ctrl[2], x[2]);
  mux2 mux_1(in[1], dir ? in[5] : 1'b0, ctrl[2], x[1]);
  mux2 mux_0(in[0], dir ? in[4] : 1'b0, ctrl[2], x[0]);

  // 2-bit shift (Second stage of shift)
  mux2 mux_15(x[7], dir ? (arithmetic ? in[7] : 1'b0) : x[5], ctrl[1], y[7]);
  mux2 mux_14(x[6], dir ? (arithmetic ? in[7] : 1'b0) : x[4], ctrl[1], y[6]);
  mux2 mux_13(x[5], dir ? x[7] : x[3], ctrl[1], y[5]);
  mux2 mux_12(x[4], dir ? x[6] : x[2], ctrl[1], y[4]);
  mux2 mux_11(x[3], dir ? x[5] : x[1], ctrl[1], y[3]);
  mux2 mux_10(x[2], dir ? x[4] : x[0], ctrl[1], y[2]);
  mux2 mux_9(x[1], dir ? x[3] : 1'b0, ctrl[1], y[1]);
  mux2 mux_8(x[0], dir ? x[2] : 1'b0, ctrl[1], y[0]);

  // 1-bit shift (Final stage of shift)
  mux2 mux_23(y[7], dir ? (arithmetic ? in[7] : 1'b0) : y[6], ctrl[0], shifted_result[7]);
  mux2 mux_22(y[6], dir ? y[7] : y[5], ctrl[0], shifted_result[6]);
  mux2 mux_21(y[5], dir ? y[6] : y[4], ctrl[0], shifted_result[5]);
  mux2 mux_20(y[4], dir ? y[5] : y[3], ctrl[0], shifted_result[4]);
  mux2 mux_19(y[3], dir ? y[4] : y[2], ctrl[0], shifted_result[3]);
  mux2 mux_18(y[2], dir ? y[3] : y[1], ctrl[0], shifted_result[2]);
  mux2 mux_17(y[1], dir ? y[2] : y[0], ctrl[0], shifted_result[1]);
  mux2 mux_16(y[0], dir ? y[1] : 1'b0, ctrl[0], shifted_result[0]);

  always @(*) begin
    if (ctrl > 7) begin
      out = 8'b0; // Output zeros for invalid shift
      if (!error_flag) begin
        $display("ERROR: Invalid shift amount ctrl=%d | Shift value must be in range [0, 7]", ctrl);
        error_flag = 1; // Set the flag to prevent multiple messages
      end
    end else begin
      out = shifted_result; // Assign the computed shifted result
      error_flag = 0; // Reset the flag if inputs are valid
    end
  end
endmodule


`timescale 100 ns / 100 ps
module tb_barrel_shift_8bit;
  reg [7:0] in;
  reg [3:0] ctrl; // Changed ctrl to 4 bits in testbench as well
  reg dir;        // Direction control (0 for right, 1 for left)
  reg arithmetic; // Arithmetic shift control (1 for arithmetic shift)
  wire [7:0] out;

  // Instantiate the barrel shifter with arithmetic control
  barrel_shift_8bit bs(.in(in), .ctrl(ctrl), .dir(dir), .arithmetic(arithmetic), .out(out));

  initial begin
    $dumpfile("tb_project_8bit.vcd");
    $dumpvars(0, tb_barrel_shift_8bit);
    $display($time, " << Starting the Simulation >>");

    // Right shifts with arithmetic shift (dir=0, arithmetic=1)
    dir = 0; arithmetic = 1; 
    in = 8'b11010001; ctrl = 4'd2; #5;  // Arithmetic right shift
    in = 8'b11010001; ctrl = 4'd4; #5;  // Arithmetic right shift

    // Left shifts (dir=1)
    dir = 1; arithmetic = 1; 
    in = 8'b11010001; ctrl = 4'd10; #5;  // Left shift (arithmetic)
    in = 8'b11010001; ctrl = 4'd7; #5;  // Left shift (arithmetic)
    dir = 1; arithmetic = 0; 
    in = 8'b11010001; ctrl = 4'd2; #5;  // Left shift (logical)
    in = 8'b11010001; ctrl = 4'd7; #5;  // Left shift (logical)

    // Right shifts (dir=0) with logical shift (arithmetic=0)
    dir = 0; arithmetic = 0;
    in = 8'b11010001; ctrl = 4'd8; #5;  // Logical right shift
    in = 8'b11010001; ctrl = 4'd1; #5;  // Logical right shift

    $finish;
  end

  initial begin
    // Monitor signals with formatted output for better readability
    $monitor($time, " | dir=%b | arithmetic=%b | Input=%b | Control=%d | Output=%b |",
              dir, arithmetic, in, ctrl, out);
  end
endmodule
