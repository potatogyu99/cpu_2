module InstructionRegister (
  input wire clk,
  input wire reset,
  input wire ir_write,
  input wire [15:0] ir_in,
  output reg [15:0] ir_out
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ir_out <= 16'b0;
    end else if (ir_write) begin
      ir_out <= ir_in;
    end
  end
endmodule 