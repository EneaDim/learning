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
// Purpose: Simple 64kB RAM with AHB interface
// ----------------------------------------------
// 
//
module ahb_ram (
  input  wire        HCLK,    // Clock
  input  wire        HRESETn, // Reset
  input  wire        HSEL,    // Device select
  input  wire [3:0]  HMASTER, // Master identification
  input  wire [15:0] HADDR,   // Address
  input  wire [1:0]  HTRANS,  // Transfer control
  input  wire [2:0]  HSIZE,   // Transfer size
  input  wire        HWRITE,  // Write control
  input  wire [31:0] HWDATA,  // Write data
  input  wire        HEXCL,   // Exclusive transfer
  input  wire        HREADY,  // Transfer phase done
  output wire        HREADYOUT, // Device ready
  output wire [31:0] HRDATA,  // Read data output
  output wire        HRESP,   // Device response (always OKAY)
  output wire        HEXOKAY  // Exclusve okay
  );

  // Internal signals
  reg    [7:0]  RamData[0:65535]; // 64k byte of RAM data
  integer       i;            // Loop counter for zero initialization
  wire          ReadValid;    // Address phase read valid
  wire          WriteValid;   // Address phase write valid
  reg           ReadEnable;   // Data phase read enable
  reg           WriteEnable;  // Data phase write enable
  reg    [3:0]  RegByteLane;  // Data phase byte lane 
  reg    [3:0]  NextByteLane; // Next state of RegByteLane

  wire   [7:0]  RDataOut0;    // Read Data Output byte#0
  wire   [7:0]  RDataOut1;    // Read Data Output byte#1
  wire   [7:0]  RDataOut2;    // Read Data Output byte#2
  wire   [7:0]  RDataOut3;    // Read Data Output byte#3
  reg   [15:0]  WordAddr;     // Word aligned address
  
  reg   [15:4]  Excl_Tag_Addr;     // Exclusive access address
  reg   [ 3:0]  Excl_Tag_MID;      // Exclusive access master ID
  reg           Excl_State;        // Exclusive state
  reg           ExclOkay;          // Exclusive Okay status (data phase)
  reg           ExclStoreFail;     // Exclusive Failed state (data phase)

  // Start of main code
  // Initialize ROM
  initial
    begin
    for (i=0;i<65536;i=i+1)
      begin
      RamData[i] = 8'h00; //Initialize all data to 0 to avoid X propagation
      end
    //$readmemh("image.dat", RamData); // Then read in program code
    end

  // Generate read control (address phase)
  assign ReadValid  = HSEL & HREADY & HTRANS[1] & ~HWRITE;
  // Generate write control (address phase)
  assign WriteValid = HSEL & HREADY & HTRANS[1] & HWRITE;

  // Read enable for each byte (address phase)
  always @(ReadValid or WriteValid or HADDR or HSIZE)
  begin
  if (ReadValid | WriteValid)
    begin
    case (HSIZE)
      0 : // Byte
        begin
        case (HADDR[1:0])
          0: NextByteLane = 4'b0001; // Byte 0
          1: NextByteLane = 4'b0010; // Byte 1
          2: NextByteLane = 4'b0100; // Byte 2
          3: NextByteLane = 4'b1000; // Byte 3
	    default:NextByteLane = 4'b0000; // Address not valid
        endcase
        end
      1 : // Halfword
        begin
        if (HADDR[1])
          NextByteLane = 4'b1100; // Upper halfword
        else
          NextByteLane = 4'b0011; // Lower halfword
        end
      default : // Word
        NextByteLane = 4'b1111; // Whole word
    endcase
    end
  else
    NextByteLane = 4'b0000; // Not reading
  end

  // Registering control signals to data phase
  always @(posedge HCLK or negedge HRESETn)
  begin
    if (~HRESETn)
      begin
      RegByteLane <= 4'b0000;
      ReadEnable  <= 1'b0;
      WriteEnable <= 1'b0;
      WordAddr    <= {16{1'b0}};
      end
    else if (HREADY)
      begin
      RegByteLane <= NextByteLane;
      ReadEnable  <= ReadValid;
      WriteEnable <= WriteValid;
      WordAddr    <= {HADDR[15:2], 2'b00};
      end
  end

  // Read operation  
  assign RDataOut0 = (ReadEnable & RegByteLane[0]) ? RamData[WordAddr  ] : 8'h00;
  assign RDataOut1 = (ReadEnable & RegByteLane[1]) ? RamData[WordAddr+1] : 8'h00;
  assign RDataOut2 = (ReadEnable & RegByteLane[2]) ? RamData[WordAddr+2] : 8'h00;
  assign RDataOut3 = (ReadEnable & RegByteLane[3]) ? RamData[WordAddr+3] : 8'h00;

  // Registered write
  always @(posedge HCLK)
  begin
    if (WriteEnable &  RegByteLane[0] & ~ExclStoreFail)
      begin
      RamData[WordAddr  ] = HWDATA[ 7: 0];
      end
    if (WriteEnable &  RegByteLane[1] & ~ExclStoreFail)
      begin
      RamData[WordAddr+1] = HWDATA[15: 8];
      end
    if (WriteEnable &  RegByteLane[2] & ~ExclStoreFail)
      begin
      RamData[WordAddr+2] = HWDATA[23:16];
      end
    if (WriteEnable &  RegByteLane[3] & ~ExclStoreFail)
      begin
      RamData[WordAddr+3] = HWDATA[31:24];
      end
  end

  // Exclusive accesses tags - single monitor example  
  always @(posedge HCLK or negedge HRESETn)
  begin
  if (~HRESETn)
    begin
    Excl_Tag_Addr <= {12{1'b0}}; // Address
    Excl_Tag_MID  <= {4{1'b0}};  // Master ID
    end
  else if (ReadValid & HEXCL) // Exclusive reads
    begin
    Excl_Tag_Addr <= HADDR[15:4];
    Excl_Tag_MID  <= HMASTER[3:0];
    end
  end	

  // Exclusive state
  always @(posedge HCLK or negedge HRESETn)
  begin
  if (~HRESETn)
    Excl_State <= 1'b0;
  else 
    if (ReadValid & HEXCL) // Exclusive read
      Excl_State <= 1'b1;
	else if (WriteValid & (HMASTER!=Excl_Tag_MID[3:0]) & (HADDR[15:4]==Excl_Tag_Addr[15:4]))
      Excl_State <= 1'b0; // Another bus master write to same location	
    else if (WriteValid & HEXCL) // Another bus master performed an exclusive write
      Excl_State <= 1'b0;
  end

  // Generate exclusive access response controls 
  always @(posedge HCLK or negedge HRESETn)
  begin
  if (~HRESETn)
    begin
    ExclOkay       <= 1'b0;
    ExclStoreFail  <= 1'b0;
    end
  else if (HREADY)
    if (ReadValid & HEXCL)
      begin
      ExclOkay       <= 1'b1;
      ExclStoreFail  <= 1'b0;
      end
    else if  (WriteValid & HEXCL) // Exclusive store
      if ((HMASTER==Excl_Tag_MID[3:0]) & (HADDR[15:4]==Excl_Tag_Addr[15:4]) & Excl_State) // exclusive Okay 
        begin  
        ExclOkay      <= 1'b1;
        ExclStoreFail <= 1'b0;
        end
      else // Exclusive failed - either exclusive state is not set, or bus master ID doesn't match 
        begin
        ExclOkay      <= 1'b0;
        ExclStoreFail <= 1'b1; // Block write
        end
      else
        begin
        ExclOkay      <= 1'b0;  // Not exclusive accesses	
        ExclStoreFail <= 1'b0;
        end
  end  

  // Connect to top level
  assign HREADYOUT = 1'b1; // Always ready (no waitstate)
  assign HRESP     = 1'b0; // Always response with OKAY
  assign HEXOKAY   = ExclOkay & HREADYOUT;
  // Read data output
  assign HRDATA    = {RDataOut3, RDataOut2, RDataOut1,RDataOut0};
    
endmodule
