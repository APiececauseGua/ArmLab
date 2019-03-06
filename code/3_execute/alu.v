`include "definitions.vh"
module ALU(
           input [`WORD-1:0] a_in,
           input [`WORD-1:0] b_in,
           input [3:0] alu_control,
           output reg [`WORD-1:0] alu_result,
           output reg zero_flag);
           
       always @(*)
        begin
            zero_flag <= (alu_result == 0);
            
            casex(alu_control)
                `ALU_AND: begin
                    alu_result <= a_in & b_in;
                          end
                `ALU_OR: begin
                    alu_result <= a_in | b_in;
                          end
                `ALU_ADD: begin
                    alu_result <= a_in + b_in;
                          end
                `ALU_SUB: begin
                    alu_result <= a_in - b_in;
                          end
                `ALU_PASS: begin
                    alu_result <= b_in;
                          end
              endcase
        end
           
endmodule