`include "definitions.vh"

module fetch #(parameter SIZE = 64)
    (input [`WORD-1:0]  branch_target,
    input pc_src, clk, reset,
    output [`WORD-1:0] cur_pc,
    output [`INSTR_LEN-1:0] instruction);
    
    wire [`WORD-1:0] new_pc, incremented_pc;
    wire fetch_clk;
    
    delay #(.DELAYAMT(1)) Fetch_Delay(.a(clk), .a_delayed(fetch_clk));
    
    mux MUX (.a_in(incremented_pc), .b_in(branch_target), .control(pc_src), .mux_out(new_pc));
    register PC(.clk(clk), .reset(reset), .D(new_pc), .Q(cur_pc));
    adder ADD(.a_in(cur_pc), .b_in(64'd4), .add_out(incremented_pc));

    instr_mem iMEM(.address(cur_pc), .clk(fetch_clk), .instruction(instruction));
    
endmodule