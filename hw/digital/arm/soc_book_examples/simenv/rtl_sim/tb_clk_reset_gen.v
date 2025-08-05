// ----------------------------------------------
// Example code for
//
// System-on-Chip Design with Arm(R) Cortex(R)-M 
// Processors
//
// Reference Book
//          by Joseph Yiu, 2019 (first edition)
// 
// ISBN: 978-1-911531-19-7
// Arm Education Media
// https://www.armedumedia.com
//
// Disclaimer
// This example design is created for educational
// purpose only and are not validated to the same 
// quality level as Arm IP products. 
// Arm Education Media and author do not make any 
// warranties of these designs.
// ----------------------------------------------
// Purpose: Simple clock and reset generator for 
//          testbench
// ----------------------------------------------
// 
//
module tb_clk_reset_gen(
  output wire   CLK,    // Clock
  output wire   RESETn  // Active low Reset output
  );

reg        PORn;
reg        iCLK;

// reset assert at first 50 ns
initial
begin
  PORn = 1'b0;
  #510
  PORn = 1'b1;
end 

// Clock period = 100 ns
always
  begin
  iCLK = 1'b1;
  #50
  iCLK = 1'b0;
  #50
  iCLK = 1'b1;
  end
  
assign CLK    = iCLK;
assign RESETn = PORn;
  
endmodule
