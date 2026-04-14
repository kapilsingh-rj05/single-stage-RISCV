module reg_file(clk, reset, instr, write_data, regWrite, rd_data1, rd_data2);

    input clk, reset, regWrite;
    input[31:0] write_data;
    input[31:0] instr;
    output [31:0] rd_data1, rd_data2;

    reg[31:0] reg_memory[0:31];

    initial begin
        reg_memory[0] = 32'h00000000;
    end

    wire[4:0] write_reg;
    integer i;

    assign write_reg = instr[11:7];

    always@(posedge clk) begin
        // if(!reset) begin
        //     for(i=0; i<32; i=i+1) begin
        //         reg_memory[i] <= 32'h00000000;
        //     end
        // end

        if(regWrite && write_reg!=5'd0) begin
            reg_memory[write_reg] <= write_data;
        end
    end

    assign rd_data1 = reg_memory[instr[19:15]];
    assign rd_data2 = reg_memory[instr[24:20]];

    initial begin
        reg_memory[3] = 'd12;
        reg_memory[4] = 'd34;
    end

endmodule