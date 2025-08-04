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
// Purpose: Top level of simple microcontroller
// ----------------------------------------------
//
module cm3_mcu (
  input  wire        CLKIN,
  input  wire        nSRSTIN,
  
  inout  wire [7:0]  PORT0,
  inout  wire [7:0]  PORT1,

`ifdef FPGA_CONFIG
  // Arty S7 FPGA I/O
  input  wire  [3:0] sw,          // Switches
  output wire        led0_r,      // RGB LED 0 - R
  output wire        led0_g,      // RGB LED 0 - G
  output wire        led0_b,      // RGB LED 0 - B
  output wire        led1_r,      // RGB LED 1 - R
  output wire        led1_g,      // RGB LED 1 - G
  output wire        led1_b,      // RGB LED 1 - B
  output wire  [3:0] led,         // LEDs
  input  wire  [3:0] btn,         // Button

  output wire        uart_rxd_out,// UART TXD
  input  wire        uart_txd_in, // UART RXD  
`endif 
  input  wire        nTRST,
  inout  wire        SWDTMS,
  input  wire        SWCLKTCK,
  input  wire        TDI,
  output wire        TDO
  
  );

  // Internal wires
  wire  [7:0] w_PORT0_IN;
  wire  [7:0] w_PORT0_OUT;
  wire  [7:0] w_PORT0_EN;

  wire  [7:0] w_PORT1_IN;
  wire  [7:0] w_PORT1_OUT;
  wire  [7:0] w_PORT1_EN;
  wire        w_SYSRESETREQ;
  wire        w_GATEHCLK;
  wire        w_TRCENA;
  
  wire        FCLK;
  wire        HCLK;
  wire        TRACECLKIN;
  wire        PORESETn;
  wire        HRESETn;
  wire        w_nTRST;
  wire        w_SWDITMS;
  wire        w_SWCLKTCK;
  wire        w_TDI;
  wire        w_SWDO;
  wire        w_SWDOEN;
  wire        w_TDO;
  wire        w_nTDOEN;
  wire        w_CLKIN;
  wire        w_nSRSTIN;
  
  wire        w_SLEEPING;
  wire        w_SLEEPDEEP;
  wire        w_WAKEUP;
  wire        w_LOCKUP;
  wire        w_LOCKUPRESET;
  
  wire        TESTMODE;

  //---------------------------------
  // Generate clocks and reset
  
  clk_reset_ctrl clk_reset_ctrl(
    .CLKIN        (w_CLKIN),
    .nSRSTIN      (w_nSRSTIN),
  
    .SYSRESETREQ  (w_SYSRESETREQ),
    .LOCKUPRESET  (w_LOCKUPRESET),
  
    .GATEHCLK     (w_GATEHCLK),
    .TRCENA       (w_TRCENA),
    .TESTMODE     (TESTMODE),

    .FCLK         (FCLK),
    .HCLK         (HCLK),
    .TRACECLKIN   (TRACECLKIN),
    .PORESETn     (PORESETn),
    .HRESETn      (HRESETn)
  ); 
  
  //---------------------------------
  // System top level
  
  cm3_system_top cm3_system_top (
   .FCLK           (FCLK),
   .HCLK           (HCLK),
   .TRACECLKIN     (TRACECLKIN),
   .PORESETn       (PORESETn),
   .HRESETn        (HRESETn),

   .SLEEPING       (w_SLEEPING),
   .SLEEPDEEP      (w_SLEEPDEEP),
   .GATEHCLK       (w_GATEHCLK),
   .WAKEUP         (w_WAKEUP),
   .SYSRESETREQ    (w_SYSRESETREQ),
   .TRCENA         (w_TRCENA),
   .LOCKUP         (w_LOCKUP),
   .LOCKUPRESET    (w_LOCKUPRESET),

  // Peripherals
   .PORT0_IN       (w_PORT0_IN[7:0]),
   .PORT0_OUT      (w_PORT0_OUT[7:0]),
   .PORT0_EN       (w_PORT0_EN[7:0]),

   .PORT1_IN       (w_PORT1_IN[7:0]),
   .PORT1_OUT      (w_PORT1_OUT[7:0]),
   .PORT1_EN       (w_PORT1_EN[7:0]),

`ifdef FPGA_CONFIG
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
   
`endif   
  // Debug and trace
   .nTRST          (w_nTRST),
   .SWDITMS        (w_SWDITMS),	       // Test Mode Select/SWDIN
   .SWCLKTCK       (w_SWCLKTCK),       // Test clock / SWCLK
   .TDI            (w_TDI), 	       // Test Data In

   .SWDO           (w_SWDO),	       // SingleWire data out
   .SWDOEN         (w_SWDOEN),	       // SingleWire output enable

   .TDO            (w_TDO), 	       // Test Data Out
   .nTDOEN         (w_nTDOEN),	       // Test Data Out Enable  
  
   .TESTMODE       (TESTMODE)
  );

  assign TESTMODE = 1'b0;  // Not used for simulation
  
  // ----------------------------------
  // I/O pads
  // ----------------------------------
  
  // Clock
  behavioral_input_pad        u_input_pad_CLKIN(.PIN (CLKIN),   .POUT (w_CLKIN));
  // System reset
  behavioral_input_pullup_pad u_input_pad_nSRST(.PIN (nSRSTIN), .POUT (w_nSRSTIN));

  // Debug interface
  behavioral_input_pullup_pad u_input_pad_nTRST(.PIN (nTRST),   .POUT (w_nTRST));
  behavioral_tristate_pullup_pad u_inout_pad_SWDITMS (.POUT   (w_SWDO),
                                                   .POUT_EN(w_SWDOEN),
                                                   .PIN    (w_SWDITMS),
                                                   .PINOUT (SWDTMS));
  behavioral_input_pullup_pad u_input_pad_TCK(.PIN (SWCLKTCK), .POUT (w_SWCLKTCK));
  behavioral_input_pad        u_input_pad_TDI(.PIN (TDI),      .POUT (w_TDI));
  behavioral_output_pad       u_output_pad_TDO(.PIN (w_TDO),.POUT(TDO));

  // Port 0
  behavioral_tristate_pad u_io_pad_P0_0(
    .POUT(w_PORT0_OUT[0]),.POUT_EN(w_PORT0_EN[0]),.PIN(w_PORT0_IN[0]),.PINOUT(PORT0[0]));
  behavioral_tristate_pad u_io_pad_P0_1(
    .POUT(w_PORT0_OUT[1]),.POUT_EN(w_PORT0_EN[1]),.PIN(w_PORT0_IN[1]),.PINOUT(PORT0[1]));
  behavioral_tristate_pad u_io_pad_P0_2(
    .POUT(w_PORT0_OUT[2]),.POUT_EN(w_PORT0_EN[2]),.PIN(w_PORT0_IN[2]),.PINOUT(PORT0[2]));
  behavioral_tristate_pad u_io_pad_P0_3(
    .POUT(w_PORT0_OUT[3]),.POUT_EN(w_PORT0_EN[3]),.PIN(w_PORT0_IN[3]),.PINOUT(PORT0[3]));
  behavioral_tristate_pad u_io_pad_P0_4(
    .POUT(w_PORT0_OUT[4]),.POUT_EN(w_PORT0_EN[4]),.PIN(w_PORT0_IN[4]),.PINOUT(PORT0[4]));
  behavioral_tristate_pad u_io_pad_P0_5(
    .POUT(w_PORT0_OUT[5]),.POUT_EN(w_PORT0_EN[5]),.PIN(w_PORT0_IN[5]),.PINOUT(PORT0[5]));
  behavioral_tristate_pad u_io_pad_P0_6(
    .POUT(w_PORT0_OUT[6]),.POUT_EN(w_PORT0_EN[6]),.PIN(w_PORT0_IN[6]),.PINOUT(PORT0[6]));
  behavioral_tristate_pad u_io_pad_P0_7(
    .POUT(w_PORT0_OUT[7]),.POUT_EN(w_PORT0_EN[7]),.PIN(w_PORT0_IN[7]),.PINOUT(PORT0[7]));

  // Port 1
  behavioral_tristate_pad u_io_pad_P1_0(
    .POUT(w_PORT1_OUT[0]),.POUT_EN(w_PORT1_EN[0]),.PIN(w_PORT1_IN[0]),.PINOUT(PORT1[0]));
  behavioral_tristate_pad u_io_pad_P1_1(
    .POUT(w_PORT1_OUT[1]),.POUT_EN(w_PORT1_EN[1]),.PIN(w_PORT1_IN[1]),.PINOUT(PORT1[1]));
  behavioral_tristate_pad u_io_pad_P1_2(
    .POUT(w_PORT1_OUT[2]),.POUT_EN(w_PORT1_EN[2]),.PIN(w_PORT1_IN[2]),.PINOUT(PORT1[2]));
  behavioral_tristate_pad u_io_pad_P1_3(
    .POUT(w_PORT1_OUT[3]),.POUT_EN(w_PORT1_EN[3]),.PIN(w_PORT1_IN[3]),.PINOUT(PORT1[3]));
  behavioral_tristate_pad u_io_pad_P1_4(
    .POUT(w_PORT1_OUT[4]),.POUT_EN(w_PORT1_EN[4]),.PIN(w_PORT1_IN[4]),.PINOUT(PORT1[4]));
  behavioral_tristate_pad u_io_pad_P1_5(
    .POUT(w_PORT1_OUT[5]),.POUT_EN(w_PORT1_EN[5]),.PIN(w_PORT1_IN[5]),.PINOUT(PORT1[5]));
  behavioral_tristate_pad u_io_pad_P1_6(
    .POUT(w_PORT1_OUT[6]),.POUT_EN(w_PORT1_EN[6]),.PIN(w_PORT1_IN[6]),.PINOUT(PORT1[6]));
  behavioral_tristate_pad u_io_pad_P1_7(
    .POUT(w_PORT1_OUT[7]),.POUT_EN(w_PORT1_EN[7]),.PIN(w_PORT1_IN[7]),.PINOUT(PORT1[7]));

  
endmodule

    
