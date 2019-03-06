`include "definitions.vh"

module instr_parse
        (input [`INSTR_LEN-1:0] instruction,
         output [4:0] rm_num, rn_num, rd_num,
         output [10:0] opcode,
         output [8:0] address);

assign rd_num = instruction[4:0];
assign rn_num = instruction[9:5];
assign rm_num = instruction[20:16];
assign address = instruction[20:12];
assign opcode = instruction[31:21];

endmodule