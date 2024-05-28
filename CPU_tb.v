`timescale 1ns / 1ps

module CPU_tb;

  // Inputs
  reg clk;
  reg reset;

  // Instantiate the CPU
  CPU cpu_inst (
    .clk(clk),
    .reset(reset)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test scenarios
  initial begin
    // Initialize
    reset = 1;
    #10
    reset = 0;

    // Wait for a few clock cycles
    #20

    // Test Case 1: ADD instruction
    // Expected: Memory location 10 contains 0x1000 + 0x000A = 0x100A
    cpu_inst.mem[0] = 16'h1000; // LOAD instruction (opcode: 0x8, operand: 0x001) to load data from memory address 1
    cpu_inst.mem[1] = 16'h000A; // Data to be loaded
    cpu_inst.mem[2] = 16'h0001; // Store the value of the accumulator into memory address 10
    cpu_inst.mem[3] = 16'h900A; // Address to store the result

    // Wait for execution
    #40 

    // Test Case 2: SUB instruction
    // Expected: Memory location 11 contains 0x100A - 0x0005 = 0x1005
    cpu_inst.mem[4] = 16'h8003; // LOAD instruction (opcode: 0x8, operand: 0x003) to load data from memory address 3 
    cpu_inst.mem[5] = 16'h0005; // Data to be loaded 
    cpu_inst.mem[6] = 16'h100B; // SUB instruction (opcode: 0x1, operand: 0x00B)
    cpu_inst.mem[7] = 16'h900B; // Store the value of the accumulator into memory address 11

    // Wait for execution
    #40

    // Test Case 3: NOT instruction
    // Expected: Memory location 12 contains ~0x1005 = 0xEFFB
    cpu_inst.mem[8] = 16'h200C; // NOT instruction (opcode: 0x2, operand: 0x00C)
    cpu_inst.mem[9] = 16'h900C; // Store the value of the accumulator into memory address 12 

    // Wait for execution
    #40

    // End simulation
    $finish;
  end

endmodule 