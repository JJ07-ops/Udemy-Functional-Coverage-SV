/*Assignment agenda:

Create a stimulus for 100 % coverage of signal eout (output of the Priority Encoder) for all the possible combinations of the pin (Input to the Priority Encoder). Prefer Wildcard bins.

*/

`timescale 1ns / 1ps
module tb;
  
  logic [4:0] pin;
  logic [1:0] eout;
  
  p_enc dut (.eout(eout), .pin(pin));
  
  covergroup c;
    option.per_instance = 1;
    

    coverpoint eout {
      
      wildcard bins lower = {2'b0?};
      wildcard bins higher = {2'b1?};


    }
  
  endgroup
  
  c ci;
  
   
  
  initial begin
    ci = new();
    for(int i = 0; i<15; i++) begin 
      pin = $urandom();
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
