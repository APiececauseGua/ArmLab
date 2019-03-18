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
    wire alu_ctrl_out;
    
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
    
    adder pc_adder(
        .a_in(),
        .b_in(),
        .add_out()
        );

endmodule