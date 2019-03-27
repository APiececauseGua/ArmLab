`include "definitions.vh"

module data_mem(
    input read_clk, write_clk, MemWrite, MemRead,
    input [`WORD-1:0] write_data, address,
    output reg [`WORD-1:0] read_data);

    reg [`WORD-1:0] ramf [31:0];
    
    always @(posedge read_clk)
    begin
        if(MemRead)
            read_data <= ramf[address/8];
        else
            read_data <= 64'dZ;
    end
      
    always @(posedge write_clk)
    begin
        if(MemWrite)
           ramf[address/8] <= read_data; 
    end
    
    initial
        $readmemb(`DMEMFILE, ramf);
endmodule