`include "program_counter.v"
`include "register_file.v"
`include "ALU.v"
`include "ALU_control.v"
`include "control_unit.v"
`include "data_memory.v"
`include "instruction_memory.v"
`include "imm_gen.v"

module top(reset, clk);

  input clk, reset;

  wire[31:0] pc_top, pc_updated;
  wire[31:0] instr_top;
  wire[31:0] reg_out1, reg_out2, aluResult;
  wire[31:0] aluOperand2;
  wire[1:0] aluOp;
  wire[3:0] aluOperation;
  wire memToRegOut, regWrEn, brOut, memReadOut, memWriteOut;
  wire zeroOut;
  wire aluSRC;
  wire[31:0] ExtImmediate;
  wire[31:0] regWrData, dm_data_out;

  assign aluOperand2 = (aluSRC) ? ExtImmediate : reg_out2;
  assign regWrData = memToRegOut ? dm_data_out : aluResult;
  assign pc_updated = (zeroOut==1'b1 && brOut==1'b1) ? (pc_top + ExtImmediate) : (pc_top + 32'd1);

  program_counter PC (.clk(clk), .reset(reset), .PC_in(pc_updated), .PC_out(pc_top));
  inst_mem inst_mem1(.clk(clk), .reset(reset), .read_addr(pc_top), .instr(instr_top));
  reg_file reg_file1(.clk(clk), .reset(reset), .instr(instr_top), .write_data(regWrData), .regWrite(regWrEn), .rd_data1(reg_out1), .rd_data2(reg_out2));
  data_mem dm1(.clk(clk), .reset(reset), .memWrite(memWriteOut), .memRead(memReadOut), .addr(aluResult), .write_data(reg_out2), .read_data(dm_data_out));
  ALU alu(.op1(reg_out1), .op2(aluOperand2), .zero(zeroOut), .result(aluResult), .operation(aluOperation));
  control cu(.instr(instr_top), .branch(brOut), .memRead(memReadOut), .memToReg(memToRegOut), .ALUop(aluOp), .memWrite(memWriteOut), .ALUsrc(aluSRC), .regWrite(regWrEn));
  ALU_control alu_cu(.instr(instr_top), .ALUop(aluOp), .operation(aluOperation));
  imm_gen imm_gen1(.instr(instr_top), .immExt(ExtImmediate));

endmodule