`include "definitions.vh"
module iMemory_test;

    wire read_clk;
    wire write_clk;
    reg [`WORD - 1:0] address;
    reg [`WORD - 1:0] write_data;
    reg mem_read;
    reg mem_write;
    reg zero;
    reg branch;
    reg uncondbranch;
    wire [`WORD - 1:0] read_data;
    wire pc_src;
    
    oscillator clk_gen(read_clk);
    
    delay delay_one(
            .a(read_clk),
            .a_delayed(write_clk)
            );
            
    iMemory IM(
            .read_clk(read_clk),
            .write_clk(write_clk),
            .address(address),
            .write_data(write_data),
            .mem_read(mem_read),
            .mem_write(mem_write),
            .zero(zero),
            .branch(branch),
            .uncondbranch(uncondbranch),
            .read_data(read_data),
            .pc_src(pc_src));
            
        initial 
            begin   
            //memread memwrite
            
            
            //read data from address
            mem_write = 0;
            mem_read = 1;
            address <= `WORD'd0; #10;
            address <= `WORD'd3; #10;
            
            //write data
            mem_write = 1;
            address <= `WORD'd3;
            write_data <= `WORD'd100; #10;
            
            //read again to check
            mem_write = 0;
            mem_read = 1;
            address <= `WORD'd3; #10;
            
            //branching test
            branch = 1;
            zero = 0; 
            uncondbranch = 0; #10;
            uncondbranch = 1; #10;
            
            branch = 0;
            zero = 0; 
            uncondbranch = 0; #10;
            uncondbranch = 1; #10;
            
            branch = 0;
            zero = 1; 
            uncondbranch = 0; #10;
            uncondbranch = 1; #10;
            
              
            branch = 1;
            zero = 1; #10;
            uncondbranch = 0; #10;
            uncondbranch = 1; #10;
            
            

            $finish;
        end
endmodule
