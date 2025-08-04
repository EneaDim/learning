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
// Purpose: Device specific system Control Registers
// ----------------------------------------------

`include "mcu_sys_defs.v"

module apb_sys_ctrl_reg (
  input  wire        PCLK,    // Clock
  input  wire        PRESETn, // Reset
  // APB interface inputs
  input  wire        PSEL,    // Device select
  input  wire [7:2]  PADDR,   // Address
  input  wire        PENABLE, // Transfer control
  input  wire        PWRITE,  // Write control
  input  wire [31:0] PWDATA,  // Write data
  input  wire [2:0]  PPROT,   // Protection
  // APB interface outputs
  output wire [31:0] PRDATA,  // Read data
  output wire        PREADY,  // Device ready
  output wire        PSLVERR, // Device error response
`ifdef FPGA_CONFIG
  // Arty S7 FPGA I/O
  input  wire   [3:0] sw,          // Switches
  output wire         led0_r,      // RGB LED 0 - R
  output wire         led0_g,      // RGB LED 0 - G
  output wire         led0_b,      // RGB LED 0 - B
  output wire         led1_r,      // RGB LED 1 - R
  output wire         led1_g,      // RGB LED 1 - G
  output wire         led1_b,      // RGB LED 1 - B
  output wire   [3:0] led,         // LEDs
  input  wire   [3:0] btn,         // Button
`endif  
  output wire        LOCKUP_RESET_EN // Lock-up reset enable
  );

  // Signals for read/write controls
  wire          ReadEnable;
  reg    [15:0] ReadMux;
  reg    [15:0] ReadMuxReg;
  wire          WriteEnable;
  wire          WriteEnable00; // Write enable for Control register
`ifdef FPGA_CONFIG
  wire          WriteEnable04; // Write enable for RegLED      register
  wire          WriteEnable08; // Write enable for RegRGB_led0 register
  wire          WriteEnable0C; // Write enable for RegRGB_led1 register
`endif
  // Signals for Control registers
  reg           RegCTRL;
`ifdef FPGA_CONFIG
  reg     [3:0] RegLED;
  reg    [11:0] RegRGB_led0;
  reg    [11:0] RegRGB_led1;
  reg     [3:0] RegSW;
  reg     [3:0] RegBTN;
  reg     [3:0] RegSWsync1;
  reg     [3:0] RegBTNsync1;
