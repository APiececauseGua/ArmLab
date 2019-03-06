`include "definitions.vh"

module sign_extender_test;
    
    reg [`INSTR_LEN -1:0] Instruction;
    wire [`WORD -1:0] Sign_Extended;

sign_extender Sign_Ext(.Instruction(Instruction), .Sign_Extended(Sign_Extended));

initial
begin
Instruction = 32'hF84402C9; #10;
Instruction = 32'h8B09026A; #10;
Instruction = 32'hCB0A028B; #10;
Instruction = 32'hF80602CB; #10;
Instruction = 32'hB4FFFF6B; #10;
Instruction = 32'hB4000109; #10;
Instruction = 32'h14000040; #10;
Instruction = 32'h17FFFFC9; #10;
Instruction = 32'hAA150149; #10;
Instruction = 32'h8A0A02C9; #10;
$finish;
end

endmodule