`include "definitions.vh"

module iWrite_back(
                   input iw_clk, 
                   input [`WORD-1:0] read_data,
                   input [`WORD-1:0] alu_result, 
                   input MemtoReg, 
                   input [`WORD-1:0] pc_in,
                   input reg_write_in, 
                   output reg [`WORD-1:0] pc_out,
                   output [`WORD-1:0] write_data,
                   output reg reg_write_out);
                   
                   always @(posedge iw_clk)
                   begin
                       pc_out <= pc_in;
                       reg_write_out <= reg_write_in;
                   end
                   
    mux WB (.a_in(alu_result),
            .b_in(read_data), 
            .control(MemtoReg), 
            .mux_out(write_data));  // 1 -- read data, 0 -- alu result

endmodule