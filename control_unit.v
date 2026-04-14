module control(instr, branch, memRead, memToReg, ALUop, memWrite, ALUsrc, regWrite);

    input[31:0] instr;
    output reg branch, memRead, memToReg, memWrite, ALUsrc, regWrite;
    output reg[1:0] ALUop;

    wire[6:0] opcode;
    assign opcode = instr[6:0];

    always@(*) begin
        case(opcode)
            //R-type
            7'b0110011: begin
                branch = 0;
                memRead = 0;
                memToReg = 0;
                ALUop = 2'b10;
                memWrite = 0;
                ALUsrc = 0;
                regWrite = 1;
            end
            //ld
            7'b0000011: begin
                branch = 0;
                memRead = 1;
                memToReg = 1;
                ALUop = 2'b00;
                memWrite = 0;
                ALUsrc = 1;
                regWrite = 1;
            end
            //sd
            7'b0100011: begin
                branch = 0;
                memRead = 0;
                memToReg = 1'bx;
                ALUop = 2'b00;
                memWrite = 1;
                ALUsrc = 1;
                regWrite = 0;
            end
            //beq
            7'b1100011: begin
                branch = 1;
                memRead = 0;
                memToReg = 1'bx;
                ALUop = 2'b01;
                memWrite = 0;
                ALUsrc = 0;
                regWrite = 0;
            end
            default: begin
                branch = 0;
                memRead = 0;
                memToReg = 0;
                ALUop = 2'b00;
                memWrite = 0;
                ALUsrc = 0;
                regWrite = 0;
            end
        endcase
    end

endmodule