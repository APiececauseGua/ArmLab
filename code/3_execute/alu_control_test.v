`include "definitions.vh"

module alu_control_test;
    reg [1:0] ALUOp;
    reg [10:0] opcode;
    wire [3:0] ALU_control;
    
    alu_control ALU_Control_Module(
        .ALUOp(ALUOp),
        .opcode(opcode),
        .ALU_control(ALU_control));
        
    initial
    begin
    ALUOp = 2'b00;
    opcode = 0; #10;
    ALUOp = 2'b01;
    opcode = 0; #10;
    ALUOp = 2'b10;
    opcode = `ADD; #10;
    ALUOp = 2'b10;
    opcode = `SUB; #10;
    ALUOp = 2'b10;
    opcode = `AND; #10;
    ALUOp = 2'b10;
    opcode = `ORR; #10;
    $finish;
    end
endmodule