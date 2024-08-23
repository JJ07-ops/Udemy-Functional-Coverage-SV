/*Assignment agenda:

Generate stimulus to get 100% coverage for the following Scenarios

1) Cover all the possible combinations of a,b

2) Cover rst.

3) Cover cross between rst (low) and a.

4) Cover cross between rst (low) and b.

5) Cover cross between a (00,11) and b(00,11) when rst is low.

*/

`timescale 1ns / 1ps
module tb;
  
  logic [2:0] a,b,y;
  logic rst,feed,done;
  
  top dut (.a(a), .b(b), .rst(rst), .y(y), .feed(feed), .done(done));
  
  covergroup cover_c;
    
    option.per_instance = 1;
    
    coverpoint a{
      bins a_[] = {[0:7]};
    }
    
    coverpoint b{
      bins b_[] = {[0:7]};
    }
    
    coverpoint rst{
      bins rst_[] = {[0:7]};
    }
    
    cross a,b;
    
    cross a,rst{
      ignore_bins unused_rsthigh = binsof(rst) intersect {1}; 
    }
    
    cross b,rst{
      ignore_bins unused_rsthigh = binsof(rst) intersect {1}; 
    }
    
    cross a,b,rst{
      ignore_bins unused_rsthigh = binsof(rst) intersect {1};
      ignore_bins unused_a = binsof(a) intersect {1,2,4,5,6,7}; 
      ignore_bins unused_b = binsof(b) intersect {1,2,4,5,6,7};  
    }
  
  endgroup
  
  cover_c ci;

  
  initial begin
    ci = new();
    for(int i = 0; i<1000; i++) begin 
      a = $urandom();
      b = $urandom();
      rst = $urandom();
      #5
      ci.sample();    
    end
    
  end
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #5000;
    $finish();
  end
  
endmodule

