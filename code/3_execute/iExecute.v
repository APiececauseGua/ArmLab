`include "definitions.vh"
module iExecute(
    input [`WORD-1:0] pc_in,
    input [`WORD-1:0] read_data1,
    input [`WORD-1:0] read_data2,
    input [`WORD-1:0] sign_extend,
    input [10:0] opcode,
    input [1:0]alu_op,
    input alu_src,
    output [`WORD-1:0] alu_result,
    output zero,
    output [`WORD-1:0] branch_target    
    );
    
    wire [`WORD-1:0] mux_out;
    wire [3:0] alu_ctrl_out;
    wire [`WORD-1:0] shift_result;
    
    mux MUX (
        .a_in(read_data2),
        .b_in(sign_extend), 
        .control(alu_src), 
        .mux_out(mux_out));
    
    ALU alu(
        .a_in(read_data1),
        .b_in(mux_out),
        .alu_control(alu_ctrl_out),
        .alu_result(alu_result),
        .zero_flag(zero)
        );
        
    alu_control alu_ctrl(
        .ALUOp(alu_op),
        .opcode(opcode),
        .ALU_control(alu_ctrl_out));
        
        //shift sign extend left by 2 = *4 
    assign shift_result = sign_extend*4;
    
    adder pc_adder(
        .a_in(pc_in),
        .b_in(shift_result),
        .add_out(branch_target)
        );

endmodule