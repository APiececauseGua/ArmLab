`include "definitions.vh"

module data_mem(
    input read_clk, write_clk, mem_write, mem_read,
    input [`WORD-1:0] write_data, address,
    output reg [`WORD-1:0] read_data);

    reg [`WORD-1:0] ramf [31:0];
    
    always @(posedge read_clk)
    begin
        if(mem_read)
            read_data <= ramf[address];
        else
            read_data <= 64'dZ;
    end
      
    always @(posedge write_clk)
    begin
        if(mem_write)
           ramf[address] <= write_data; 
    end
    
    initial
        $readmemb(`DMEMFILE, ramf);
endmodule