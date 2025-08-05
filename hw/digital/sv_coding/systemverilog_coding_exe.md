# SystemVerilog Exercises (Basic to Advanced)

This document contains a complete set of 23 SystemVerilog exercises designed to develop your RTL coding skills from beginner to advanced, in line with the lowRISC coding style.

---

## 🧩 Exercise 1: Define a Packed Struct for a Register Entry

Create a packed struct `reg_entry_t` with the following fields:

* `valid` (1 bit)
* `addr` (16 bits)
* `data` (32 bits)

---

## 🧩 Exercise 2: Implement a Register File Using the Struct

Declare an array of 8 `reg_entry_t` elements named `reg_file`.

---

## 🧩 Exercise 3: Write a Sequential Block to Update the Register File

Write an `always_ff` block that updates the `data` field of each `reg_file` entry by incrementing it by 1, only if its `valid` bit is set.

---

## 🧩 Exercise 4: Create a Parameterized Register File Module

Design a module `reg_file_module` with:

* Parameter `DEPTH`
* Inputs: `clk_i`, `valid_i [DEPTH]`
* Outputs: `data_o [DEPTH]` (each 32 bits)

---

## 🧩 Exercise 5: Resettable Counter

Design a 4-bit counter that resets to 0 on active-low reset and increments on each clock edge.

---

## 🧩 Exercise 6: Register with Write Enable

Create a 32-bit register that updates only when `wen_i` is high.

---

## 🧩 Exercise 7: Priority Encoder

Given a 4-bit input `req_i`, output the index of the lowest asserted bit using `casez`.

---

## 🧩 Exercise 8: Register Array Write Port

Create a register file with 8 entries, 16 bits each. Add a write port controlled by `wen_i`, `addr_i`, and `wdata_i`.

---

## 🧩 Exercise 9: Parameterized FIFO Declaration

Declare a synthesizable FIFO signal `fifo` with width 32 and depth controlled by parameter `DEPTH`.

---

## 🧩 Exercise 10: Valid-Ready Handshake Buffer

Design a single-word buffer with a valid/ready interface, asserting `ready_o` only when it can accept data.

---

## 🧩 Exercise 11: One-Hot FSM

Implement a one-hot encoded FSM with states `IDLE`, `LOAD`, and `DONE`, transitioning based on inputs `start_i` and `ack_i`.

---

## 🧩 Exercise 12: Basic Two-Stage Pipeline

Create a two-stage pipeline where each stage registers and passes the data forward.

---

## 🧩 Exercise 13: Parameterized Array of Modules

Instantiate 4 copies of a module, each with a unique parameter value (`ID`).

---

## 🧩 Exercise 14: Masked Bit Update

Combine `orig_i`, `mask_i`, and `data_i` so that only bits in the mask are updated.

---

## 🧩 Exercise 15: Two-Stage Valid-Ready Pipeline

Use two handshake buffers to implement a 2-stage valid/ready pipeline.

---

## 🧩 Exercise 16: N-Stage Valid-Ready Pipeline

Extend the previous idea to a parameterized `STAGES` pipeline using a generate block.

---

## 🧩 Exercise 17: Advanced N-Stage Pipeline with Flush and Skid Buffer

Enhance the N-stage pipeline to support:

* Flush on `flush_i`
* Optional skid buffer at output

---

## 🧩 Exercise 18: Round-Robin Arbiter

Design a round-robin arbiter for N requesters with one-hot grant output and fairness.

---

## 🧩 Exercise 19: AXI4-Lite to TileLink UL Bridge (Write and Read)

Implement a protocol bridge module converting AXI4-Lite to TileLink UL, handling both read and write paths.

---

## 🧩 Exercise 20: Multi-Port Register File with Hazard Detection

Build a 4-read / 2-write register file that detects write-write and read-after-write hazards.

---

## 🧩 Exercise 21: Multi-Stage Pipeline Controller

Create a controller that activates each stage in a pipeline one clock cycle apart after `start_i`.

---

## 🧩 Exercise 22: Cache Tag RAM + Hit/Miss Logic

Design a cache tag RAM with configurable associativity and tag matching logic.

