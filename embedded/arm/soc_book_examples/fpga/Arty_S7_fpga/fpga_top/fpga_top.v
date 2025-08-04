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
// Purpose: Cortex-M3 FPGA top level design
// ----------------------------------------------

module fpga_top (
  input  wire       CLK12MHZ,    // Clock
  input  wire       CLK100MHZ,   // Clock
  input  wire       ck_rst,      // Reset button
  input  wire [3:0] sw,          // Switches
  output wire       led0_r,
  output wire       led0_g,
  output wire       led0_b,
  output wire       led1_r,
  output wire       led1_g,
  output wire       led1_b,
  output wire [3:0] led,
  input  wire [3:0] btn,
  inout  wire [7:0] ja,  // Pmod A
  inout  wire [7:0] jb,  // Pmod B
  //inout  wire [7:0] jc,  // Pmod C
  //inout  wire [7:0] jd,  // Pmod D
  input  wire       SWCLK,
  inout  wire       SWDIO,
  output wire       uart_rxd_out,
  input  wire       uart_txd_in
  );

  wire nRST_12MHz;      // Synchronised reset
  wire nRST_100MHz;     // Synchronised reset
  wire sysclk;          // System Clock
  wire n_sysrst;        // System reset
  wire locked;          // Lock status from Clock Wizard

  // Clock wizard for generation of system clock (40MHz)
  sys_clk_generator u_clk_wiz_0 (
    .resetn_0   (ck_rst),
    .clk_in1_0  (CLK100MHZ),
    .clk_out1_0 (sysclk),
    .locked_0   (locked)
    );
  
  // Generate synchronised reset
  fpga_top_rst_sync u_fpga_top_rst_sync (
    .CLK12MHZ      (CLK12MHZ),    // Clock
    .SYSCLK        (sysclk),   // Clock
    .ck_rst        (ck_rst & locked),  // Reset button
    .nRST_12MHz    (nRST_12MHz),  // Synchronised reset
    .nRST_SYSCLK   (n_sysrst)  // Synchronised reset
    );

  // Cortex-M3 Microcontroller unit	
  cm3_mcu u_cm3_mcu (
    .CLKIN    (sysclk),
    .nSRSTIN  (n_sysrst),
    .PORT0    (ja),
    .PORT1    (jb),

    .sw              (sw),
    .led0_r          (led0_r),
    .led0_g          (led0_g),
    .led0_b          (led0_b),
    .led1_r          (led1_r),
    .led1_g          (led1_g),
    .led1_b          (led1_b),
    .led             (led),
    .btn             (btn),
    .uart_rxd_out    (uart_rxd_out),
    .uart_txd_in     (uart_txd_in),

    .nTRST    (nRST_12MHz),
    .SWDTMS   (SWDIO),
    .SWCLKTCK (SWCLK),
    .TDI      (1'b0),
    .TDO      ()  
  );

  
endmodule
