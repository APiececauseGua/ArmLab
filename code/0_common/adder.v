`include "definitions.vh"

module adder(
    input [`WORD-1:0] a_in,
    input [`WORD-1:0] b_in,
    output [`WORD-1:0] add_out
    );
    
    // add_out is the sum of a_in and b_in
    assign add_out = a_in + b_in;
    
endmodule
