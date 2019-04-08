`include "definitions.vh"

module data_mem(
    input im_clk, mem_write, mem_read,
    input [`WORD-1:0] read_data2, alu_result,
    output reg [`WORD-1:0] read_data);

    reg [`WORD-1:0] ramf [31:0];
    
    always @(posedge im_clk)
    begin
        if(mem_read)
            read_data <= ramf[alu_result/8];

      
//    always @(negedge write_clk)
//    begin
        else if(mem_write)
           ramf[alu_result] <= read_data2; 
        else
            read_data <= 64'dZ;
    end

    initial
        $readmemb(`DMEMFILE, ramf);
endmodule