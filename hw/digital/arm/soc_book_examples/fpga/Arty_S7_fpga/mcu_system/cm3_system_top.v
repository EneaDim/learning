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
// Purpose: Example system top-level design
// ----------------------------------------------
`include "mcu_sys_defs.v"

module cm3_system_top (
  input  wire        FCLK,
  input  wire        HCLK,
  input  wire        TRACECLKIN,
  input  wire        HRESETn,
  input  wire        PORESETn,

  output wire        SLEEPING,
  output wire        SLEEPDEEP,
  output wire        GATEHCLK,
  output wire        WAKEUP,
  output wire        SYSRESETREQ,
  output wire        LOCKUP,
  output wire        LOCKUPRESET,
  output wire        TRCENA,

  // Peripherals
  input  wire  [7:0] PORT0_IN,
  output wire  [7:0] PORT0_OUT,
  output wire  [7:0] PORT0_EN,

  input  wire  [7:0] PORT1_IN,
  output wire  [7:0] PORT1_OUT,
  output wire  [7:0] PORT1_EN,
  
  // Debug and trace
  input  wire        nTRST,
  input  wire        SWDITMS,            // Test Mode Select/SWDIN
  input  wire        SWCLKTCK,           // Test clock / SWCLK
  input  wire        TDI,                // Test Data In

  output wire        SWDO,               // SingleWire data out
  output wire        SWDOEN,             // SingleWire output enable

  output wire        TDO,                // Test Data Out
  output wire        nTDOEN,             // Test Data Out Enable  

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
  input  wire        TESTMODE
  );

  // ROM interface
  wire        HSEL_ROM;
  wire [31:0] HADDR_ROM;
  wire  [1:0] HTRANS_ROM;
  wire  [2:0] HSIZE_ROM;
  wire        HREADY_ROM;
  wire        HWRITE_ROM;
  wire [31:0] HWDATA_ROM;
  wire        HREADYOUT_ROM;
  wire        HRESP_ROM;
  wire [31:0] HRDATA_ROM;
  wire        HEXCL_ROM;
  wire        HEXOKAY_ROM;  

  // SRAM interface
  wire        HSEL_RAM;
  wire [31:0] HADDR_RAM;
  wire  [1:0] HTRANS_RAM;
  wire  [2:0] HSIZE_RAM;
  wire        HREADY_RAM;
  wire        HWRITE_RAM;
  wire        HEXCL_RAM;
  wire        HREADYOUT_RAM;
  wire        HRESP_RAM;
  wire [31:0] HRDATA_RAM;
  wire [31:0] HWDATA_RAM;
  wire        HEXOKAY_RAM;  
  
  wire  [7:0] w_PORT0_OUT;
  wire  [7:0] w_PORT0_EN;

  wire  [7:0] w_PORT1_OUT;
  wire  [7:0] w_PORT1_EN;

  wire        w_UART0_TXD;
  wire        w_UART0_TXEN;
  wire        w_UART0_BAUDTICK;

  wire        w_JTAGNSW;
  wire        w_TDO;
  wire        w_nTDOEN;
  wire        w_SWV;
  wire        w_TRACECLK;
  wire  [3:0] w_TRACEDATA;
  
  wire        CDBGPWRUPREQ;
  wire        CDBGPWRUPACK;
  
  wire        w_LOCKUP_RESET_EN;

  cm3_processor_subsystem u_cm3_processor_subsystem (
   .FCLK           (FCLK),
   .HCLK           (HCLK),
   .TRACECLKIN     (TRACECLKIN),
   .PORESETn       (PORESETn),
   .HRESETn        (HRESETn),

   .SLEEPING       (SLEEPING),
   .SLEEPDEEP      (SLEEPDEEP),
   .GATEHCLK       (GATEHCLK),
   .WAKEUP         (WAKEUP),
   .TRCENA         (TRCENA),
   .LOCKUP         (LOCKUP),
   .LOCKUP_RESET_EN(w_LOCKUP_RESET_EN),
   .SYSRESETREQ    (SYSRESETREQ),
   
  
  // ROM interface
   .HSEL_ROM       (HSEL_ROM),
   .HADDR_ROM      (HADDR_ROM),
   .HTRANS_ROM     (HTRANS_ROM),
   .HSIZE_ROM      (HSIZE_ROM),
   .HREADY_ROM     (HREADY_ROM),
   .HWRITE_ROM     (HWRITE_ROM),
   .HWDATA_ROM     (HWDATA_ROM),
   .HREADYOUT_ROM  (HREADYOUT_ROM),
   .HRESP_ROM      (HRESP_ROM),
   .HRDATA_ROM     (HRDATA_ROM),
   .HEXCL_ROM      (HEXCL_ROM),
   .HEXOKAY_ROM    (HEXOKAY_ROM),  

  // SRAM interface
   .HSEL_RAM       (HSEL_RAM),
   .HADDR_RAM      (HADDR_RAM),
   .HTRANS_RAM     (HTRANS_RAM),
   .HSIZE_RAM      (HSIZE_RAM),
   .HREADY_RAM     (HREADY_RAM),
   .HWRITE_RAM     (HWRITE_RAM),
   .HEXCL_RAM      (HEXCL_RAM),
   .HREADYOUT_RAM  (HREADYOUT_RAM),
   .HWDATA_RAM     (HWDATA_RAM),
   .HRESP_RAM      (HRESP_RAM),
   .HRDATA_RAM     (HRDATA_RAM),
   .HEXOKAY_RAM    (HEXOKAY_RAM),  

  // Peripherals
   .PORT0_IN       (PORT0_IN[7:0]),
   .PORT0_OUT      (w_PORT0_OUT[7:0]),
   .PORT0_EN       (w_PORT0_EN[7:0]),

   .PORT1_IN       (PORT1_IN[7:0]),
   .PORT1_OUT      (w_PORT1_OUT[7:0]),
   .PORT1_EN       (w_PORT1_EN[7:0]),
  
   .TIMER0_IN      (PORT1_IN[0]),
   .TIMER1_IN      (PORT1_IN[1]),

`ifdef FPGA_CONFIG
   .UART0_RXD      (uart_txd_in),
   .UART0_TXD      (uart_rxd_out),
   .UART0_TXEN     (),
   .UART0_BAUDTICK (),
