`include "definitions.vh"
module iExecute_test;
    reg [`WORD-1:0] pc_in, read_data1, read_data2, sign_extend;
    reg [10:0] opcode;
    reg [1:0] alu_op;
    reg alu_src;
    wire [`WORD-1:0] alu_result, branch_target;
    wire zero;
    
    iExecute execute_module(
        .pc_in(pc_in),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .sign_extend(sign_extend),
        .opcode(opcode),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .alu_result(alu_result),
        .branch_target(branch_target),
        .zero(zero));

initial
    begin
    // 1
    pc_in = 0;
    read_data1 = 16;
    read_data2 = 101;
    sign_extend = 64'h0000000000000040;
    opcode = 11'b11111000010;
    alu_op = 2'b00;
    alu_src = 1;
    #10;
    // 2
    pc_in = 4;
    read_data1 = 10;
    read_data2 = 20;
    sign_extend = 64'h0000000000000000;
    opcode = 11'b10001011000;
    alu_op = 2'b10;
    alu_src = 0;
    #10;
    // 3
    pc_in = 8;
    read_data1 = 30;
    read_data2 = 30;
    sign_extend = 64'h0000000000000000;
    opcode = 11'b11001011000;
    alu_op = 2'b10;
    alu_src = 0;
    #10;
    // 4
    pc_in = 12;
    read_data1 = 16;
    read_data2 = 0;
    sign_extend = 64'h0000000000000060;
    opcode = 11'b11111000000;
    alu_op = 2'b00;
    alu_src = 1;
    #10;
    // 5
    pc_in = 16;
    read_data1 = 101;
    read_data2 = 0;
    sign_extend = 64'hFFFFFFFFFFFFFFFB;
    opcode = 11'b10110100000;
    alu_op = 2'b01;
    alu_src = 0;
    #10;
    // 6
    pc_in = 20;
    read_data1 = 101;
    read_data2 = 20;
    sign_extend = 64'h0000000000000008;
    opcode = 11'b10110100000;
    alu_op = 2'b01;
    alu_src = 0;
    #10;
    // 7
    pc_in = 24;
    read_data1 = 101;
    read_data2 = 101;
    sign_extend = 64'h0000000000000040;
    opcode = 11'b00010100000;
    alu_op = 2'b01;
    alu_src = 0;
    #10;
    // 8
    pc_in = 28;
    read_data1 = 101;
    read_data2 = 101;
    sign_extend = 64'hFFFFFFFFFFFFFFC9;
    opcode = 11'b00010100000;
    alu_op = 2'b01;
    alu_src = 0;
    #10;
    // 9
    pc_in = 32;
    read_data1 = 30;
    read_data2 = 0;
    sign_extend = 64'h0000000000000000;
    opcode = 11'b10101010000;
    alu_op = 2'b10;
    alu_src = 0;
    #10;
    // 10
    pc_in = 36;
    read_data1 = 16;
    read_data2 = 30;
    sign_extend = 64'h0000000000000000;
    opcode = 11'b10001010000;
    alu_op = 2'b10;
    alu_src = 0;
    #10;
    $finish;
    end
endmodule