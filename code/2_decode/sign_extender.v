`include "definitions.vh"

module sign_extender(
        input [`INSTR_LEN-1:0] Instruction,
        output reg [`WORD-1:0] Sign_Extended);
        
        reg [10:0] opcode;
        reg num;
      
        
        
      always @(*)begin
      opcode = Instruction[31:21];
        casex (opcode)
        `LDUR: begin
            num = Instruction[20];
            Sign_Extended = {{55{num}}, Instruction[20:12]};
        end
        `STUR: begin
            num = Instruction[20];
            Sign_Extended = {{55{num}}, Instruction[20:12]};
        end
        `B: begin
            num = Instruction[25];
            Sign_Extended = {{38{num}}, Instruction[25:0]};
        end
        `CBZ: begin
            num = Instruction[23];
            Sign_Extended = {{45{num}}, Instruction[23:5]};
        end
        default: begin
         Sign_Extended = 0;
        end
      endcase
      end 
        
endmodule 