---

## 🧩 Exercise 23: Clock Domain Crossing Pulse Synchronizer

Create a module that safely transfers a single-cycle pulse from `clk_src_i` to `clk_dst_i`.

---

## 🧩 Exercise 1: Define a Packed Struct for a Register Entry

Create a packed struct `reg_entry_t` with the following fields:

* `valid` (1 bit)
* `addr` (16 bits)
* `data` (32 bits)

### ✅ Solution

A packed struct keeps all fields tightly packed without extra padding, ideal for hardware storage and predictable layout.

```systemverilog
// Packed struct for register entries
typedef struct packed {
  logic        valid;        // Indicates if the register is valid
  logic [15:0] addr;         // Address field
  logic [31:0] data;         // Data field
} reg_entry_t;
```

This struct will be used in later exercises to build a register file.

---

## 🧩 Exercise 2: Implement a Register File Using the Struct

Declare an array of 8 `reg_entry_t` elements named `reg_file`.

### ✅ Solution

This defines an array of structured entries.

```systemverilog
// Declare register file with 8 entries
reg_entry_t reg_file [8];
```

This array is now a small memory of registers, each with valid, addr, and data.

---

## 🧩 Exercise 3: Write a Sequential Block to Update the Register File

Write an `always_ff` block that updates the `data` field of each `reg_file` entry by incrementing it by 1, only if its `valid` bit is set.

### ✅ Solution

Use an `always_ff` block to perform synchronous updates.

```systemverilog
always_ff @(posedge clk_i) begin
  for (int i = 0; i < 8; i++) begin
    if (reg_file[i].valid) begin
      reg_file[i].data <= reg_file[i].data + 1; // Increment data if valid
    end
  end
end
```

This structure will update only the valid registers each cycle.

---

## 🧩 Exercise 4: Create a Parameterized Register File Module

Design a module `reg_file_module` with:

* Parameter `DEPTH`
* Inputs: `clk_i`, `valid_i [DEPTH]`
* Outputs: `data_o [DEPTH]` (each 32 bits)

### ✅ Solution

Parameterized modules increase reuse and flexibility.

```systemverilog
module reg_file_module #(
  parameter int DEPTH = 8
)(
  input  logic clk_i,
  input  logic [DEPTH-1:0] valid_i,
  output logic [DEPTH-1:0][31:0] data_o
);

  typedef struct packed {
    logic        valid;
    logic [15:0] addr;
    logic [31:0] data;
  } reg_entry_t;

  reg_entry_t reg_file [DEPTH];

  always_ff @(posedge clk_i) begin
    for (int i = 0; i < DEPTH; i++) begin
      if (valid_i[i]) begin
        reg_file[i].data <= reg_file[i].data + 1;
      end
    end
  end

  for (genvar i = 0; i < DEPTH; i++) begin : gen_out
    assign data_o[i] = reg_file[i].data;
  end

endmodule
```

The generate block cleanly assigns outputs for each register.

---

## 🧩 Exercise 5: Resettable Counter

Design a 4-bit counter that resets to 0 on active-low reset and increments on each clock edge.

### ✅ Solution

Use reset and clock inputs in a typical `always_ff` block.

```systemverilog
module counter_4bit (
  input  logic clk_i,
  input  logic rst_ni,
  output logic [3:0] count_o
);

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      count_o <= 4'd0;  // Synchronous reset
    end else begin
      count_o <= count_o + 1;  // Increment each clock
    end
  end

endmodule
```

This is a clean 4-bit counter with wrap-around after 15.

---

## 🧩 Exercise 6: Register with Write Enable

Create a 32-bit register that updates only when `wen_i` is high.

### ✅ Solution

A write-enable gated register is common in control registers.

```systemverilog
module reg_wen (
  input  logic clk_i,
  input  logic rst_ni,
  input  logic wen_i,
  input  logic [31:0] data_i,
  output logic [31:0] reg_q
);

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      reg_q <= '0; // Reset to 0
    end else if (wen_i) begin
      reg_q <= data_i; // Update when enabled
    end
  end

endmodule
```

This is a typical pattern for memory-mapped registers.

---

