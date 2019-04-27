`include "definitions.vh"

module iDecode(
    input  [`WORD-1:0]
           write_data_iw,
           cur_pc_if, 
    input  [`INSTR_LEN-1:0] instruction_if,
    input  [4:0] write_register_iw,
    input  write_clk,
           reg_write_iw,
    output reg [4:0] write_register_id,
    output uncond_branch_id, branch_id, mem_read_id, 
           mem_to_reg_id, mem_write_id, ALU_src_id,
           reg_write_id,
    output [1:0] ALU_op_id,
    output reg [10:0] opcode_id,
    output [`WORD-1:0] 
           read_data1_id, read_data2_id,
           sign_extended_output_id,
    output reg [`WORD-1:0] cur_pc_id           
    );
    
    wire reg2loc, read_clk;
    wire [4:0] read_reg2;
    reg write_register_buffered, reg_write_buffered;

    always @(posedge write_clk)
    begin
        opcode_id <= instruction_if[31:21];
        cur_pc_id <= cur_pc_if;
        write_register_id <= instruction_if[4:0];
        write_register_buffered <= write_register_iw;
        reg_write_buffered <= reg_write_iw;
    end
    
    delay #(.DELAYAMT(1)) read_delay(.a(write_clk), .a_delayed(read_clk));
    
    control cont_mod(.instruction(instruction_if),
                     .Reg2Loc(reg2loc),
                     .Branch(branch_id), 
                     .MemRead(mem_read_id), 
                     .MemtoReg(mem_to_reg_id),
                     .MemWrite(mem_write_id), 
                     .ALUSrc(ALU_src_id), 
                     .RegWrite(reg_write_id), 
                     .UncondBranch(uncond_branch_id), 
                     .ALUOp(ALU_op_id));
                     
    sign_extender sign_ex(.Instruction(instruction_if), .Sign_Extended(sign_extended_output_id));
    
    mux #(.SIZE(5)) read_mux(.a_in(instruction_if[20:16]), .b_in(write_register_iw), .control(reg2loc), .mux_out(read_reg2));
    
    regfile reg_mod(.read_register1(instruction_if[9:5]),
                    .read_register2(read_reg2),
                    .write_register(write_register_buffered),
                    .RegWrite(reg_write_buffered),
                    .read_clk(read_clk),
                    .write_clk(write_clk),
                    .write_data(write_data_iw),
                    .read_data1(read_data1_id),
                    .read_data2(read_data2_id));
endmodule
