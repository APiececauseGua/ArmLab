`include "definitions.vh"

module mux#(
    parameter SIZE=64)(
    input [SIZE-1:0] a_in,
    input [SIZE-1:0] b_in,
    input control,
    output [SIZE-1:0] mux_out
    );
    
    assign mux_out = (control) ? b_in : a_in;//control is your selector
    //When control == 0 it selects a_in
    //When control == 1 it selects b_in
    
endmodule
