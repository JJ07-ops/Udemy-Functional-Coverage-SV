/*Assignment agenda:

Generate stimulus to get 100% coverage for the following Scenarios

1) Cover all the possible combinations of a,b,c

2) Cover cross between a and even values of b

3) Cover cross between a and odd values of c

4) Cover cross between even values of b and odd  values of c

*/

`timescale 1ns / 1ps
module tb;
  
  logic [1:0] a,b,c;
  logic [3:0] y;
  
  top dut (.a(a), .b(b), .c(c), .y(y));
  
  covergroup cover_c;
    
    option.per_instance = 1;
    
    coverpoint a{
      bins a_[] = {[0:3]};
    }
    
    coverpoint b{
      bins b_[] = {[0:3]};
    }
    
    coverpoint c{
      bins c_[] = {[0:3]};
    }
    
    cross a,b{
      ignore_bins unused_odd_b = binsof(b) intersect {1,3};
    }
    
    cross a,c{
      ignore_bins unused_even_c = binsof(c) intersect {0,2};
    }
    
    cross b,c{
      ignore_bins unused_odd_b = binsof(b) intersect {1,3};
      ignore_bins unused_even_c = binsof(c) intersect {0,2};
    }
  
  endgroup
  
  cover_c ci;

  
  initial begin
    ci = new();
    for(int i = 0; i<100; i++) begin 
      a = $urandom();
      b = $urandom();
      c = $urandom();
      #5
      ci.sample();    
    end
    
  end
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #500;
    $finish();
  end
  
endmodule
