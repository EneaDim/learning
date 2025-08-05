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
// Purpose: Simple RAM for FPGA projects with AHB interface
// ----------------------------------------------
// 
//
`include "mcu_sys_defs.v"

module AHBBlockRam #(
  // --------------------------------------
  // Parameter Declarations
  // --------------------------------------
  parameter AWIDTH = 12
  )
  (
  // --------------------------------------
  // Port Definitions
  // --------------------------------------
  input  wire        HCLK,        // system bus clock
  input  wire        HRESETn,     // system bus reset
  input  wire        HSEL,        // AHB peripheral select
  input  wire        HREADY,      // AHB ready input
  input  wire [1:0]  HTRANS,      // AHB transfer type
  input  wire [2:0]  HSIZE,       // AHB hsize
  input  wire        HWRITE,      // AHB hwrite
  input  wire [AWIDTH-1:0] HADDR, // AHB address bus
  input  wire [31:0] HWDATA,      // AHB write data bus
  output wire        HREADYOUT,   // AHB ready output to S->M mux
  output wire        HRESP,       // AHB response
  output wire [31:0] HRDATA       // AHB read data bus
  );

  parameter AWT = ((1<<(AWIDTH-2))-1); // index max value
  // --- Memory Array ---
  reg [7:0] BRAM0 [0:AWT];
  reg [7:0] BRAM1 [0:AWT];
  reg [7:0] BRAM2 [0:AWT];
  reg [7:0] BRAM3 [0:AWT];

  // --- Internal signals ---
  reg [AWIDTH-2:0] haddrQ;
  wire             Valid;
  reg        [3:0] WrEnQ;
  wire       [3:0] WrEnD;
  wire             WrEn;

  // --------------------------------------
  // Main body of code
  // --------------------------------------
  assign Valid = HSEL & HREADY & HTRANS[1];

  // --- RAM Write Interface ---
  // Write byte strobe
  assign WrEnD[0] = (((HADDR[1:0]==2'b00) && (HSIZE[1:0]==2'b00)) ||
                     ((HADDR[  1]==1'b0 ) && (HSIZE[1:0]==2'b01)) ||
                     ((HSIZE[1:0]==2'b10))) ? Valid & HWRITE : 1'b0;
  assign WrEnD[1] = (((HADDR[1:0]==2'b01) && (HSIZE[1:0]==2'b00)) ||
                     ((HADDR[  1]==1'b0 ) && (HSIZE[1:0]==2'b01)) ||
                     ((HSIZE[1:0]==2'b10))) ? Valid & HWRITE : 1'b0;
  assign WrEnD[2] = (((HADDR[1:0]==2'b10) && (HSIZE[1:0]==2'b00)) ||
                     ((HADDR[  1]==1'b1 ) && (HSIZE[1:0]==2'b01)) ||
                     ((HSIZE[1:0]==2'b10))) ? Valid & HWRITE : 1'b0;
  assign WrEnD[3] = (((HADDR[1:0]==2'b11) && (HSIZE[1:0]==2'b00)) ||
                     ((HADDR[  1]==1'b1 ) && (HSIZE[1:0]==2'b01)) ||
                     ((HSIZE[1:0]==2'b10))) ? Valid & HWRITE : 1'b0;

  // Clock enable for Write strobes
  assign WrEn = (Valid & HWRITE) | (|WrEnQ);
  // Registering Write strobes
  always @ (negedge HRESETn or posedge HCLK)
  if (~HRESETn)
    WrEnQ <= 4'b0000;
  else if (WrEn)
    WrEnQ <= WrEnD;

  // --- Infer RAM ---
  always @ (posedge HCLK)
  begin
  if (WrEnQ[0])
    BRAM0[haddrQ] <= HWDATA[7:0];
  if (WrEnQ[1])
    BRAM1[haddrQ] <= HWDATA[15:8];
  if (WrEnQ[2])
    BRAM2[haddrQ] <= HWDATA[23:16];
  if (WrEnQ[3])
    BRAM3[haddrQ] <= HWDATA[31:24];

  // do not use enable on read interface.
  haddrQ <= HADDR[AWIDTH-1:2];
  end

  
`ifdef CM_SRAM_INIT
  initial begin
    $readmemh("itcm3", BRAM3);
    $readmemh("itcm2", BRAM2);
    $readmemh("itcm1", BRAM1);
    $readmemh("itcm0", BRAM0);
  end
`endif

  // --- AHB Outputs ---
  assign HRESP = 1'b0; // OKAY
  assign HREADYOUT = 1'b1; // always ready
  assign HRDATA = {BRAM3[haddrQ],BRAM2[haddrQ],BRAM1[haddrQ],BRAM0[haddrQ]};
endmodule
