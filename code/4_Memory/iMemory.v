`include "definitions.vh"
module iMemory(
    input  [`WORD-1:0]
           pc_in, alu_result_in, read_data2,
    input  [4:0] write_register_in,
    input  im_clk, uncond_branch,
           branch, mem_read,
           mem_write, zero,
           mem_to_reg_in, reg_write_in,
    output reg [`WORD-1:0] pc_out, alu_result_out,
    output [`WORD-1:0] read_data,
    output reg [4:0] write_register_out,
    output reg reg_write_out, mem_to_reg_out,
    output pc_src);
            
    wire and_zero, delayed_clk;
    reg uncond_branch_buffered, branch_buffered,
        mem_read_buffered, mem_write_buffered,
        zero_buffered;
    reg [`WORD-1:0] read_data2_buffered;
        
        delay #(.DELAYAMT(1)) Mem_Delay(.a(im_clk), .a_delayed(delayed_clk));
        
    always @(posedge im_clk)
    begin
        pc_out <= pc_in;
        mem_to_reg_out <= mem_to_reg_in;
        write_register_out <= write_register_in;
        reg_write_out <= reg_write_in;
        uncond_branch_buffered <= uncond_branch;
        branch_buffered <= branch;
        mem_read_buffered <= mem_read;
        mem_write_buffered <= mem_write;
        read_data2_buffered <= read_data2;
        alu_result_out <= alu_result_in;
        zero_buffered <= zero;
    end
    
    assign and_zero = (branch_buffered & zero_buffered);
    assign pc_src = (uncond_branch_buffered | and_zero);
    
    data_mem DM(.im_clk(delayed_clk), 
                .mem_write(mem_write_buffered), 
                .mem_read(mem_read_buffered),
                .read_data2(read_data2_buffered), 
                .alu_result(alu_result_out),
                .read_data(read_data));

endmodule