## 🧩 Exercise 7: Priority Encoder

Given a 4-bit input `req_i`, output the index of the lowest asserted bit using `casez`.

### ✅ Solution

Use `casez` for pattern matching and priority.

```systemverilog
module priority_encoder (
  input  logic [3:0] req_i,
  output logic [1:0] sel_o
);

  always_comb begin
    unique casez (req_i)
      4'b???1: sel_o = 2'd0;
      4'b??10: sel_o = 2'd1;
      4'b?100: sel_o = 2'd2;
      4'b1000: sel_o = 2'd3;
      default: sel_o = 2'd0;
    endcase
  end

endmodule
```

This gives a lowest-index first priority.

---

## 🧩 Exercise 8: Register Array Write Port

Create a register file with 8 entries, 16 bits each. Add a write port controlled by `wen_i`, `addr_i`, and `wdata_i`.

### ✅ Solution

Use a register array and write to it when `wen_i` is asserted.

```systemverilog
module regfile_write_port (
  input  logic        clk_i,
  input  logic        rst_ni,
  input  logic        wen_i,        // Write enable
  input  logic  [2:0] addr_i,       // Write address (3 bits for 8 entries)
  input  logic [15:0] wdata_i,      // Write data
  output logic [15:0] regfile [8]   // Register file output for visibility
);

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      for (int i = 0; i < 8; i++) begin
        regfile[i] <= '0; // Clear all entries on reset
      end
    end else if (wen_i) begin
      regfile[addr_i] <= wdata_i; // Write when enabled
    end
  end

endmodule
```

A simple register file write port with synchronous reset.

---

## 🧩 Exercise 9: Parameterized FIFO Declaration

Declare a synthesizable FIFO signal `fifo` with width 32 and depth controlled by parameter `DEPTH`.

### ✅ Solution

Parameterization provides reusable logic blocks.

```systemverilog
module fifo_decl #(
  parameter int unsigned DEPTH = 16
)(
  output logic [31:0] fifo [DEPTH] // Synthesizable memory declaration
);
```

This defines a 32-bit wide FIFO buffer.

---

## 🧩 Exercise 10: Valid-Ready Handshake Buffer

Design a single-word buffer with a valid/ready interface, asserting `ready_o` only when it can accept data.

### ✅ Solution

This buffer holds one value and supports backpressure handling.

```systemverilog
module handshake_buf (
  input  logic        clk_i,
  input  logic        rst_ni,

  input  logic        valid_i,
  input  logic [31:0] data_i,
  output logic        ready_o,

  output logic        valid_o,
  output logic [31:0] data_o,
  input  logic        ready_i
);

  logic        full_q;
  logic [31:0] data_q;

  // Accept new data if buffer is empty or output is consumed
  assign ready_o = !full_q || (ready_i && valid_o);
  assign valid_o = full_q;
  assign data_o  = data_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      full_q <= 1'b0;
    end else begin
      if (valid_i && ready_o) begin
        data_q <= data_i;
        full_q <= 1'b1;
      end else if (valid_o && ready_i) begin
        full_q <= 1'b0;
      end
    end
  end

endmodule
```

A single-stage flow-control buffer, safe for connecting producers and consumers.

---

## 🧩 Exercise 11: One-Hot FSM

Implement a one-hot encoded FSM with states `IDLE`, `LOAD`, and `DONE`, transitioning based on inputs `start_i` and `ack_i`.

### ✅ Solution

One-hot encoding simplifies decoding and is synthesis-friendly.

```systemverilog
typedef enum logic [2:0] {
  S_IDLE = 3'b001,
  S_LOAD = 3'b010,
  S_DONE = 3'b100
} fsm_state_e;

module onehot_fsm (
  input  logic clk_i,
  input  logic rst_ni,
  input  logic start_i,
  input  logic ack_i,
  output fsm_state_e state_q
);

  fsm_state_e state_d;

  // Next-state logic
  always_comb begin
    state_d = state_q;
    unique case (state_q)
      S_IDLE: if (start_i) state_d = S_LOAD;
      S_LOAD:              state_d = S_DONE;
      S_DONE: if (ack_i)   state_d = S_IDLE;
      default:             state_d = S_IDLE;
    endcase
  end

  // State register
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      state_q <= S_IDLE;
    end else begin
      state_q <= state_d;
    end
  end

endmodule
```

