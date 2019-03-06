`include "definitions.vh"

module instr_mem_test;

    wire clk;
    wire [`INSTR_LEN - 1:0] instruction;
    reg [`WORD - 1:0] address;
    
    oscillator clock(
        .clk(clk)
        );
    
    instr_mem memory(
        .clk(clk),
        .address(address),
        .instruction(instruction)
        );
        
    initial
    begin
        address = 0; #10;
        address = 4; #10;
        address = 8; #10;
        address = 32; #10;
        address = 16; #10;
        address = 40; #15;
        $finish;
    end
    
endmodule
