`include "definitions.vh"

module datapath;
    
    reg reset, pc_src;
    reg [`WORD-1:0] branch_target;
    wire [`INSTR_LEN-1:0] Instruction;
    reg [`WORD-1:0] write_data;
    wire uncond_branch, branch, mem_read, mem_to_reg, mem_write, ALU_src;
    wire clk, clkplus1, clkplus2, clkplus3, clkplus4, clkplus5, clkplus6;
    wire [1:0] ALU_op;
    wire [`WORD-1:0] read_data1, read_data2, sign_extended;
    
    //fetch takes 2ns to complete. So clk and clkplus1 are used in fetch
    oscillator r_clk(.clk(clk));
    delay ClkPlus1(.a(clk), .a_delayed(clkplus1));
    delay #(.DELAYAMT(2)) ClkPlus2(.a(clk), .a_delayed(clkplus2));
    delay #(.DELAYAMT(3)) ClkPlus3(.a(clk), .a_delayed(clkplus3));
    delay #(.DELAYAMT(4)) ClkPlus4(.a(clk), .a_delayed(clkplus4));
    delay #(.DELAYAMT(5)) ClkPlus5(.a(clk), .a_delayed(clkplus5));
    delay #(.DELAYAMT(6)) ClkPlus6(.a(clk), .a_delayed(clkplus6));

    
    fetch iFetch(.clk(clk), 
                 .reset(reset), 
                 .branch_target(branch_target), 
                 .pc_src(pc_src), 
                 .instruction(Instruction));
                 
    iDecode decode_mod(.write_data(write_data),
                       .Instruction(Instruction),
                       .uncond_branch(uncond_branch),
                       .branch(branch),
                       .mem_read(mem_read),
                       .mem_to_reg(mem_to_reg),
                       .mem_write(mem_write),
                       .ALU_src(ALU_src),
                       .read_clk(clkplus3),
                       .write_clk(clkplus6),
                       .ALU_op(ALU_op),
                       .read_data1(read_data1),
                       .read_data2(read_data2),
                       .sign_extended(sign_extended));
      iExecute  Execute_mod(
                        [`WORD-1:0] pc_in,
                        [`WORD-1:0] read_data1,
                        [`WORD-1:0] read_data2,
                        [`WORD-1:0] sign_extend,
                        [10:0] opcode,
                        [1:0]alu_op,
                        alu_src,
                        [`WORD-1:0] alu_result,
                        zero,
                        [`WORD-1:0] branch_target    
                           );
    
    initial
    begin
       reset = 1;
       pc_src= 0;
       write_data = 20;
       branch_target= 20;#10;
       reset = 0;
       write_data = 20;#10;
       write_data = 30;#10;
       write_data = 0;#10;
       write_data = 1234; #50;
       write_data = 30; #10;
       write_data = 16; #6;
   $finish;
    end
  
endmodule
