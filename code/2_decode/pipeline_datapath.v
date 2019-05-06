`include "definitions.vh"

module pipeline;
    
    reg reset, pc_src;
    wire [`INSTR_LEN-1:0] instruction_if;
    wire uncond_branch_id, uncond_branch_ie,
         branch_id, branch_ie,
         mem_read_id, mem_read_ie,
         mem_to_reg_id, mem_to_reg_ie,
         mem_write_id, mem_write_ie,
         reg_write_id, reg_write_ie,
         ALU_src_id, clk,
         zero_ie, mem_to_reg_im, pc_src_1,
         reg_write_im, reg_write_iw;
    wire [1:0] ALU_op_id;
    wire [4:0] write_register_id, write_register_ie,
         write_register_im, write_register_iw;
    wire [`WORD-1:0]
         cur_pc_if, cur_pc_id, cur_pc_ie, cur_pc_im, cur_pc_iw,
         read_data1_id,
         read_data2_id, read_data2_ie,
         sign_extended_output_id,
         alu_result_ie, alu_result_im,
         branch_target,
         read_data_im,
         write_data_iw;
    wire [10:0] opcode_id;
    
    // Base Clock
    oscillator r_clk(.clk(clk));
    
    // Fetch Stage
    fetch fetch_mod(
        .clk(clk),
        .reset(reset), 
        .branch_target(branch_target), 
        .pc_src(pc_src), 
        .instruction(instruction_if),
        .cur_pc(cur_pc_if));
        
    // Decode Stage
    iDecode decode_mod(
        .cur_pc_in(cur_pc_if),
        .cur_pc_out(cur_pc_id),
        .write_data(write_data_iw),
        .write_register_in(write_register_iw),
        .write_register_out(write_register_id),
        .reg_write_in(reg_write_iw),
        .reg_write_out(reg_write_id),
        .instruction(instruction_if),
        .uncond_branch(uncond_branch_id),
        .branch(branch_id),
        .mem_read(mem_read_id),
        .mem_to_reg(mem_to_reg_id),
        .mem_write(mem_write_id),
        .ALU_src(ALU_src_id),
        .write_clk(clk),
        .ALU_op(ALU_op_id),
        .read_data1(read_data1_id),
        .read_data2(read_data2_id),
        .sign_extended_output(sign_extended_output_id),
        .opcode(opcode_id));
                
    iExecute execute_mod(
        .clk(clk),
        .pc_in(cur_pc_id),
        .pc_out(cur_pc_ie),
        .write_register_in(write_register_id),
        .write_register_out(write_register_ie),
        .reg_write_in(reg_write_id),
        .reg_write_out(reg_write_ie),
        .uncond_branch_in(uncond_branch_id),
        .uncond_branch_out(uncond_branch_ie),
        .branch_in(branch_id),
        .branch_out(branch_ie),
        .mem_read_in(mem_read_id),
        .mem_read_out(mem_read_ie),
        .mem_to_reg_in(mem_to_reg_id),
        .mem_to_reg_out(mem_to_reg_ie),
        .mem_write_in(mem_write_id),
        .mem_write_out(mem_write_ie),
        .read_data1(read_data1_id),
        .read_data2_in(read_data2_id),
        .read_data2_out(read_data2_ie),
        .sign_extend(sign_extended_output_id),
        .opcode(opcode_id),
        .alu_op(ALU_op_id),
        .alu_src(ALU_src_id),
        .alu_result(alu_result_ie),
        .zero(zero_ie),
        .branch_target(branch_target));


    iMemory memory_mod(
        .im_clk(clk),
        .pc_in(cur_pc_ie),
        .pc_out(cur_pc_im),
        .alu_result_in(alu_result_ie),
        .alu_result_out(alu_result_im),
        .read_data2(read_data2_ie),
        .mem_read(mem_read_ie),
        .mem_write(mem_write_ie),
        .mem_to_reg_in(mem_to_reg_ie),
        .mem_to_reg_out(mem_to_reg_im),
        .write_register_in(write_register_ie),
        .write_register_out(write_register_im),
        .reg_write_in(reg_write_ie),
        .reg_write_out(reg_write_im),
        .zero(zero_ie),
        .branch(branch_ie),
        .uncond_branch(uncond_branch_ie),
        .read_data(read_data_im),
        .pc_src(pc_src_1));
                
    iWrite_back writeback_m(
        .iw_clk(clk),
        .read_data(read_data_im),
        .alu_result(alu_result_im), 
        .MemtoReg(mem_to_reg_im), 
        .write_data(write_data_iw),
        .pc_in(cur_pc_im),
        .write_register_in(write_register_im),
        .write_register_out(write_register_iw),
        .reg_write_in(reg_write_im),
        .reg_write_out(reg_write_iw),
        .pc_out(cur_pc_iw));
                              
initial
    begin
       reset = 1;
       pc_src = 0;#5
       reset = 0; #135
   $finish;
    end
  
endmodule
