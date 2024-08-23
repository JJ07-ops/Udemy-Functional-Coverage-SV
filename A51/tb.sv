/*Assignment agenda:

Create a stimulus for 100 % coverage of signal y. Create two explicit bins, one working with all the possible values of a (00,01,10,11) when sel is high and the other working with all the possible values of b when sel is low.

Do not Use Cross Coverage, Prefer Wildcard bins.

*/

`timescale 1ns / 1ps
module tb;
  
  logic [1:0] a,b,y;
  logic sel;
  
  mux_2 dut (.a(a), .b(b), .y(y), .sel(sel));
  
  covergroup c;
    option.per_instance = 1;
    
    coverpoint {sel,y} {
      
      wildcard bins a = {4'b1??};
      wildcard bins b = {4'b0??};
 
    }
  
  endgroup
  
  c ci;
  
   
  
  initial begin
    ci = new();
    for(int i = 0; i<15; i++) begin 
      sel = $urandom();
      a = $urandom();
      b = $urandom();
      #10
      ci.sample();
    end
    
  end
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #300;
    $finish();
  end
  
endmodule

