`include "definitions.vh"

module iWrite_back(
    input  [`WORD-1:0] 
           read_data, alu_result, pc_in,
    input  iw_clk, MemtoReg, reg_write_in,
    output reg [`WORD-1:0] pc_out,
    output [`WORD-1:0] write_data,
    output reg reg_write_out);

    reg [`WORD-1:0] read_data_buffered, alu_result_buffered;
    reg MemtoReg_buffered;
    
    always @(posedge iw_clk)
    begin
       pc_out <= pc_in;
       reg_write_out <= reg_write_in;
       read_data_buffered <= read_data;
       alu_result_buffered <= alu_result;
       MemtoReg_buffered <= MemtoReg;
    end

    mux WB (.a_in(alu_result_buffered),
            .b_in(read_data_buffered), 
            .control(MemtoReg_buffered), 
            .mux_out(write_data));  // 1 -- read data, 0 -- alu result

endmodule