This FSM transitions through states with clear logic, each state being one-hot encoded.

---

## 🧩 Exercise 12: Basic Two-Stage Pipeline

Create a two-stage pipeline where each stage registers and passes the data forward.

### ✅ Solution

Each stage has a register and updates synchronously.

```systemverilog
module pipeline2 (
  input  logic        clk_i,
  input  logic        rst_ni,
  input  logic [31:0] data_i,
  output logic [31:0] data_o
);

  logic [31:0] stage1_q, stage2_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      stage1_q <= '0;
      stage2_q <= '0;
    end else begin
      stage1_q <= data_i;       // First pipeline stage
      stage2_q <= stage1_q;     // Second pipeline stage
    end
  end

  assign data_o = stage2_q;     // Final output

endmodule
```

Useful for separating timing paths or logic stages.

---

## 🧩 Exercise 13: Parameterized Array of Modules

Instantiate 4 copies of a module, each with a unique parameter value (`ID`).

### ✅ Solution

Use a generate block for instantiation.

```systemverilog
module bit_counter #(parameter int ID = 0)(
  input  logic clk_i,
  output logic [7:0] count_o
);

  logic [7:0] count_q;

  always_ff @(posedge clk_i) begin
    count_q <= count_q + ID; // Increment by unique ID
  end

  assign count_o = count_q;
endmodule

module bit_counter_array (
  input  logic clk_i,
  output logic [3:0][7:0] counts_o
);

  for (genvar i = 0; i < 4; i++) begin : gen_counters
    bit_counter #(.ID(i+1)) u_counter (
      .clk_i(clk_i),
      .count_o(counts_o[i])
    );
  end

endmodule
```

A scalable pattern for instantiating logic blocks.

---

## 🧩 Exercise 14: Masked Bit Update

Combine `orig_i`, `mask_i`, and `data_i` so that only bits in the mask are updated.

### ✅ Solution

Use bitwise operations to merge fields.

```systemverilog
module masked_update (
  input  logic [7:0] orig_i,
  input  logic [7:0] data_i,
  input  logic [7:0] mask_i,
  output logic [7:0] result_o
);

  // Preserve bits not in mask, replace masked bits
  assign result_o = (orig_i & ~mask_i) | (data_i & mask_i);

endmodule
```

This is widely used in CSR and partial register writes.

---
## 🧩 Exercise 15: Two-Stage Valid-Ready Pipeline

Use two handshake buffers to implement a 2-stage valid/ready pipeline.

### ✅ Solution

Chain two instances of the `handshake_buf` module. This creates a backpressure-aware pipeline with two stages.

```systemverilog
module pipeline2_stage (
  input  logic        clk_i,
  input  logic        rst_ni,

  // Input interface
  input  logic        valid_i,
  input  logic [31:0] data_i,
  output logic        ready_o,

  // Output interface
  output logic        valid_o,
  output logic [31:0] data_o,
  input  logic        ready_i
);

  // Internal signals between stages
  logic        valid_mid, ready_mid;
  logic [31:0] data_mid;

  // First stage buffer
  handshake_buf u_stage1 (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .valid_i(valid_i),
    .data_i(data_i),
    .ready_o(ready_o),
    .valid_o(valid_mid),
    .data_o(data_mid),
    .ready_i(ready_mid)
  );

  // Second stage buffer
  handshake_buf u_stage2 (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .valid_i(valid_mid),
    .data_i(data_mid),
    .ready_o(ready_mid),
    .valid_o(valid_o),
    .data_o(data_o),
    .ready_i(ready_i)
  );

endmodule
```

This modular design enables simple pipelining of streaming data with backpressure support.

---

## 🧩 Exercise 16: N-Stage Valid-Ready Pipeline

Extend the previous idea to a parameterized `STAGES` pipeline using a generate block.

### ✅ Solution

Use arrays and generate loops to build a scalable design.