`endif  

  // Start of main code
  // Read and write control signals
  assign  ReadEnable  = PSEL & (~PWRITE); // assert for whole APB read transfer
  assign  WriteEnable = PSEL & (~PENABLE) & PWRITE; // assert for 1st cycle of write transfer
  assign  WriteEnable00 = WriteEnable & (PADDR[7:2] == 6'b000000) & PPROT[0]; // Note:Privileged access only
`ifdef FPGA_CONFIG
  assign  WriteEnable04 = WriteEnable & (PADDR[7:2] == 6'b000001); // RegLED
  assign  WriteEnable08 = WriteEnable & (PADDR[7:2] == 6'b000010); // RegRGB_led0
  assign  WriteEnable0C = WriteEnable & (PADDR[7:2] == 6'b000011); // RegRGB_led1
`endif

  // Write operations
  // Control register
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (~PRESETn)
      RegCTRL <= {1'b0};
    else if (WriteEnable00)
      RegCTRL <= PWDATA[0];
  end

  assign LOCKUP_RESET_EN = RegCTRL;

`ifdef FPGA_CONFIG
  // RegLED register
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (~PRESETn)
      RegLED <= {4{1'b0}};
    else if (WriteEnable04)
      RegLED <= PWDATA[3:0];
  end

  // RegRGB_led0 register
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (~PRESETn)
      RegRGB_led0 <= {12{1'b0}};
    else if (WriteEnable08)
      RegRGB_led0 <= PWDATA[11:0];
  end

  // RegRGB_led1 register
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (~PRESETn)
      RegRGB_led1 <= {12{1'b0}};
    else if (WriteEnable0C)
      RegRGB_led1 <= PWDATA[11:0];
  end

    // RegSW & RegBTN registers with double DFF synchronisation
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    begin
    RegSW       <= {4{1'b0}};
    RegBTN      <= {4{1'b0}};
    RegSWsync1  <= {4{1'b0}};
    RegBTNsync1 <= {4{1'b0}};
    end
  else
    begin
    RegSW       <= RegSWsync1;
    RegBTN      <= RegBTNsync1;
    RegSWsync1  <= sw[3:0];
    RegBTNsync1 <= btn[3:0];
    end
  end

`endif

// Read operation
  always @(*)
  begin
  case (PADDR[7:2])
   0: ReadMux =  {{15{1'b0}}, RegCTRL};
`ifdef FPGA_CONFIG   
   1: ReadMux =  {{12{1'b0}}, RegLED};
   2: ReadMux =  { {4{1'b0}}, RegRGB_led0};
   3: ReadMux =  { {4{1'b0}}, RegRGB_led1};
   4: ReadMux =  {{12{1'b0}}, RegSW};
   5: ReadMux =  {{12{1'b0}}, RegBTN};
`endif
   default : ReadMux = {16{1'b0}}; // Read as 0 if address is out of range
  endcase
  end

  // Register read data
  always @(posedge PCLK or negedge PRESETn)
  begin
    if (~PRESETn)
      ReadMuxReg <= {16{1'b0}};
    else 
      ReadMuxReg <= ReadMux;
  end

  // Output read data to APB
  assign PRDATA = (ReadEnable) ? {{16{1'b0}},ReadMuxReg} : {32{1'b0}};
  assign PREADY  = 1'b1; // Always ready
  assign PSLVERR = 1'b0; // Always okay

`ifdef FPGA_CONFIG   
  // PWMs for RGB LEDs
  wire [3:0] w_r_level0;
  wire [3:0] w_g_level0;
  wire [3:0] w_b_level0;
  wire [3:0] w_r_level1;
  wire [3:0] w_g_level1;
  wire [3:0] w_b_level1;

  reg [3:0]  reg_rgb_pwm_cntr;
  reg        reg_r_pwm_out0;
  reg        reg_g_pwm_out0;
  reg        reg_b_pwm_out0;
  reg        reg_r_pwm_out1;
  reg        reg_g_pwm_out1;
  reg        reg_b_pwm_out1;

  assign led    = RegLED;
  assign led0_r = reg_r_pwm_out0;
  assign led0_g = reg_g_pwm_out0;
  assign led0_b = reg_b_pwm_out0;
  assign led1_r = reg_r_pwm_out1;
  assign led1_g = reg_g_pwm_out1;
  assign led1_b = reg_b_pwm_out1;

  assign w_r_level0 = RegRGB_led0[3:0];
  assign w_g_level0 = RegRGB_led0[7:4];
  assign w_b_level0 = RegRGB_led0[11:8];
  assign w_r_level1 = RegRGB_led1[3:0];
  assign w_g_level1 = RegRGB_led1[7:4];
  assign w_b_level1 = RegRGB_led1[11:8];

  // 4-bit PWM counter
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    reg_rgb_pwm_cntr <= {4{1'b0}};
  else
    reg_rgb_pwm_cntr <= reg_rgb_pwm_cntr+1'b1;
  end  

  // PWM - R channel #0
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    reg_r_pwm_out0  <= 1'b0;
  else
    begin
    if (w_r_level0==4'b0000)
      reg_r_pwm_out0  <= 1'b0;
    else if (w_r_level0==4'b1111)
      reg_r_pwm_out0  <= 1'b1;
    else if (reg_rgb_pwm_cntr==4'b1111)
      reg_r_pwm_out0  <= 1'b1;
    else if (reg_rgb_pwm_cntr==w_r_level0)
      reg_r_pwm_out0  <= 1'b0;      
    end
  end  

  // PWM - G channel #0
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    reg_g_pwm_out0  <= 1'b0;
  else
    begin
    if (w_g_level0==4'b0000)
      reg_g_pwm_out0  <= 1'b0;
    else if (w_g_level0==4'b1111)
      reg_g_pwm_out0  <= 1'b1;
    else if (reg_rgb_pwm_cntr==4'b1111)
      reg_g_pwm_out0  <= 1'b1;
    else if (reg_rgb_pwm_cntr==w_g_level0)
      reg_g_pwm_out0  <= 1'b0;      
    end
  end  

  // PWM - B channel #0
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    reg_b_pwm_out0  <= 1'b0;
  else
    begin
    if (w_b_level0==4'b0000)
      reg_b_pwm_out0  <= 1'b0;
    else if (w_b_level0==4'b1111)
      reg_b_pwm_out0  <= 1'b1;
    else if (reg_rgb_pwm_cntr==4'b1111)
      reg_b_pwm_out0  <= 1'b1;
    else if (reg_rgb_pwm_cntr==w_b_level0)
      reg_b_pwm_out0  <= 1'b0;      
    end
  end  

  // PWM - R channel #1
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    reg_r_pwm_out1  <= 1'b0;
  else
    begin
    if (w_r_level1==4'b0000)
      reg_r_pwm_out1  <= 1'b0;
    else if (w_r_level1==4'b1111)
      reg_r_pwm_out1  <= 1'b1;
    else if (reg_rgb_pwm_cntr==4'b1111)
      reg_r_pwm_out1  <= 1'b1;
    else if (reg_rgb_pwm_cntr==w_r_level1)
      reg_r_pwm_out1  <= 1'b0;      
    end
  end  

  // PWM - G channel #1
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    reg_g_pwm_out1  <= 1'b0;
  else
    begin
    if (w_g_level1==4'b0000)
      reg_g_pwm_out1  <= 1'b0;
    else if (w_g_level1==4'b1111)
      reg_g_pwm_out1  <= 1'b1;
    else if (reg_rgb_pwm_cntr==4'b1111)
      reg_g_pwm_out1  <= 1'b1;
    else if (reg_rgb_pwm_cntr==w_g_level1)
      reg_g_pwm_out1  <= 1'b0;      
    end
  end  

  // PWM - B channel #1
  always @(posedge PCLK or negedge PRESETn)
  begin
  if (~PRESETn)
    reg_b_pwm_out1  <= 1'b0;
  else
    begin
    if (w_b_level1==4'b0000)
      reg_b_pwm_out1  <= 1'b0;
    else if (w_b_level1==4'b1111)
      reg_b_pwm_out1  <= 1'b1;
    else if (reg_rgb_pwm_cntr==4'b1111)
      reg_b_pwm_out1  <= 1'b1;
    else if (reg_rgb_pwm_cntr==w_b_level0)
      reg_b_pwm_out1  <= 1'b0;      
    end
  end  
`endif
endmodule
