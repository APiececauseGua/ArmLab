`include "definitions.vh"

module regfile(
    input [4:0] read_register1, read_register2, write_register,
    input RegWrite, read_clk, write_clk,
    input [`WORD-1:0] write_data,
    output reg [`WORD-1:0] read_data1, read_data2);

    reg [`WORD-1:0] rmem [31:0];
    
    always @(posedge read_clk)
    begin
        read_data1  <= rmem[read_register1];
        read_data2  <= rmem[read_register2];

    end
      
    always @(posedge write_clk)
    begin
        if(RegWrite)
           rmem[write_register] <= write_data; 
    end
    
    initial
        $readmemb(`RMEMFILE, rmem);
endmodule