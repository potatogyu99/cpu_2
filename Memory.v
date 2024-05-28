module Memory (
  input wire clk,
  input wire we,
  input wire [15:0] addr,
  input wire [15:0] data_in,
  output reg [15:0] data_out
);

  reg [15:0] mem [0:999]; 

  // Initialize the first 10 memory locations
  initial begin
    mem[0] = 16'h1000; // Load instruction, will load data from memory address 1 
    mem[1] = 16'h2000; 
    mem[2] = 16'h3000;
    mem[3] = 16'h4000;
    mem[4] = 16'h5000;
    mem[5] = 16'h6000; 
    mem[6] = 16'h7000; 
    mem[7] = 16'h8000; 
    mem[8] = 16'h9000; 
    mem[9] = 16'hA000;
  end

  // Use a generate block to initialize the rest of the memory
  generate 
    genvar i;
    for (i = 10; i < 1000; i = i + 1) begin : init_mem
      initial begin
        mem[i] = i;
      end
    end
  endgenerate 

  // Memory read/write logic
  always @(posedge clk) begin
    if (we) begin
      mem[addr] <= data_in;
    end else begin
      data_out <= mem[addr];
    end
  end

endmodule 