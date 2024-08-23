//design code given in the question

module mux (
  input a,b,
  input sel,
  output y
 
);
  
  assign y = (sel == 1'b1) ? b : a ;
  
  
endmodule
