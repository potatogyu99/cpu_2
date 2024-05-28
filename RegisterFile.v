module RegisterFile (
  input wire clk,
  input wire reset,
  input wire pc_write,
  input wire mar_write,
  input wire mbr_write,
  input wire ir_write,
  input wire acc_write,
  input wire [15:0] pc_in,
  input wire [15:0] mar_in,
  input wire [15:0] mbr_in,
  input wire [15:0] ir_in,
  input wire [15:0] acc_in,
  output wire [15:0] pc_out,
  output wire [15:0] mar_out,
  output wire [15:0] mbr_out,
  output wire [15:0] ir_out,
  output wire [15:0] acc_out
);
  ProgramCounter pc (.clk(clk), .reset(reset), .pc_write(pc_write), .pc_in(pc_in), .pc_out(pc_out));
  MemoryAddressRegister mar (.clk(clk), .reset(reset), .mar_write(mar_write), .mar_in(mar_in), .mar_out(mar_out));
  MemoryBufferRegister mbr (.clk(clk), .reset(reset), .mbr_write(mbr_write), .mbr_in(mbr_in), .mbr_out(mbr_out));
  InstructionRegister ir (.clk(clk), .reset(reset), .ir_write(ir_write), .ir_in(ir_in), .ir_out(ir_out));
  Accumulator acc (.clk(clk), .reset(reset), .acc_write(acc_write), .acc_in(acc_in), .acc_out(acc_out));
endmodule
