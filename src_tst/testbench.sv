//Para Javi <3

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "test.sv"


//--------------
//  Modulo TOP  
//--------------


module top;
  
  bit clk;
  
  initial begin
    run_test("test");
    
    clk = 0;
  end
  
  initial begin
    forever begin
      #(50) clk = ~clk;
    end
  end
  
  initial begin
    $dumpfile("top.vcd");
    $dumpvars(0,top);
  end
  
  
endmodule