```systemverilog
module pipeline_n_stage #(
  parameter int unsigned STAGES = 4
)(
  input  logic clk_i,
  input  logic rst_ni,

  input  logic        valid_i,
  input  logic [31:0] data_i,
  output logic        ready_o,

  output logic        valid_o,
  output logic [31:0] data_o,
  input  logic        ready_i
);

  // Declare internal arrays to connect stages
  logic [STAGES:0]       valid;
  logic [STAGES:0]       ready;
  logic [STAGES:0][31:0] data;

  // Connect external signals to stage 0 and STAGES
  assign valid[0] = valid_i;
  assign data[0]  = data_i;
  assign ready_o  = ready[0];

  assign valid_o  = valid[STAGES];
  assign data_o   = data[STAGES];
  assign ready[STAGES] = ready_i;

  // Instantiate STAGES handshake buffers
  for (genvar i = 0; i < STAGES; i++) begin : gen_pipeline
    handshake_buf u_stage (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .valid_i  (valid[i]),
      .data_i   (data[i]),
      .ready_o  (ready[i]),
      .valid_o  (valid[i+1]),
      .data_o   (data[i+1]),
      .ready_i  (ready[i+1])
    );
  end

endmodule
```

With this setup, you can create deep pipelines without duplicating logic manually.

---

## 🧩 Exercise 17: Advanced N-Stage Pipeline with Flush and Skid Buffer

Enhance the N-stage pipeline to support:

* Flush on `flush_i`
* Optional skid buffer at output

### ✅ Solution

We add flush handling and optionally a final skid buffer to hold unconsumed data.

```systemverilog
module pipeline_n_stage_adv #(
  parameter int unsigned STAGES = 4,
  parameter bit USE_SKIDBUF = 1'b1
)(
  input  logic clk_i,
  input  logic rst_ni,
  input  logic flush_i,

  input  logic        valid_i,
  input  logic [31:0] data_i,
  output logic        ready_o,

  output logic        valid_o,
  output logic [31:0] data_o,
  input  logic        ready_i
);

  logic [STAGES:0]       valid;
  logic [STAGES:0]       ready;
  logic [STAGES:0][31:0] data;

  assign valid[0] = valid_i;
  assign data[0]  = data_i;
  assign ready_o  = ready[0];

  assign ready[STAGES] = ready_i;

  // Pipeline logic with flush support
  for (genvar i = 0; i < STAGES; i++) begin : gen_pipeline
    logic        val_q;
    logic [31:0] dat_q;

    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni || flush_i) begin
        val_q <= 1'b0;
      end else if (ready[i] && valid[i]) begin
        val_q <= 1'b1;
        dat_q <= data[i];
      end else if (ready[i]) begin
        val_q <= 1'b0;
      end
    end

    assign valid[i+1] = val_q;
    assign data[i+1]  = dat_q;
    assign ready[i]   = !val_q || (valid[i+1] && ready[i+1]);
  end

  // Optional skid buffer
  if (USE_SKIDBUF) begin : gen_skid
    logic        val_q;
    logic [31:0] dat_q;

    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni || flush_i) begin
        val_q <= 1'b0;
      end else if (valid[STAGES] && ready[STAGES]) begin
        val_q <= 1'b1;
        dat_q <= data[STAGES];
      end else if (ready_i) begin
        val_q <= 1'b0;
      end
    end

    assign valid_o = val_q;
    assign data_o  = dat_q;
  end else begin : gen_passthru
    assign valid_o = valid[STAGES];
    assign data_o  = data[STAGES];
  end

endmodule
```

This gives full control and configurability for high-performance pipelines.

---
## 🧩 Exercise 18: Round-Robin Arbiter

Design a round-robin arbiter for N requesters with one-hot grant output and fairness.

### ✅ Solution

Use a register to track the last granted requester and rotate priority accordingly.

