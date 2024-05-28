module Accumulator (
  input wire clk,
  input wire reset,
  input wire acc_write,
  input wire [15:0] acc_in,
  output reg [15:0] acc_out
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      acc_out <= 16'b0;
    end else if (acc_write) begin
      acc_out <= acc_in;
    end
  end
endmodule 