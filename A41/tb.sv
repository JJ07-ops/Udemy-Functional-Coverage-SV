/*Assignment agenda:

Create four explicit bins for a,b and sum and implicit bins for cout. Generate stimulus to cover all the generated bins (100 % Coverage).

*/

`timescale 1ns / 1ps
module tb;
 
  logic [7:0] a,b,sum;
  logic cout;
  
  top dut (.a(a), .b(b), .sum(sum), .cout(cout));
  
  
  covergroup cvr_a ; 
    option.per_instance = 1;
    
    coverpoint dut.a{
      bins lower = {[0:85]};
      bins mid = {[86:170]};
      bins higher = {[171:255]};
    }
      
    
    coverpoint dut.b{
      bins lower = {[0:85]};
      bins mid = {[86:170]};
      bins higher = {[171:255]};
    }
    
    coverpoint dut.sum{
      bins lower = {[0:85]};
      bins mid = {[86:170]};
      bins higher = {[171:255]};
    }
    
    coverpoint dut.cout;
  
  endgroup 
  
 
  cvr_a ci = new();
 
  
  initial begin
    
    for (int i = 0; i < 30; i++) begin
      a = $urandom();  
      b = $urandom();
      
      #10;
      
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
