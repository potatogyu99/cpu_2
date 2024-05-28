module CPU (
  input wire clk,
  input wire reset
);
  wire [15:0] pc_out, mar_out, ir_out, acc_out;
  wire [15:0] mbr_out, alu_result, mem_data_out;
  wire pc_write, mar_write, mbr_write, ir_write, acc_write, mem_read, mem_write, is_load_store;
  wire [3:0] opcode;
  wire [11:0] operand;
  wire [2:0] alu_opcode; // ALU opcode signal added

  assign opcode = ir_out[15:12];
  assign operand = ir_out[11:0];

  // Instantiate Memory
  Memory mem (
    .clk(clk),
    .we(mem_write),
    .addr(mar_out),  
    .data_in(acc_out),
    .data_out(mem_data_out)
  );

  // Instantiate Register File
  RegisterFile rf (
    .clk(clk),
    .reset(reset),
    .pc_write(pc_write),
    .mar_write(mar_write),
    .mbr_write(mbr_write),
    .ir_write(ir_write),
    .acc_write(acc_write),
    .pc_in(pc_out),
    .mar_in(operand),
    .mbr_in(mem_data_out), 
    .ir_in(mem_data_out), 
    .acc_in(is_load_store ? mem_data_out : alu_result),
    .pc_out(pc_out),
    .mar_out(mar_out),
    .mbr_out(mbr_out), 
    .ir_out(ir_out),
    .acc_out(acc_out)
  );

  // Instantiate ALU
  ALU alu (
    .opcode(alu_opcode), 
    .operand1(acc_out[7:0]), 
    .operand2(operand[7:0]),
    .result(alu_result)
  );

  // Instantiate Control Unit
  ControlUnit cu (
    .clk(clk),
    .reset(reset),
    .opcode(opcode),
    .pc_write(pc_write),
    .mar_write(mar_write),
    .mbr_write(mbr_write),
    .ir_write(ir_write),
    .acc_write(acc_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .alu_opcode(alu_opcode), 
    .is_load_store(is_load_store)
  );
endmodule 