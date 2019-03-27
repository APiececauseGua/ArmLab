`include "definitions.vh"
module iMemory_test;

    wire read_clk;
    wire write_clk;
    reg [`WORD - 1:0] address;
    reg [`WORD - 1:0] write_data;
    reg mem_read;
    reg mem_write;
    wire zero;
    wire branch;
    wire uncondbranch;
    wire [`WORD - 1:0] read_data;
    wire pc_src;
    
    oscillator clk_gen(read_clk);
    
    delay delay_one(
            .a(read_clk),
            .a_delayed(write_clk)
            );
