`include "definitions.vh"

module iDecode(
    input  [`WORD-1:0]
           write_data,
           cur_pc_in, 
    input  [`INSTR_LEN-1:0] instruction,
    input  [4:0] write_register_in,
    input  write_clk,
           reg_write_in,
    output reg [4:0] write_register_out,
    output uncond_branch, branch, mem_read, 
           mem_to_reg, mem_write, ALU_src,
           reg_write_out,
    output [1:0] ALU_op,
    output reg [10:0] opcode,
    output [`WORD-1:0] 
           read_data1, read_data2,
           sign_extended_output,
    output reg [`WORD-1:0] cur_pc_out           
    );
    
    wire reg2loc, read_clk;
    wire [4:0] read_reg2;
    reg [`INSTR_LEN-1:0] instruction_buffered;
    reg write_register_buffered, reg_write_buffered;

    always @(posedge write_clk)
    begin
        opcode <= instruction[31:21];
        cur_pc_out <= cur_pc_in;
        write_register_out <= instruction[4:0];
        write_register_buffered <= write_register_in;
        reg_write_buffered <= reg_write_in;
        instruction_buffered <= instruction;
    end
    
    delay #(.DELAYAMT(1)) read_delay(.a(write_clk), .a_delayed(read_clk));
    
    control cont_mod(.instruction(instruction_buffered),
                     .Reg2Loc(reg2loc),
                     .Branch(branch), 
                     .MemRead(mem_read), 
                     .MemtoReg(mem_to_reg),
                     .MemWrite(mem_write), 
                     .ALUSrc(ALU_src), 
                     .RegWrite(reg_write_out), 
                     .UncondBranch(uncond_branch), 
                     .ALUOp(ALU_op));
                     
    sign_extender sign_ex(.Instruction(instruction_buffered), .Sign_Extended(sign_extended_output));
    
    mux #(.SIZE(5)) read_mux(.a_in(instruction_buffered[20:16]), .b_in(write_register_buffered), .control(reg2loc), .mux_out(read_reg2));
    
    regfile reg_mod(.read_register1(instruction_buffered[9:5]),
                    .read_register2(read_reg2),
                    .write_register(write_register_buffered),
                    .RegWrite(reg_write_buffered),
                    .read_clk(read_clk),
                    .write_clk(write_clk),
                    .write_data(write_data),
                    .read_data1(read_data1),
                    .read_data2(read_data2));
endmodule
