/*Assignment agenda:

Prefer Sample method.

Create a stimulus for 2:1 mux to cover following behavior of design.

1) Cover all the possible values of sel line

2) Cover all the possible values of a,b

3) Cover all the possible values of y

*/

`timescale 1ns / 1ps
module tb;
  
  logic a,b,sel,y;
  
  mux dut (.a(a), .b(b), .y(y), .sel(sel));
  
  covergroup c with function sample(ref logic signal);
    
    option.per_instance = 1;
    coverpoint signal;
  
  endgroup
  
  c ci;
  
  initial begin
    ci = new();
    for(int i = 0; i<15; i++) begin 
      a = $urandom();
      b = $urandom();
      sel = $urandom();
      #10
      ci.sample(a);
      
      /* 
      ci.sample(b);
      ci.sample(y);
      ci.sample(sel);
      */
      
    end
    
  end
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #300;
    $finish();
  end
  
endmodule

