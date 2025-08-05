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
// Purpose: Simple Cortex-M3 simulation testbench
// ----------------------------------------------

module tbench_cm3;

  wire           CLK;
  wire           RESETn;
  wire  [7:0]    PORT0;
  wire  [7:0]    PORT1;
  wire           SWDTMS;
  wire           SWCLKTCK;
  wire           TDI;
  wire           TDO;  

  // Signal for UART testing and printf
  wire           w_UART_TX;
  wire           w_UART_RX;
  wire           w_UART_STDOUT;

  // Clock and reset generation
  tb_clk_reset_gen u_tb_clk_reset_generator (
    .CLK       (CLK),
    .RESETn    (RESETn)
    );


  // Top level of simple microcontroller
  cm3_mcu u_cm3_mcu (
    .CLKIN     (CLK),
    .nSRSTIN   (RESETn),
    
    .PORT0     (PORT0),
    .PORT1     (PORT1),
    

    .nTRST     (RESETn),
    .SWDTMS    (SWDTMS),
    .SWCLKTCK  (SWCLKTCK),
    .TDI       (TDI),
    .TDO       ()
  
  );

  pullup(SWDTMS);
  pullup(SWCLKTCK);
  pullup(TDI);

  assign w_UART_TX = PORT0[5];

  // UART monitor for output text during simulation
  uart_mon uart_mon (
    .CLK       (CLK),
    .RESETn    (RESETn),

    .RXD       (w_UART_STDOUT),
    .BAUDTICK  (PORT0[6])
  );

  pullup(PORT0[4]);
  pullup(PORT0[5]);
  pullup(PORT0[6]);
  pullup(PORT0[7]);

  // UART loop back for testing
  // - mask UART stdout   when PORT0[7] is pulled low
  assign w_UART_STDOUT = (PORT0[7]) ? w_UART_TX : 1'b1; 
  // - loop UART TX to RX when PORT0[7] is pulled low 
  assign w_UART_RX     = (PORT0[7]) ? 1'bz      : w_UART_TX; 
  assign PORT0[4]      = w_UART_RX;

endmodule
