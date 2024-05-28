module ControlUnit (
  input wire clk,
  input wire reset,
  input wire [3:0] opcode,
  output reg pc_write,
  output reg mar_write,
  output reg mbr_write,
  output reg ir_write,
  output reg acc_write,
  output reg mem_read,
  output reg mem_write,
  output reg [2:0] alu_opcode,
  output reg is_load_store
);

  // Define states for the instruction cycle
  localparam FETCH = 0,
             DECODE = 1,
             EXECUTE = 2,
             STORE_RESULT = 3;

  reg [1:0] current_state; 

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= FETCH;
      pc_write <= 0;
      mar_write <= 0;
      mbr_write <= 0;
      ir_write <= 0;
      acc_write <= 0;
      mem_read <= 0;
      mem_write <= 0;
      alu_opcode <= 3'b000;
      is_load_store <= 0;
    end else begin
      case (current_state)
        FETCH: begin 
          pc_write <= 1; // Enable PC increment
          mar_write <= 1; // Send PC value to MAR
          mem_read <= 1; // Read instruction from memory
          current_state <= DECODE;
        end
        DECODE: begin
          pc_write <= 0;
          mar_write <= 0;
          mem_read <= 0;
          mbr_write <= 1; // Store fetched instruction in MBR
          current_state <= EXECUTE;
        end
        EXECUTE: begin 
          mbr_write <= 0;
          ir_write <= 1; // Move instruction from MBR to IR
          case (opcode)
            4'b0000: begin // ADD
              alu_opcode <= 3'b000;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b0001: begin // SUB
              alu_opcode <= 3'b001;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b0010: begin // NOT
              alu_opcode <= 3'b010;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b0011: begin // AND
              alu_opcode <= 3'b011;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b0100: begin // OR
              alu_opcode <= 3'b100;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b0101: begin // XOR
              alu_opcode <= 3'b101;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b0110: begin // SHL
              alu_opcode <= 3'b110;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b0111: begin // SHR
              alu_opcode <= 3'b111;
              acc_write <= 1;
              current_state <= FETCH;
            end
            4'b1000: begin // LOAD
              mar_write <= 1; // Load operand address into MAR
              mem_read <= 1;
              is_load_store <= 1; // Set flag for Load/Store operation
              current_state <= STORE_RESULT; 
            end
            4'b1001: begin // STORE
              mar_write <= 1; // Load operand address into MAR
              mem_write <= 1;
              is_load_store <= 1; // Set flag for Load/Store operation
              current_state <= STORE_RESULT; 
            end
            default: begin
              // NOP or undefined
              current_state <= FETCH;
            end
          endcase
        end

        STORE_RESULT: begin // This state handles loading data into MBR or storing from ACC
          ir_write <= 0; 
          if (mem_read) begin // If it was a LOAD instruction
            mbr_write <= 1;  // Load data from memory into MBR
            mem_read <= 0;
            current_state <= FETCH;
          end else if (mem_write) begin // If it was a STORE instruction
            acc_write <= 1; // Store data from ACC into memory
            mem_write <= 0;
            current_state <= FETCH;
          end
        end
      endcase
    end
  end
endmodule 