module MemoryBufferRegister (
  input wire clk,
  input wire reset,
  input wire mbr_write,
  input wire [15:0] mbr_in,
  output reg [15:0] mbr_out
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      mbr_out <= 16'b0;
    end else if (mbr_write) begin
      mbr_out <= mbr_in;
    end
  end
endmodule 