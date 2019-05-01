`include "definitions.vh"
module iExecute(
    input  [`WORD-1:0] 
           pc_in, read_data1, 
           read_data2_in, sign_extend,
    input  [10:0] opcode,
    input  [4:0] write_register_in,
    input  [1:0]alu_op,
    input  alu_src, clk, reg_write_in, uncond_branch_in, branch_in, mem_read_in, mem_to_reg_in, mem_write_in,
    output [`WORD-1:0]
           alu_result, branch_target,
    output reg [`WORD-1:0] 
           read_data2_out, pc_out,
    output reg [4:0] write_register_out,
    output reg reg_write_out, uncond_branch_out, branch_out, mem_read_out, mem_to_reg_out, mem_write_out,
    output zero
    );
    
    wire [`WORD-1:0] mux_out;
    wire [3:0] alu_ctrl_out;
    wire [`WORD-1:0] shift_result;
    
    reg [`WORD-1:0] sign_extend_buffered, read_data1_buffered;
    reg [10:0] opcode_buffered;
    reg [1:0] alu_op_buffered;
    reg alu_src_buffered;
    
    always @(posedge clk)
        begin
        read_data2_out <= read_data2_in;
        sign_extend_buffered <= sign_extend;
        alu_src_buffered <= alu_src;
        read_data1_buffered <= read_data1;
        opcode_buffered <= opcode;
        alu_op_buffered <= alu_op;
        pc_out <= pc_in;
        write_register_out <= write_register_in;
        reg_write_out <= reg_write_in;
        uncond_branch_out <= uncond_branch_in;
        branch_out <= branch_in;
        mem_read_out <= mem_read_in;
        mem_to_reg_out <= mem_to_reg_in;
        mem_write_out <= mem_write_in;
        end
    
    mux MUX (
        .a_in(read_data2_out),
        .b_in(sign_extend_buffered), 
        .control(alu_src_buffered), 
        .mux_out(mux_out));
    
    ALU alu(
        .a_in(read_data1_buffered),
        .b_in(mux_out),
        .alu_control(alu_ctrl_out),
        .alu_result(alu_result),
        .zero_flag(zero)
        );
        
    alu_control alu_ctrl(
        .ALUOp(alu_op_buffered),
        .opcode(opcode_buffered),
        .ALU_control(alu_ctrl_out));
        
        //shift sign extend left by 2 = *4 
    assign shift_result = sign_extend_buffered*4;
    
    adder pc_adder(
        .a_in(pc_out),
        .b_in(shift_result),
        .add_out(branch_target)
        );
endmodule