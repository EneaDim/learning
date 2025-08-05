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
// Purpose: APB to asynchronous peripheral bus
// ----------------------------------------------
module apb_to_async_wrapper (
  input  wire        PCLK,    // Clock
  input  wire        PRESETn, // Reset
    // APB interface inputs
  input  wire        PSEL,    // Device select
  input  wire [7:2]  PADDR,   // Address
  input  wire        PENABLE, // Transfer control
  input  wire        PWRITE,  // Write control
  input  wire [31:0] PWDATA,  // Write data
   // APB interface outputs
  output wire [31:0] PRDATA,  // Read data
  output wire        PREADY,  // Device ready
  output wire        PSLVERR, // Device error response

   // simple interface's output
  output wire [7:2]  Addr,         // Address
  output wire [31:0] WrData,       // Write Data
  output wire        ReadEnable,   // Read enable
  output wire        WriteEnable,  // Write enable
  output wire        OutputEnable, // Tristate buffer for WrData
  input  wire [31:0] RdData        // Read data
  );

  // Cycles for read & write, values are example only. Modify if needed.
  localparam  RD_CYCLE=4'h3; // 3 cycles for read 
  localparam  WR_CYCLE=4'h2; // 2 cycles for write
  // Encoding of FSM states
  localparam  FSM_IDLE=3'b000;   // Idle state
  localparam  FSM_READ_1=3'b100; // Read operation
  localparam  FSM_READ_2=3'b101; // Turnaround
  localparam  FSM_WRITE_1=3'b110; // Write operation
  localparam  FSM_WRITE_2=3'b111; // Turnaround
  
  wire       RdStart;        // Read started
  wire       WrStart;        // Write started
  wire       OpDone;         // Operation done
  reg [3:0]  reg_cycle;      // wait cycle counter
  reg [3:0]  nxt_cycle;      // next state for reg_cycle
  reg [2:0]  reg_fsm_state;  // FSM state register
  reg [2:0]  nxt_fsm_state;  // next state for reg_fsm_state
  reg        reg_ReadEnable; // Registered ReadEnable output
  reg        reg_WriteEnable;// Registered WriteEnable output
  reg        reg_OutputEnable;// Registered OutputEnable output
  reg [31:0] reg_rdata;
  
  assign RdStart = PSEL & ~PENABLE & ~PWRITE;
  assign WrStart = PSEL & ~PENABLE &  PWRITE;  
  
  // Counter to handle multi-cycle operations
  always @(*)
  begin
    if (RdStart)
      nxt_cycle = RD_CYCLE;
    else if (WrStart)
      nxt_cycle = WR_CYCLE;
    else if (|reg_cycle)
      nxt_cycle = reg_cycle - 1'b1;
    else
      nxt_cycle = reg_cycle;
  end
  
  always @(posedge PCLK or negedge PRESETn)
    begin
    if (~PRESETn)
      reg_cycle <= 4'b0000;
    else
      reg_cycle <= nxt_cycle;
    end
  
  assign OpDone = (nxt_cycle==4'b0000) & reg_fsm_state[2];

  // FSM
  always @(*)
  begin
    case (reg_fsm_state[2:0])
      FSM_IDLE,FSM_READ_2,FSM_WRITE_2:
        begin
        if (RdStart)
          nxt_fsm_state = FSM_READ_1;
	else if (WrStart) 
          nxt_fsm_state = FSM_WRITE_1;
	else
	  nxt_fsm_state = FSM_IDLE;
	end
      FSM_READ_1:
        nxt_fsm_state = OpDone? FSM_READ_2: FSM_READ_1;
      FSM_WRITE_1:
        nxt_fsm_state = OpDone? FSM_WRITE_2: FSM_WRITE_1;
      default: // should not be here
        nxt_fsm_state = FSM_IDLE;
    endcase			
  end
  
  always @(posedge PCLK or negedge PRESETn)
    begin
    if (~PRESETn)
      reg_fsm_state <= FSM_IDLE;
    else
      reg_fsm_state <= nxt_fsm_state;
    end

  // Sample read data from bus slave
  always @(posedge PCLK or negedge PRESETn)
    begin
    if (~PRESETn)
      reg_rdata <= {32{1'b0}};
    else if ((reg_fsm_state==FSM_READ_1) & OpDone)
      reg_rdata <= RdData;
    end

  // Registering ReadEnble control
  always @(posedge PCLK or negedge PRESETn)
    begin
    if (~PRESETn)
      reg_ReadEnable <= 1'b0;
    else
      reg_ReadEnable <= (RdStart|reg_ReadEnable) & ~OpDone;
    end

  // Registering WriteEnble control
  always @(posedge PCLK or negedge PRESETn)
    begin
    if (~PRESETn)
      reg_WriteEnable <= 1'b0;
    else
      reg_WriteEnable <= (WrStart|reg_WriteEnable) & ~OpDone;
    end

  // Registering OutputEnable (tristate buffer) control
  always @(posedge PCLK or negedge PRESETn)
    begin
    if (~PRESETn)
      reg_OutputEnable <= 1'b0;
    else
      reg_OutputEnable <= (WrStart|reg_OutputEnable) &
      ~(reg_fsm_state==FSM_WRITE_2);
    end
  
  assign PRDATA       = (PENABLE & ~PWRITE) ? reg_rdata:{32{1'b0}};
  assign PSLVERR      = 1'b0;
  assign PREADY       =
  ~((reg_fsm_state==FSM_READ_1)||(reg_fsm_state==FSM_WRITE_1));

  // Output to bus slave
  assign Addr[7:2]    = PADDR[7:2]; 
  // Note: assumed PADDR is registered in AHB to APB bridge
  assign WrData[31:0] = PWDATA[31:0]; 
  // Note: PWDATA should be stable before reaching FSM_WRITE_1

  // Connect registered R/W control outputs to top level
  assign ReadEnable   = reg_ReadEnable;
  assign WriteEnable  = reg_WriteEnable;
  assign OutputEnable = reg_OutputEnable;

endmodule
  
