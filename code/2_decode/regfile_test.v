`include "definitions.vh"

module regfile_test;

    reg [4:0] read_register1, read_register2, write_register;
    reg RegWrite;
    wire read_clk, write_clk;
    reg [`WORD-1:0] write_data;
    wire [`WORD-1:0] read_data1, read_data2;
    
    regfile RegFile(
        .read_register1(read_register1),
        .read_register2(read_register2),
        .write_register(write_register),
        .RegWrite(RegWrite),
        .read_clk(read_clk),
        .write_clk(write_clk),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
        );
        
    oscillator ReadClock(
        .clk(read_clk)
        );
        
    delay WClk(.a(read_clk), .a_delayed(write_clk));
    
    initial
    begin
        RegWrite = 1;
        write_register = 0;
        write_data = 4783;
        read_register1 = 22;
        read_register2 = 4; #10;
        read_register1 = 19;
        read_register2 = 9; #10;
        read_register1 = 20;
        read_register2 = 10; #10;
        read_register1 = 22;
        read_register2 = 11; #10;
        write_register = 13; #10;
        read_register1 = 13; #10;
        
        RegWrite = 0;
        write_data = 3987; #10;
        
        write_register = 13; #10;
        read_register1 = 13; #10;
        $finish;
    end
endmodule