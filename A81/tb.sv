/*Assignment agenda:

Generate stimulus to get 100% coverage for the following Scenarios

1) Cover all the possible combinations of a,b and c

2) Cover cross of a( 00, 01 ) with all the values of b.

3) Cover cross of b(11) with all the possible values of c.

4) Cover cross of a (10), b(10), and c(10)

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
      ignore_bins unused_a = binsof(a) intersect {[2:3]}; 
    }
    
    cross b,c{
      ignore_bins unused_b = binsof(b) intersect {[0:2]}; 
    }
    
    cross a,b,c{
      ignore_bins unused_a = binsof(a) intersect {0,1,3}; 
      ignore_bins unused_b = binsof(b) intersect {0,1,3}; 
      ignore_bins unused_c = binsof(c) intersect {0,1,3}; 
    }
  
  endgroup
  
  cover_c ci;

  
  initial begin
    ci = new();
    for(int i = 0; i<50; i++) begin 
      a = $urandom();
      b = $urandom();
      c = $urandom();
      #10
      ci.sample();    
    end
    
  end
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #1000;
    $finish();
  end
  
endmodule

