`include "definitions.vh"

module pipeline;
    
    reg reset;
    wire [`INSTR_LEN-1:0] instruction_if;
    wire uncond_branch_id, uncond_branch_ie, // uncond_branch signals
         branch_id, branch_ie, // branch signals
         mem_read_id, mem_read_ie, // mem_read signals
         mem_to_reg_id, mem_to_reg_ie, mem_to_reg_im, // mem_to_reg signals
         mem_write_id, mem_write_ie, //mem_write signals
         ALU_src_id,
         clk, fetch_clk, idecode_clk, im_clk, wb_clk, // clock signals
         zero_ie, pc_src;
    wire [1:0] ALU_op_id;
    wire [`WORD-1:0]
         branch_target,
         cur_pc_if, cur_pc_id, cur_pc_ie, cur_pc_im, // cur_pc signals
         read_data_im,
         read_data1_id,
         read_data2_id, read_data2_ie, 
         write_data_iw, sign_extended_output_id, alu_result_ie;
    
    oscillator r_clk(.clk(clk));      //base clock
//    delay #(.DELAYAMT(1)) ClkPlus3(.a(clk), 
//            .a_delayed(fetch_clk));   //fetch clock
//    delay #(.DELAYAMT(2)) ClkPlus2(.a(clk), 
//            .a_delayed(idecode_clk)); //decode clock
//    delay #(.DELAYAMT(4)) ClkPlus6(.a(clk), 
//            .a_delayed(im_clk));      //memory clock
//    delay #(.DELAYAMT(6)) ClkPlus8(.a(clk), 
//            .a_delayed(wb_clk));      // writeback clock

    
    fetch fetch_mod(
                .clk(clk),
                .reset(reset), 
                .branch_target(branch_target), 
                .pc_src(pc_src), 
                .instruction_if(instruction_if),
                .cur_pc_if(cur_pc_if));
                 
    iDecode decode_mod(
                .cur_pc_if(cur_pc_if),
                .cur_pc_id(cur_pc_id),
                .write_data(write_data_iw),
                .write_register_iw(),
                .write_register_id(),
                .reg_write_iw(reg_write_iw),
                .reg_write_id(reg_write_id),
                .instruction_if(instruction_if),
                .uncond_branch_id(uncond_branch_id),
                .branch_id(branch_id),
                .mem_read_id(mem_read_id),
                .mem_to_reg_id(mem_to_reg_id),
                .mem_write_id(mem_write_id),
                .ALU_src_id(ALU_src_id),
                .read_clk(clk),
                .ALU_op_id(ALU_op_id),
                .read_data1_id(read_data1_id),
                .read_data2_id(read_data2_id),
                .sign_extended_output_id(sign_extended_output_id));
                
//    iExecute execute_mod(
//                .pc_in(cur_pc),
//                .read_data1(read_data1),
//                .read_data2(read_data2),
//                .sign_extend(sign_extended_output_id),
//                .opcode(instruction_if[31:21]),
//                .alu_op(ALU_op),
//                .alu_src(ALU_src),
//                .alu_result(alu_result),
//                .zero(zero),
//                .branch_target(branch_target));
                
//    iMemory memory_mod(
//                .im_clk(clk),
//                .alu_result(alu_result),
//                .read_data2(read_data2),
//                .mem_read(mem_read),
//                .mem_write(mem_write),
//                .zero(zero),
//                .branch(branch),
//                .uncondbranch(uncond_branch),
//                .read_data(read_data),
//                .pc_src(pc_src));
                
//    iWrite_back writeback_m(
//                .read_data(read_data),
//                .alu_result(alu_result), 
//                .MemtoReg(mem_to_reg), 
//                .write_data(write_data));
                              
initial
    begin
       reset = 1; #10
       reset = 0; #100        
   $finish;
    end
  
endmodule