```systemverilog
module rr_arbiter #(
  parameter int unsigned N = 4
)(
  input  logic              clk_i,
  input  logic              rst_ni,
  input  logic [N-1:0]      req_i,     // Request signals
  output logic [N-1:0]      grant_o    // One-hot grant output
);

  logic [$clog2(N)-1:0] last_grant_q, next_grant;

  always_comb begin
    grant_o = '0;
    next_grant = last_grant_q;
    for (int i = 1; i <= N; i++) begin
      int idx = (last_grant_q + i) % N;
      if (req_i[idx]) begin
        grant_o[idx] = 1'b1;
        next_grant = idx;
        break;
      end
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni)
      last_grant_q <= 0;
    else if (|req_i)
      last_grant_q <= next_grant;
  end

endmodule
```

The loop ensures fair rotation by wrapping around the request vector.

---

## 🧩 Exercise 19: AXI4-Lite to TileLink UL Bridge and viceversa (Write and Read)

Implement a protocol bridge module converting AXI4-Lite to TileLink UL and viceversa, handling both read and write paths.

### ✅ Solution

A simplified state machine for bridging both AXI write and read to TileLink.

```systemverilog
module axi_to_tlul (
  input  logic        clk_i,
  input  logic        rst_ni,

  // AXI write address channel
  input  logic        aw_valid_i,
  input  logic [31:0] aw_addr_i,
  output logic        aw_ready_o,

  // AXI write data channel
  input  logic        w_valid_i,
  input  logic [31:0] w_data_i,
  output logic        w_ready_o,

  // AXI write response channel
  output logic        b_valid_o,
  input  logic        b_ready_i,

  // AXI read address channel
  input  logic        ar_valid_i,
  input  logic [31:0] ar_addr_i,
  output logic        ar_ready_o,

  // AXI read data channel
  output logic        r_valid_o,
  output logic [31:0] r_data_o,
  input  logic        r_ready_i,

  // TileLink UL interface
  output logic        tl_valid_o,
  output logic [31:0] tl_addr_o,
  output logic [31:0] tl_data_o,
  output logic        tl_is_write_o,
  input  logic        tl_ready_i,
  input  logic        tl_resp_valid_i,
  input  logic [31:0] tl_resp_data_i
);

  typedef enum logic [1:0] {IDLE, WREQ, WRESP} wr_state_e;
  wr_state_e wr_state_q, wr_state_d;

  typedef enum logic [1:0] {RIDLE, RREQ, RRESP} rd_state_e;
  rd_state_e rd_state_q, rd_state_d;

  // Write FSM
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) wr_state_q <= IDLE;
    else         wr_state_q <= wr_state_d;
  end

  always_comb begin
    wr_state_d = wr_state_q;
    aw_ready_o = 0;
    w_ready_o  = 0;
    b_valid_o  = 0;
    tl_valid_o = 0;
    tl_is_write_o = 1;
    tl_addr_o  = aw_addr_i;
    tl_data_o  = w_data_i;

    case (wr_state_q)
      IDLE: if (aw_valid_i && w_valid_i) begin
        aw_ready_o = 1;
        w_ready_o  = 1;
        wr_state_d = WREQ;
      end
      WREQ: if (tl_ready_i) begin
        tl_valid_o = 1;
        wr_state_d = WRESP;
      end
      WRESP: if (b_ready_i) begin
        b_valid_o = 1;
        wr_state_d = IDLE;
      end
    endcase
  end

  // Read FSM
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) rd_state_q <= RIDLE;
    else         rd_state_q <= rd_state_d;
  end

  always_comb begin
    rd_state_d = rd_state_q;
    ar_ready_o = 0;
    r_valid_o  = 0;
    tl_valid_o = 0;
    tl_is_write_o = 0;
    tl_addr_o  = ar_addr_i;

    case (rd_state_q)
      RIDLE: if (ar_valid_i) begin
        ar_ready_o = 1;
        rd_state_d = RREQ;
      end
      RREQ: if (tl_ready_i) begin
        tl_valid_o = 1;
        rd_state_d = RRESP;
      end
      RRESP: if (tl_resp_valid_i && r_ready_i) begin
        r_valid_o  = 1;
        r_data_o   = tl_resp_data_i;
        rd_state_d = RIDLE;
      end
    endcase
  end

endmodule


// TileLink UL to AXI4-Lite Bridge
// Converts TL-UL A/D channel transactions into AXI4-Lite compliant read/write cycles.
module tlul_to_axi (
  input  logic        clk_i,
  input  logic        rst_ni,

  // TileLink UL A-channel (Request)
  input  logic        tl_a_valid,
  output logic        tl_a_ready,
  input  logic [31:0] tl_a_address,
  input  logic [31:0] tl_a_data,
  input  logic [2:0]  tl_a_opcode,

  // TileLink UL D-channel (Response)
  output logic        tl_d_valid,
  input  logic        tl_d_ready,
  output logic [31:0] tl_d_data,

  // AXI4-Lite Write Address Channel
  output logic        aw_valid_o,
  output logic [31:0] aw_addr_o,
  input  logic        aw_ready_i,

  // AXI4-Lite Write Data Channel
  output logic        w_valid_o,
  output logic [31:0] w_data_o,
  input  logic        w_ready_i,

  // AXI4-Lite Write Response Channel
  input  logic        b_valid_i,
  output logic        b_ready_o,

  // AXI4-Lite Read Address Channel
  output logic        ar_valid_o,
  output logic [31:0] ar_addr_o,
  input  logic        ar_ready_i,

  // AXI4-Lite Read Data Channel
  input  logic        r_valid_i,
  input  logic [31:0] r_data_i,
  output logic        r_ready_o
);

  typedef enum logic [1:0] {IDLE, SEND_REQ, WAIT_RESP} tl_state_e;
  tl_state_e wr_state_q, wr_state_d;
  tl_state_e rd_state_q, rd_state_d;

  // Write FSM: Handles TL-UL PutFullData as AXI Write
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) wr_state_q <= IDLE;
    else         wr_state_q <= wr_state_d;
  end

  always_comb begin
    wr_state_d  = wr_state_q;
    aw_valid_o  = 0;
    aw_addr_o   = tl_a_address;
    w_valid_o   = 0;
    w_data_o    = tl_a_data;
    b_ready_o   = 1;
    tl_a_ready  = 0;
    tl_d_valid  = 0;
    tl_d_data   = 32'h0;

    case (wr_state_q)
      IDLE: if (tl_a_valid && tl_a_opcode == 3'h0) begin // PutFullData
        tl_a_ready  = 1;
        wr_state_d  = SEND_REQ;
      end
      SEND_REQ: if (aw_ready_i && w_ready_i) begin
        aw_valid_o  = 1;
        w_valid_o   = 1;
        wr_state_d  = WAIT_RESP;
      end
      WAIT_RESP: if (b_valid_i && tl_d_ready) begin
        tl_d_valid  = 1;
        wr_state_d  = IDLE;
      end
    endcase
  end

  // Read FSM: Handles TL-UL Get as AXI Read
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) rd_state_q <= IDLE;
    else         rd_state_q <= rd_state_d;
  end

  always_comb begin
    rd_state_d  = rd_state_q;
    ar_valid_o  = 0;
    ar_addr_o   = tl_a_address;
    r_ready_o   = 1;
    tl_a_ready  = 0;
    tl_d_valid  = 0;
    tl_d_data   = r_data_i;

    case (rd_state_q)
      IDLE: if (tl_a_valid && tl_a_opcode == 3'h4) begin // Get
        tl_a_ready  = 1;
        rd_state_d  = SEND_REQ;
      end
      SEND_REQ: if (ar_ready_i) begin
        ar_valid_o  = 1;
        rd_state_d  = WAIT_RESP;
      end
      WAIT_RESP: if (r_valid_i && tl_d_ready) begin
        tl_d_valid  = 1;
        rd_state_d  = IDLE;
      end
    endcase
  end

endmodule

```

