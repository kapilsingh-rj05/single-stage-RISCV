module imm_gen(instr, immExt);

    input[31:0] instr;
    output reg[31:0] immExt;

    always@(*) begin
        immExt = 32'h00000000;

        case(instr[6:0])
            //ld and immediate
            7'b0000011, 7'b0010011: immExt = {{20{instr[31]}}, instr[31:20]};
            //sd
            7'b0100011: immExt = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            //branch
            7'b1100011: immExt = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
        endcase
    end

endmodule