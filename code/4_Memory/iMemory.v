`include "definitions.vh"
module iMemory(
            input im_clk,
            input uncondbranch,
            input branch,  
            input mem_read, 
            input mem_write, 
            input zero,
            input [`WORD-1:0] pc_in,
            input mem_to_reg_in,
            input [`WORD-1:0] alu_result,
            input [`WORD-1:0] read_data2,
            output pc_src,
            output reg [`WORD-1:0] pc_out,
            output reg mem_to_reg_out,
            output [`WORD-1:0] read_data);
            
            wire and_zero;
            always @(posedge im_clk)
            begin
                pc_out <= pc_in;
                mem_to_reg_out <= mem_to_reg_in;
            end
            
            assign and_zero = (branch & zero);
            assign pc_src = (uncondbranch | and_zero);
            
        data_mem DM(.im_clk(im_clk), 
                    .mem_write(mem_write), 
                    .mem_read(mem_read),
                    .read_data2(read_data2), 
                    .alu_result(alu_result),
                    .read_data(read_data));

endmodule