This version supports both directions with FSM sequencing and data latching.

---

## 🧩 Exercise 20: Multi-Port Register File with Hazard Detection

Build a 4-read / 2-write register file that detects write-write and read-after-write hazards.

### ✅ Solution

Detect overlapping accesses across multiple ports.

```systemverilog
module regfile_multiport #(
  parameter int WIDTH = 32,
  parameter int DEPTH = 32
)(
  input  logic clk_i,
  input  logic rst_ni,
  input  logic [1:0] wr_en_i,
  input  logic [1:0][4:0] wr_addr_i,
  input  logic [1:0][WIDTH-1:0] wr_data_i,
  input  logic [3:0][4:0] rd_addr_i,
  output logic [3:0][WIDTH-1:0] rd_data_o,
  output logic hazard_o
);

  logic [DEPTH-1:0][WIDTH-1:0] rf;

  // Write logic
  always_ff @(posedge clk_i) begin
    for (int i = 0; i < 2; i++) begin
      if (wr_en_i[i]) begin
        rf[wr_addr_i[i]] <= wr_data_i[i];
      end
    end
  end

  // Read logic
  always_comb begin
    for (int i = 0; i < 4; i++) begin
      rd_data_o[i] = rf[rd_addr_i[i]];
    end
  end

  // Hazard detection (write-write only for simplicity)
  assign hazard_o = wr_en_i[0] && wr_en_i[1] && (wr_addr_i[0] == wr_addr_i[1]);

endmodule
```

