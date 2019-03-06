`include "definitions.vh"

module decode_test;

    reg [`INSTR_LEN-1:0] Instruction;
    reg [`WORD-1:0] write_data;
    wire uncond_branch, branch, mem_read, mem_to_reg, mem_write, ALU_src, read_clk, write_clk;
    wire [1:0] ALU_op;
    wire [`WORD-1:0] read_data1, read_data2, sign_extended;
    wire [10:0] opcode;
    
    oscillator r_clk(.clk(read_clk));
    
    delay w_clk(.a(read_clk), .a_delayed(write_clk));
    
    iDecode decode_mod(.write_data(write_data),
                       .Instruction(Instruction),
                       .uncond_branch(uncond_branch),
                       .branch(branch),
                       .mem_read(mem_read),
                       .mem_to_reg(mem_to_reg),
                       .mem_write(mem_write),
                       .ALU_src(ALU_src),
                       .read_clk(read_clk),
                       .write_clk(write_clk),
                       .ALU_op(ALU_op),
                       .read_data1(read_data1),
                       .read_data2(read_data2),
                       .sign_extended(sign_extended),
                       .opcode(opcode));

    
    initial
        begin
        write_data = 20;
        Instruction = 32'hF84402C9; #10;
        write_data = 30;
        Instruction = 32'h8B09026A; #10;
        write_data = 0;
        Instruction = 32'hCB0A028B; #10;
        write_data = 1234;
        Instruction = 32'hF80602CB; #10;
        write_data = 1234;
        Instruction = 32'hB4FFFF6B; #10;
        write_data = 1234;
        Instruction = 32'hB4000109; #10;
        write_data = 1234;
        Instruction = 32'h14000040; #10;
        write_data = 1234;
        Instruction = 32'h17FFFFC9; #10;
        write_data = 30;
        Instruction = 32'hAA150149; #10;
        write_data = 16;
        Instruction = 32'h8A0A02C9; #10;
        $finish;
        end
endmodule
