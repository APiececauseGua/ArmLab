`include "definitions.vh"

module control(
    input [`INSTR_LEN-1:0] instruction,
    output reg Reg2Loc, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, UncondBranch,
    output reg [1:0] ALUOp
    );
    
    reg [10:0] opcode;
    
    always @(*)
    begin
    opcode <= instruction[31:21];
        casex (opcode)
            `ADD: begin
                Reg2Loc <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 1;
                UncondBranch <= 0;
                ALUOp <= 2'b10;
            end
            `SUB: begin
                Reg2Loc <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 1;
                UncondBranch <= 0;
                ALUOp <= 2'b10;
            end
            `CBZ: begin
                Reg2Loc <= 1;
                Branch <= 1;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                UncondBranch <= 0;
                ALUOp <= 2'b01;
            end
            `B: begin
                Reg2Loc <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                UncondBranch <= 1;
                ALUOp <= 2'b00;
            end
            `LDUR: begin
                Reg2Loc <= 0;
                Branch <= 0;
                MemRead <= 1;
                MemtoReg <= 1;
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                UncondBranch <= 0;
                ALUOp <= 2'b00;
            end
            `STUR: begin
                Reg2Loc <= 1;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 1;
                ALUSrc <= 1;
                RegWrite <= 0;
                UncondBranch <= 0;
                ALUOp <= 2'b00;
            end
            `ORR: begin
                Reg2Loc <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 1;
                UncondBranch <= 0;
                ALUOp <= 2'b10;
            end
            `AND: begin
                Reg2Loc <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 1;
                UncondBranch <= 0;
                ALUOp <= 2'b10;
            end
            default: begin
                Reg2Loc <= 0;
                Branch <= 0;
                MemRead <= 0;
                MemtoReg <= 0;
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                UncondBranch <= 0;
                ALUOp <= 2'b00;
            end
        endcase
    end
endmodule