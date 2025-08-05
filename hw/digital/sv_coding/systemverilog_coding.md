# SystemVerilog Coding Guide Summary

## General Principles

* Write clear, readable, and maintainable code.
* Consistency is critical.
* Prefer explicitness over cleverness.
* Avoid unnecessary complexity.
* Write synthesizable and simulation-friendly code.

## Key Notes

* Place the `import` statement on a separate line immediately after the module name.
* Use a dedicated `parameter` block for clarity and maintainability.
* Apply consistent input/output naming suffixes: `_i` for inputs, `_o` for outputs, `_q/_d` for sequential/internal signals.
* The `import` statement should follow the module name if importing types or packages.
* Parameters should be defined clearly and aligned.
* Port declarations should be vertically aligned and grouped logically (e.g., clocks/resets, control signals, data signals).
* Use `logic` consistently for all signals.
* Inline comments should explain each port's purpose concisely.

## Package Declaration Example

Packages are used to encapsulate shared types, parameters, and constants across modules.

```systemverilog
`ifndef COMMON_TYPES_PKG_SVH_
`define COMMON_TYPES_PKG_SVH_

package common_types_pkg;

  // Import types from other packages if needed
  import addr_pkg::addr_t;

  // ---------------------
  // COMMON TYPE DEFINITIONS
  // ---------------------

  typedef enum logic [1:0] {
    IDLE,
    BUSY,
    DONE,
    ERROR
  } state_e;

  typedef struct packed {
    logic valid;
    logic [31:0] data;
  } data_packet_t;

endpackage : common_types_pkg

`endif  // COMMON_TYPES_PKG_SVH_
```
### Guidelines
- Use include guards: ifndef, define, and endif with a _PKG_SVH_ suffix.
- Prefix the file and package name consistently (e.g., common\_types\_pkg.sv → common\_types\_pkg).
- Group type definitions under clear section headers (e.g., // COMMON TYPE DEFINITIONS).
- Use typedef with packed structs and enums where appropriate.
- End the package with endpackage : package\_name for clarity.


## How to Write `import` and `parameter` Declarations

```systemverilog
module top_core 
  import top_reg_pkg::*;            // Import package directly after module name
#(
  parameter int unsigned Depth = 3  // Parameter block with explicit type and default
)(
  // Port list follows...
);
```
### Guidelines
- Import: Place the import statement on a new line, indented one level, directly after the module keyword.
- Parameters: Define parameters in a clear #(...) block, with explicit types and default values.
- Style: Align and format for clarity. Avoid inline import or in-line parameter definitions in the port list.

## Input and Output Naming Suffixes

To maintain clarity and consistency across modules, lowRISC uses specific suffixes for signal directions and types:

| Suffix   | Meaning                      | Example         |
|----------|------------------------------|-----------------|
| `_i`     | Input signal                 | `clk_i`         |
| `_o`     | Output signal                | `data_o`        |
| `_q`     | Registered (sequential)      | `state_q`       |
| `_d`     | Next state / data before FF  | `state_d`       |
| `_n`     | Active-low signal (rarely)   | `rst_ni`        |

### Guidelines
- Use `_i` and `_o` consistently for all module interface ports.
- Use `_q` for outputs of flip-flops and `_d` for their next-state assignments.
- Avoid ambiguity: the suffix should clearly indicate signal role.
- Only use `_n` for active-low signals, and indicate polarity in the signal name (e.g., `rst_ni`).

```systemverilog
input  logic        clk_i,
input  logic        rst_ni,
output logic        done_o,
logic               done_d, done_q;
```
This convention improves readability and helps tools and humans quickly understand signal flow.

## `always_ff` Usage

Use `always_ff` for all sequential logic. Even single-line bodies must be wrapped in `begin ... end` to prevent issues during future edits or code expansion.

```systemverilog
always_ff @(posedge clk_i) begin
  q <= d;
end
```
### Guidelines
- Always use always\_ff instead of the traditional always @(posedge clk) for flip-flop-based logic.
- Wrap the block with begin ... end even if there's only one line.
- Use non-blocking assignments (<=) inside always\_ff.

## `if-else` Usage

Always place `end else begin` on the same line to improve readability and avoid vertical sprawl in simple conditionals.

```systemverilog
if (condition) begin
  foo = bar;
