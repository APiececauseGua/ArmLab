`include "definitions.vh"

module alu_control(
    input [1:0] ALUOp,
    input [10:0] opcode,
    output reg [3:0] ALU_control);
    
    reg [12:0] full_control;
    
    always @*
    begin
        full_control <= {ALUOp,opcode};
        casex (full_control)
            {2'b00,`VAR}: begin
                ALU_control <= `ALU_ADD;
            end
            {2'bX1,`VAR}: begin
               ALU_control <= `ALU_PIB;
            end
            {2'b1X,`ADD}: begin
               ALU_control <= `ALU_ADD;
            end
            {2'b1X,`SUB}: begin
               ALU_control <= `ALU_SUB;
            end
            {2'b1X,`AND}: begin
               ALU_control <= `ALU_AND;
            end
            {2'b1X,`ORR}: begin
               ALU_control <= `ALU_OR;
            end
        endcase
    end
endmodule