module MemoryAddressRegister (
  input wire clk,
  input wire reset,
  input wire mar_write,
  input wire [15:0] mar_in,
  output reg [15:0] mar_out
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      mar_out <= 16'b0;
    end else if (mar_write) begin
      mar_out <= mar_in;
    end
  end
endmodule 