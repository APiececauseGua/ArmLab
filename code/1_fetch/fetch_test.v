`include "definitions.vh"

module fetch_test;

    wire clk; 
    reg reset, pc_src;
    reg [`WORD-1:0] branch_target;
    wire [`INSTR_LEN-1:0] instruction;
    
    oscillator clock(.clk(clk));
    
    fetch iFetch(.clk(clk), .reset(reset), .branch_target(branch_target), 
                .pc_src(pc_src), .instruction(instruction));
        
    initial
    begin
       reset = 1;
       pc_src= 0;
       branch_target= 20;#10;
       reset = 0;#10;
       pc_src= 1;#10;
       pc_src = 0; #40;
       branch_target= 0;
       pc_src= 1;#10;
       pc_src = 0; #100;
       $finish;
    end
    
endmodule
