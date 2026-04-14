module data_mem(clk, reset, memWrite, memRead, addr, write_data, read_data);

    input clk, reset, memWrite, memRead;
    input[31:0] addr;
    input [31:0] write_data;
    output [31:0] read_data;

    reg[31:0] data_mem[0:63];
    integer i;

    always@(posedge clk) begin
        if(!reset) begin
            for(i=0; i<64; i=i+1) begin
                data_mem[i] = 32'h00000000;
            end
        end
        else begin
            if(memWrite) begin
                data_mem[addr] = write_data;
            end
        end
    end

    assign read_data = memRead ? data_mem[addr] : 32'h00000000;

endmodule