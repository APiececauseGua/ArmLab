`include "definitions.vh"
module alu_test;
        reg [`WORD-1:0] a_in;
        reg [`WORD-1:0] b_in;
        reg [3:0] alu_control;
        wire [`WORD-1:0] alu_result;
        wire zero_flag;
        
        ALU alu_test(
            .a_in(a_in),
            .b_in(b_in),
            .alu_control(alu_control),
            .alu_result(alu_result),
            .zero_flag(zero_flag)
            );
    initial
        begin
            a_in <=`WORD'd5;
            b_in <=`WORD'd15;
            
            alu_control <= `ALU_AND; #10;
            alu_control <= `ALU_OR; #10;
            alu_control <= `ALU_ADD; #10;
            alu_control <= `ALU_SUB; #10;
            alu_control <= `ALU_PASS; #10;
            
            a_in <= 23;
            b_in <= 23;
            alu_control <= `ALU_AND; #10;
            alu_control <= `ALU_OR; #10;
            alu_control <= `ALU_ADD; #10;
            alu_control <= `ALU_SUB; #10;
            alu_control <= `ALU_PASS; #10;
            $finish;
        end
    
endmodule