`else   
   .UART0_RXD      (PORT0_IN[4]),
   .UART0_TXD      (w_UART0_TXD),
   .UART0_TXEN     (w_UART0_TXEN),
   .UART0_BAUDTICK (w_UART0_BAUDTICK),
`endif    
  // Debug and trace pins
   .SWDITMS        (SWDITMS),	// Test Mode Select/SWDIN
   .SWCLKTCK       (SWCLKTCK),	// Test clock / SWCLK
   .TDI            (TDI), 	// Test Data In
   .nTRST          (nTRST),

   .SWDO           (SWDO),	// SingleWire data out
   .SWDOEN         (SWDOEN),	// SingleWire output enable
   .JTAGNSW        (w_JTAGNSW),	// JTAG mode(1) or SW mode(0)

   .TDO            (w_TDO), 	   // Test Data Out
   .nTDOEN         (w_nTDOEN),	   // Test Data Out Enable
   .SWV            (w_SWV), 	   // SingleWire Viewer Data
  
   .TRACECLK       (w_TRACECLK),   // TracePort clock reference
   .TRACEDATA      (w_TRACEDATA),  // TracePort Data

   .CDBGPWRUPACK   (CDBGPWRUPACK), // Debug power up acknowledge
   .CDBGPWRUPREQ   (CDBGPWRUPREQ), // Debug power up request

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
`endif   
  // DFT mode control
   .RSTBYPASS      (TESTMODE),
   .CGBYPASS       (TESTMODE)
  );

`ifdef FPGA_CONFIG
  // For FPGA
  // No need to multiplex UART pins with GPIO, so these can be tied low
  assign w_UART0_TXEN = 1'b0;
  assign w_UART0_BAUDTICK = 1'b0;