end else begin
  foo = bum;
end
```
### Guidelines
- Always use begin ... end blocks, even for single-line branches.
- Place end else begin on a single line.
- Avoid deeply nested if-else statements by factoring out logic where possible.

## `case` Usage

Use `unique case` for one-hot or exclusive cases when appropriate. Each `case` item must be wrapped in `begin ... end`, even for single-line bodies. This avoids bugs when adding more logic later.

```systemverilog
unique case (state_q)
  StIdle: begin
    state_d = StA;
  end
  StA: begin
    state_d = StB;
  end
  StB: begin
    state_d = StIdle;
    foo = bar;
  end
  default: begin
    state_d = StIdle;
  end
endcase
```
### Guidelines
- Always use begin ... end for each case branch.
- Prefer unique or priority over plain case for clearer intent and better linting.
- Always include a default case.
- Avoid overlapping or duplicate case values.

## 🔁 `for` Loop Usage in SystemVerilog

SystemVerilog supports two types of `for` loops: **procedural** and **generate**. It’s important to choose the correct type based on whether the loop runs at **simulation time** or **elaboration time**.

---

### 🔧 Procedural `for` Loop

Use inside `always_*`, `initial`, or `final` blocks. These loops run during simulation and are used to read or modify existing signals.

```systemverilog
logic [3:0] src, dst;

always_comb begin
  for (int i = 0; i < 4; i++) begin
    dst[i] = ~src[i];
  end
end
```
### 🏗️ Generate for Loop
Use inside generate blocks. These loops are evaluated at elaboration time and used to replicate hardware structures (e.g., logic, instances, continuous assignments).
```systemverilog
logic [3:0] en;

generate
  for (genvar i = 0; i < 4; i++) begin : gen_buf
    assign en[i] = ctrl_i & mask_i[i];
  end
endgenerate
```

### Guidelines
- Use int or int unsigned for procedural loop counters.
- Use genvar for hardware instantiation inside generate blocks.
- Wrap every loop body in begin ... end for clarity and maintainability.
- Always name generate blocks using : label for easier tracing and debugging in waveforms or hierarchy views.

## Arrays of Structs

Use `typedef struct packed` to define structured data types, and declare arrays of those types for common hardware constructs like caches, register files, or control buffers.

### Example: Register File Buffer or Cache Entry

```systemverilog
typedef struct packed {
  logic        valid;
  logic [7:0]  tag;
  logic [31:0] data;
} entry_t;

// Declare current and next-state arrays
entry_t entry_q[16];
entry_t entry_d[16];
```
### Usage Example in a Sequential Block
```systemverilog
always_ff @(posedge clk_i) begin
  for (int i = 0; i < 16; i++) begin
    if (wen_i[i]) begin
      entry_q[i] <= entry_d[i];
    end
  end
end
```

### Guidelines
- Group fields logically within the struct for readability and alignment.
- Arrays of structs are ideal for implementing lookup tables, tag arrays, buffer banks, and more.
- Avoid deeply nested or overly complex struct definitions—prefer composability and clarity.

### Conditional Instantiation Based on Parameters

Use `if (...) begin ... end else begin ... end` blocks at the generate level to select between different hardware implementations based on a parameter.

#### Example: Conditional Mux Logic (registered or combinational)

```systemverilog
generate
  if (USE_REGISTERED_MUX) begin : gen_reg_mux
    always_ff @(posedge clk_i) begin
      if (en_i) begin
        data_q <= (sel_i) ? in1_i : in0_i;
      end
    end
    assign out_o = data_q;
  end else begin : gen_comb_mux
    assign out_o = (sel_i) ? in1_i : in0_i;
  end
endgenerate
```

### Guidelines
- Use generate if for switching between logic alternatives at synthesis time.
- Always name each conditional block with a meaningful label (: gen\_reg\_mux, : gen\_comb\_mux).
- Use the same interface (out\_o) to keep the surrounding logic agnostic to the implementation.
- Keep both branches functionally equivalent and test both paths in simulation.
- This pattern is useful when selecting between performance, area, or power tradeoffs through configuration parameters.
