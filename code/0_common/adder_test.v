`include "definitions.vh"

module adder_test;

    reg [`WORD-1:0] A_in, B_in;
    wire [`WORD-1:0] Add_out;
    
    adder add(
        .a_in(A_in),
        .b_in(B_in),
        .add_out(Add_out)
        );
  
initial
begin
    A_in = 5;
    B_in = 10; #5;
    A_in = 320; #5;
    B_in = 93; #5;
    B_in = 2409; #5;
    A_in = 9999; #5;
end
endmodule
