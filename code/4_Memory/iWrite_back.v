`include "definitions.vh"

module iWrite_back(input [`WORD-1:0] read_data,
                   input [`WORD-1:0]alu_result, 
                   input MemtoReg, 
                   output [`WORD-1:0] write_data);
    mux WB (.a_in(alu_result), .b_in(read_data), .control(MemtoReg), .mux_out(write_data));  // 1 -- read data, 0 -- alu result

endmodule