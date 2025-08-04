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
// Purpose: Behavioral clock gating cell 
// ----------------------------------------------

module behavioral_clk_gate (
  input  wire   CLK,
  input  wire   CLKEN,
  input  wire   TESTMODE,
  output wire   CLKOUT
  );
  
  // Replace this behavioral model with 
  // real clock gating cell in synthesis
  wire clk_en_latch_in;
  reg  clk_en_latch;
  
  assign clk_en_latch_in = CLKEN | TESTMODE;
  
  always @(CLK or clk_en_latch_in)
    begin
    if (CLK==1'b0)
      clk_en_latch <= clk_en_latch_in;
    end
  
  assign CLKOUT = CLK & clk_en_latch;

endmodule  
