`include "definitions.vh"

module iDecode(
    input [`WORD-1:0] write_data,
    input [`INSTR_LEN-1:0] Instruction,
    output uncond_branch, branch, mem_read, mem_to_reg, mem_write, ALU_src, read_clk, write_clk,
    output [1:0] ALU_op,
    output reg [10:0] opcode,
    output [`WORD-1:0] read_data1, read_data2, sign_extended
    );
    
    wire reg2loc, reg_write;
    wire [4:0] read_reg2;
    
    always @*
        begin
            opcode <= Instruction[31:21];
        end
    
    control cont_mod(.instruction(Instruction),
                     .Reg2Loc(reg2loc),
                     .Branch(branch), 
                     .MemRead(mem_read), 
                     .MemtoReg(mem_to_reg),
                     .MemWrite(mem_write), 
                     .ALUSrc(ALU_src), 
                     .RegWrite(reg_write), 
                     .UncondBranch(uncond_branch), 
                     .ALUOp(ALU_op));
                     
    sign_extender sign_ex(.Instruction(Instruction), .Sign_Extended(sign_extended));
    
    mux #(.SIZE(5)) read_mux(.a_in(Instruction[20:16]), .b_in(Instruction[4:0]), .control(reg2loc), .mux_out(read_reg2));
    
    regfile reg_mod(.read_register1(Instruction[9:5]),
                    .read_register2(read_reg2),
                    .write_register(Instruction[4:0]),
                    .RegWrite(reg_write),
                    .read_clk(read_clk),
                    .write_clk(write_clk),
                    .write_data(write_data),
                    .read_data1(read_data1),
                    .read_data2(read_data2));
endmodule
