module ALU(op1, op2, zero, result, operation);

    input[31:0] op1, op2;
    input[3:0] operation;
    output zero;
    output reg[31:0] result;

    always@(*) begin
        case(operation)
            4'b0000: result = op1 & op2;
            4'b0001: result = op1 | op2;
            4'b0010: result = op1 + op2;
            4'b0110: result = op1 - op2;
            default: result = 32'h00000000;
        endcase
    end

    assign zero = (result==0);

endmodule