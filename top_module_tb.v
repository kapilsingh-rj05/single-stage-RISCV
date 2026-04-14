`timescale 1ns/1ps
`include "top_module.v"

module tb;

    reg clk, reset;

    top uut(.reset(reset), .clk(clk));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1'b1;

        #2 reset = ~reset;
        #10 reset = ~reset;

        #200 $finish;
    end

    initial begin
        $monitor("reg_mem[2] = %d",uut.reg_file1.reg_memory[2]);
    end

    initial begin
        $dumpfile("RISC_V.vcd");
        $dumpvars(0, tb);
    end

endmodule