`endif
  
  //--------------------------------
`ifdef FPGA_CONFIG
  // 32KB RAM
  AHBBlockRam #(.AWIDTH (15)) u_ahb_rom (
   .HCLK       (HCLK),    // Clock
   .HRESETn    (HRESETn), // Reset
   .HSEL       (HSEL_ROM),    // Device select
   .HADDR      (HADDR_ROM[14:0]),   // Address
   .HTRANS     (HTRANS_ROM[1:0]),  // Transfer control
   .HSIZE      (HSIZE_ROM),   // Transfer size
   .HWRITE     (HWRITE_ROM),  // Write control
   .HWDATA     (HWDATA_ROM),  // Write data
   .HREADY     (HREADY_ROM),  // Transfer phase done
   .HREADYOUT  (HREADYOUT_ROM), // Device ready
   .HRDATA     (HRDATA_ROM),  // Read data output
   .HRESP      (HRESP_ROM)   // Device response (always OKAY)
  );
  
  assign HEXOKAY_ROM = 1'b0;
`else  
  // 64KB RAM
  ahb_rom u_ahb_rom (
   .HCLK       (HCLK),    // Clock
   .HRESETn    (HRESETn), // Reset
   .HSEL       (HSEL_ROM),	// Device select
   .HADDR      (HADDR_ROM[15:0]),	// Address
   .HTRANS     (HTRANS_ROM),	// Transfer control
   .HSIZE      (HSIZE_ROM),	// Transfer size
   .HREADY     (HREADY_ROM),	// Transfer phase done
   .HREADYOUT  (HREADYOUT_ROM), // Device ready
   .HRDATA     (HRDATA_ROM),	// Read data output
   .HRESP      (HRESP_ROM),	// Device response (always OKAY)
   .HEXOKAY    (HEXOKAY_ROM)    // Exclusive okay (not used)
   );

`endif

  //--------------------------------
