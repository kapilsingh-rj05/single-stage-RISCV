module ALU_control(instr, ALUop, operation);

    // input clk, reset;
    input[31:0] instr;
    input[1:0] ALUop;
    output reg[3:0] operation;

    always@(*) begin
        casex({ALUop,instr[31:25],instr[14:12]})
            12'b00_xxxxxxx_xxx: operation = 4'b0010;
            12'bx1_xxxxxxx_xxx: operation = 4'b0110;
            12'b1x_0000000_000: operation = 4'b0010;
            12'b1x_0100000_000: operation = 4'b0110;
            12'b1x_0000000_111: operation = 4'b0000;
            12'b1x_0000000_110: operation = 4'b0001;
        endcase
    end

endmodule