This detects conflicting simultaneous writes.

---

## 🧩 Exercise 21: Multi-Stage Pipeline Controller

Create a controller that activates each stage in a pipeline one clock cycle apart after `start_i`.

### ✅ Solution

Shift a `start` pulse across a chain of flip-flops.

```systemverilog
module pipeline_ctrl #(
  parameter int STAGES = 4
)(
  input  logic clk_i,
  input  logic rst_ni,
  input  logic start_i,
  output logic [STAGES-1:0] stage_valid_o
);

  logic [STAGES-1:0] stage_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      stage_q <= '0;
    end else begin
      stage_q[0] <= start_i;
      for (int i = 1; i < STAGES; i++) begin
        stage_q[i] <= stage_q[i-1];
      end
    end
  end

  assign stage_valid_o = stage_q;

endmodule
```

Each stage fires one cycle after the previous.

---

## 🧩 Exercise 22: Cache Tag RAM + Hit/Miss Logic

Design a cache tag RAM with configurable associativity and tag matching logic.

### ✅ Solution

Compare a requested tag with all valid tags in a set.

```systemverilog
module cache_tags #(
  parameter int WAYS = 4,
  parameter int SETS = 64,
  parameter int TAGW = 20
)(
  input  logic [5:0] set_i,
  input  logic [TAGW-1:0] tag_i,
  output logic hit_o,
  output logic [$clog2(WAYS)-1:0] way_hit_o
);

  typedef struct packed {
    logic valid;
    logic [TAGW-1:0] tag;
  } tag_entry_t;

  tag_entry_t tags[SETS][WAYS];

  always_comb begin
    hit_o = 0;
    way_hit_o = '0;
    for (int i = 0; i < WAYS; i++) begin
      if (tags[set_i][i].valid && tags[set_i][i].tag == tag_i) begin
        hit_o = 1;
        way_hit_o = i;
      end
    end
  end

endmodule
```

Simulates associative lookup used in caches.

---

## 🧩 Exercise 23: Clock Domain Crossing Pulse Synchronizer

Create a module that safely transfers a single-cycle pulse from `clk_src_i` to `clk_dst_i`.

### ✅ Solution

Use toggle synchronization and XOR detection.

```systemverilog
module pulse_sync (
  input  logic clk_src_i,
  input  logic clk_dst_i,
  input  logic rst_ni,
  input  logic pulse_i,
  output logic pulse_o
);

  logic toggle_src, toggle_meta, toggle_sync;

  // Toggle generation in source domain
  always_ff @(posedge clk_src_i or negedge rst_ni) begin
    if (!rst_ni)
      toggle_src <= 0;
    else if (pulse_i)
      toggle_src <= ~toggle_src;
  end

  // Synchronize to destination domain
  always_ff @(posedge clk_dst_i or negedge rst_ni) begin
    if (!rst_ni) begin
      toggle_meta <= 0;
      toggle_sync <= 0;
    end else begin
      toggle_meta <= toggle_src;
      toggle_sync <= toggle_meta;
    end
  end

  assign pulse_o = toggle_meta ^ toggle_sync;

endmodule
```

This is a safe and robust CDC solution.

---

