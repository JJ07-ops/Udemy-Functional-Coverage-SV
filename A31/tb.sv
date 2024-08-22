/*Assignment agenda:

Modify the Testbench code to get 100% Coverage.
We recieved coverage of 75% while working with Buffer. Modify testbench code to get 100% Coverage. 

*/

`timescale 1ns / 1ps
module tb;
 
  reg  [1:0]  a;
  wire [1:0]  b;
  integer i = 0;
  
  top dut (.a(a), .b(b));
  
  
  covergroup cvr_a ; ///// manual sample method
    option.per_instance = 1;
    
    coverpoint a; //// automaitc bins  
    
    coverpoint b;
  
  endgroup 
  
 
  cvr_a ci = new();
 
  
  initial begin
    
    //student modified number of iterations from 10 to 20
    for (i = 0; i <20; i++) begin
      a = $urandom();  
      ci.sample();
      
      #10;
    end
    
    
  end
  
  
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #500;
    $finish();
  end
 
endmodule
