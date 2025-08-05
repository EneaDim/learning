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
// Purpose: FPGA top level reset synchronisation
// ----------------------------------------------

module fpga_top_rst_sync (
  input  wire       CLK12MHZ,    // Clock
  input  wire       SYSCLK,
  input  wire       ck_rst,
  output wire       nRST_12MHz,
  output wire       nRST_SYSCLK
  );

  reg [3:0]   reg_rst_cntr_12MHz;
  reg         reg_nRST_12MHz;
  reg [3:0]   reg_rst_cntr_SYSCLK;
  reg         reg_nRST_SYSCLK;

  always @(posedge CLK12MHZ or negedge ck_rst)
  begin
  if (~ck_rst)
    begin
    reg_rst_cntr_12MHz <= 4'b0000;
    reg_nRST_12MHz     <= 1'b0;
    end
  else
    begin	
    if   (reg_rst_cntr_12MHz!=4'b1111)
      reg_rst_cntr_12MHz <= reg_rst_cntr_12MHz+1'b1;
    else
      reg_nRST_12MHz <= 1'b1;
    end
  end
  
  always @(posedge SYSCLK or negedge ck_rst)
  begin
  if (~ck_rst)
    begin
    reg_rst_cntr_SYSCLK <= 4'b0000;
    reg_nRST_SYSCLK     <= 1'b0;
    end
  else
    if   (reg_rst_cntr_SYSCLK!=4'b1111)
      reg_rst_cntr_SYSCLK <= reg_rst_cntr_SYSCLK+1'b1;
    else
      reg_nRST_SYSCLK <= 1'b1;
  end

  BUFG RST_BUFG_12MHz  (.I(reg_nRST_12MHz), .O(nRST_12MHz));
  BUFG RST_BUFG_SYSCLK (.I(reg_nRST_SYSCLK), .O(nRST_SYSCLK));

endmodule
