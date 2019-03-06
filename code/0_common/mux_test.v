`include "definitions.vh"

module mux_test;  //Test for 2way mux
 //a_in == in0 
 //b_in == in1
 //When control == 0 it selects a_in
 //When control == 1 it selects b_in

reg [`WORD-1:0]a_in, b_in;
reg control;
wire [`WORD-1:0] mux_out;
mux MUX (.a_in(a_in), .b_in(b_in), .control(control), .mux_out(mux_out));
initial
    begin
           a_in= 654; 
           b_in= 15; 
           control= 1; #10;

           a_in= 654; 
           b_in= 15; 
           control= 0; #10;
 
           a_in= 7110; 
           b_in= 43778; 
           control= 1; #10;

           a_in= 7110; 
           b_in= 43778; 
           control= 0; #10; 
           $finish;
    end  
    
endmodule