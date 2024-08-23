/*Assignment agenda:

Create implicit bins for din, rst, state variable(State), and dout.

Generate stimulus to cover all the generated bins (100 % Coverage).

*/

`timescale 1ns / 1ps
module tb;
 
  logic rst,din,dout;
  logic clk = 0;
  
  fsm dut (.rst(rst), .din(din), .dout(dout), .clk(clk));
  
  
  covergroup cvr_a ; 
    option.per_instance = 1;

    
    coverpoint dut.dout;
    
    coverpoint dut.state{
      option.auto_bin_max = 3;
    }
    
    coverpoint dut.din;
    
    coverpoint dut.rst;
    
  
  endgroup 
  
 
  cvr_a ci = new();
 
  always@(posedge clk)
    begin
      din = $urandom();
      assert( randomize(rst) with { rst dist { 0 := 9, 1 := 1 }; } );
      ci.sample();
    end
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #1000;
    $finish();
  end
 
endmodule


