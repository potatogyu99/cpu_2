module ProgramCounter (
  input wire clk,
  input wire reset,
  input wire pc_write,
  input wire [15:0] pc_in,
  output reg [15:0] pc_out
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pc_out <= 16'b0;
    end else if (pc_write) begin
      pc_out <= pc_in + 1; // Increment PC when pc_write is high
    end
  end
endmodule 