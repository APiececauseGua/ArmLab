`include "definitions.vh"

module control_test;
    
    reg [`INSTR_LEN-1:0] instruction;
    wire Reg2Loc, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, UncondBranch;
    wire [1:0] ALUOp;

    control cont_mod(.instruction(instruction), .Reg2Loc(Reg2Loc), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg),
                     .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .UncondBranch(UncondBranch), .ALUOp(ALUOp));
initial
    begin
    instruction = 32'hF84402C9; #10;
    instruction = 32'h8B09026A; #10;
    instruction = 32'hCB0A028B; #10;
    instruction = 32'hF80602CB; #10;
    instruction = 32'hB4FFFF6B; #10;
    instruction = 32'hB4000109; #10;
    instruction = 32'h14000040; #10;
    instruction = 32'h17FFFFC9; #10;
    instruction = 32'hAA150149; #10;
    instruction = 32'h8A0A02C9; #10;
    $finish;
    end
                                          
endmodule