`ifdef FPGA_CONFIG
  // 16KB RAM
  AHB5BlockRamExcl #(.AWIDTH (14)) u_ahb_ram (
   .HCLK       (HCLK),    // Clock
   .HRESETn    (HRESETn), // Reset
   .HSEL       (HSEL_RAM),    // Device select
   .HMASTER    (4'b0000), // Master identification, only one master
   .HADDR      (HADDR_RAM[13:0]),   // Address
   .HTRANS     (HTRANS_RAM[1:0]),  // Transfer control
   .HSIZE      (HSIZE_RAM),   // Transfer size
   .HWRITE     (HWRITE_RAM),  // Write control
   .HWDATA     (HWDATA_RAM),  // Write data
   .HEXCL      (HEXCL_RAM),   // Exclusive transfer
   .HREADY     (HREADY_RAM),  // Transfer phase done
   .HREADYOUT  (HREADYOUT_RAM), // Device ready
   .HRDATA     (HRDATA_RAM),  // Read data output
   .HRESP      (HRESP_RAM),   // Device response (always OKAY)
   .HEXOKAY    (HEXOKAY_RAM)  // Exclusve okay
  );
`else  
  // 64KB RAM
  ahb_ram u_ahb_ram (
   .HCLK       (HCLK),    // Clock
   .HRESETn    (HRESETn), // Reset
   .HSEL       (HSEL_RAM),    // Device select
   .HMASTER    (4'b0000), // Master identification, only one master
   .HADDR      (HADDR_RAM[15:0]),   // Address
   .HTRANS     (HTRANS_RAM[1:0]),  // Transfer control
   .HSIZE      (HSIZE_RAM),   // Transfer size
   .HWRITE     (HWRITE_RAM),  // Write control
   .HWDATA     (HWDATA_RAM),  // Write data
   .HEXCL      (HEXCL_RAM),   // Exclusive transfer
   .HREADY     (HREADY_RAM),  // Transfer phase done
   .HREADYOUT  (HREADYOUT_RAM), // Device ready
   .HRDATA     (HRDATA_RAM),  // Read data output
   .HRESP      (HRESP_RAM),   // Device response (always OKAY)
   .HEXOKAY    (HEXOKAY_RAM)  // Exclusve okay
  );
`endif

  //--------------------------------
  // System control - Only handle DBG powerup loop back
  //                  and automatic reset when LOCKUP
  sys_ctrl u_sys_ctrl (
   .FCLK           (FCLK),
   .PORESETn       (PORESETn),
   .CDBGPWRUPREQ   (CDBGPWRUPREQ),
   .CDBGPWRUPACK   (CDBGPWRUPACK),
   
   .LOCKUP         (LOCKUP),
   .LOCKUP_RESET_EN(w_LOCKUP_RESET_EN),
   .LOCKUPRESET    (LOCKUPRESET)
  );
  
  //----------------------------------------
  // Pin mux

  // Port 0
  assign PORT0_OUT[0] = w_PORT0_OUT[0];
  assign PORT0_EN[0]  = w_PORT0_EN[0];
  assign PORT0_OUT[1] = w_PORT0_OUT[1];
  assign PORT0_EN[1]  = w_PORT0_EN[1];
  assign PORT0_OUT[2] = w_PORT0_OUT[2];
  assign PORT0_EN[2]  = w_PORT0_EN[2];
  assign PORT0_OUT[3] = w_PORT0_OUT[3];
  assign PORT0_EN[3]  = w_PORT0_EN[3];
  assign PORT0_OUT[4] = w_PORT0_OUT[4]; // P0[4] - Shared with RXD
  assign PORT0_EN[4]  = w_PORT0_EN[4];
  assign PORT0_OUT[5] = (w_UART0_TXEN) ? w_UART0_TXD: w_PORT0_OUT[5];
  assign PORT0_EN[5]  = (w_UART0_TXEN) ? 1'b1       : w_PORT0_EN[5];
  assign PORT0_OUT[6] = (w_UART0_TXEN) ? w_UART0_BAUDTICK:w_PORT0_OUT[6]; // for testbench
  assign PORT0_EN[6]  = (w_UART0_TXEN) ? 1'b1       : w_PORT0_EN[6]; // (UART monitor)
  assign PORT0_OUT[7] = w_PORT0_OUT[7];
  assign PORT0_EN[7]  = w_PORT0_EN[7];

  // Port 1
  assign PORT1_OUT[0] = w_PORT1_OUT[0]; // P1[0] - Shared with Timer0 input
  assign PORT1_EN[0]  = w_PORT1_EN[0];
  assign PORT1_OUT[1] = w_PORT1_OUT[1]; // P1[1] - Shared with Timer1 input
  assign PORT1_EN[1]  = w_PORT1_EN[1];
  assign PORT1_OUT[2] = w_PORT1_OUT[2];
  assign PORT1_EN[2]  = w_PORT1_EN[2];
  assign PORT1_OUT[3] = (TRCENA) ? w_TRACECLK    : w_PORT1_OUT[3];
  assign PORT1_EN[3]  = (TRCENA) ? 1'b1          : w_PORT1_EN[3];
  assign PORT1_OUT[4] = (TRCENA) ? w_TRACEDATA[0]: w_PORT1_OUT[4];
  assign PORT1_EN[4]  = (TRCENA) ? 1'b1          : w_PORT1_EN[4];
  assign PORT1_OUT[5] = (TRCENA) ? w_TRACEDATA[1]: w_PORT1_OUT[5];
  assign PORT1_EN[5]  = (TRCENA) ? 1'b1          : w_PORT1_EN[5];
  assign PORT1_OUT[6] = (TRCENA) ? w_TRACEDATA[2]: w_PORT1_OUT[6];
  assign PORT1_EN[6]  = (TRCENA) ? 1'b1          : w_PORT1_EN[6];
  assign PORT1_OUT[7] = (TRCENA) ? w_TRACEDATA[3]: w_PORT1_OUT[7];
  assign PORT1_EN[7]  = (TRCENA) ? 1'b1          : w_PORT1_EN[7];

  // TDO mux
  assign TDO          = (w_JTAGNSW) ? w_TDO   : w_SWV;
  assign nTDOEN       = (w_JTAGNSW) ? w_nTDOEN: 1'b0;
  
endmodule
