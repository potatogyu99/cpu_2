module ALU (
  input [2:0] opcode,
  input [7:0] operand1,
  input [7:0] operand2,
  output reg [7:0] result
);

  // 3-to-8 decoder
  reg [7:0] decoder_out;
  always @(*) begin
    case (opcode)
      3'b000: decoder_out = 8'b00000001; // add
      3'b001: decoder_out = 8'b00000010; // sub
      3'b010: decoder_out = 8'b00000100; // not
      3'b011: decoder_out = 8'b00001000; // and
      3'b100: decoder_out = 8'b00010000; // or
      3'b101: decoder_out = 8'b00100000; // xor
      3'b110: decoder_out = 8'b01000000; // shift left
      3'b111: decoder_out = 8'b10000000; // shift right
      default: decoder_out = 8'b00000000; 
    endcase
  end

  // ALU operation selection and execution
  always @(*) begin
    case (1'b1)
      decoder_out[0]: result = operand1 + operand2;  // add
      decoder_out[1]: result = operand1 - operand2;  // sub
      decoder_out[2]: result = ~operand1;        // not
      decoder_out[3]: result = operand1 & operand2;  // and
      decoder_out[4]: result = operand1 | operand2;  // or
      decoder_out[5]: result = operand1 ^ operand2;  // xor
      decoder_out[6]: result = operand1 << 1;     // shift left
      decoder_out[7]: result = operand1 >> 1;     // shift right
      default: result = 8'b00000000;
    endcase
  end

endmodule 