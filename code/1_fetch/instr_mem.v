`include "definitions.vh"

module instr_mem#(
    parameter SIZE=1024)(
     input  [`WORD - 1:0] address,
     input clk,
     output reg [`INSTR_LEN - 1:0] instruction
    );
    
    // imem is the instruction memory itself
    // imem is initially populated by reading 
    // a file one time in the initial section
    reg[`INSTR_LEN - 1:0] imem [SIZE-1:0];
    
    // Add code here to output the correct instruction
    always @(posedge(clk))
    begin
        instruction <= imem[address/4];
    end
    // initialize instruction memory from a file
    initial
        $readmemb(`IMEMFILE, imem);

endmodule