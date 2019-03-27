module iMemory(
            input read_clk, write_clk,
            input uncondbranch,
            input branch,  
            input MemRead, 
            input MemWrite, 
            input zero,
            input [`WORD-1:0] address,
            input [`WORD-1:0] write_data,
            output pc_src,
            output [`WORD-1:0] read_data);
            
            wire and_zero;
            
            assign and_zero = (branch & zero);
            assign pc_src = (uncondbranch | and_zero);
            
        data_mem DM(.read_clk(read_clk), 
                    .write_clk(write_clk), 
                    .MemWrite(MemWrite), 
                    .MemRead(MemRead),
                    .write_data(write_data), 
                    .address(address),
                    .read_data(read_data));

endmodule