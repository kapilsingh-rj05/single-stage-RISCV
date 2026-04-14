module inst_mem(clk, reset, read_addr, instr);

  input clk, reset;
  input [31:0] read_addr;
  output [31:0] instr;

  reg[31:0] instr_memory[0:63];
  integer k;

  assign instr = instr_memory[read_addr];

  // always@(posedge clk) begin
  //   if(!reset) begin
  //       for(k=0; k<64; k=k+1) begin
  //           instr_memory[k] <= 32'h00000000;
  //       end
  //   end
  // end
  
  initial begin
    $readmemh("instr_mem.hex", instr_memory);
  end

endmodule
