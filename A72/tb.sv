/*Assignment agenda:

Create a stimulus for D-Flipflop to cover following behavior of design.

1) Cover all the possible values of rst

2) Cover all the possible values of din

3) Cover all the possible values of dout

*/


`timescale 1ns / 1ps
module tb;
  
  logic rst,din,dout;
  logic clk = 0;
  
  always #10 clk = ~clk;
  
  dff dut (.rst(rst), .din(din), .dout(dout), .clk(clk));
  
  covergroup c(ref logic data,input string name);
    
    option.per_instance = 1;
    option.name = name;
    coverpoint data;
  
  endgroup
  
  c ci_rst;
  c ci_din;
  c ci_dout;
  
  initial begin
    ci_rst = new(rst,"Reset hits");
    ci_din = new(rst,"Din hits");
    ci_dout = new(rst,"Dout hits");
    for(int i = 0; i<15; i++) begin 
      @(posedge clk)
      rst = $urandom();
      din = $urandom();
      #1
      ci_rst.sample();
      ci_din.sample();
      ci_dout.sample();
      

      
    end
    
  end
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #300;
    $finish();
  end
  
endmodule
