# Roadmap to Expertise: Digital Design & Embedded Systems

## Objective

To become a true expert in:

* Embedded Systems Basics
* C Coding
* SystemVerilog Coding
* IP Development
* SoC Integration
* Processor Architecture
* Compilers
* Real-Time Operating Systems
* Linux OS

---

## Phase 0: Embedded Systems Basics (Hardware & Software Foundation)

* **Hardware Concepts**: Microcontrollers vs Microprocessors, memory types, buses, I/O interfaces.
* **Software Concepts**: Firmware, bootloaders, interrupt handling, polling vs interrupts.
* **System View**: Interaction of hardware and software in embedded environments.

---

## Phase 1: C Coding (Foundation of Embedded and System Software)

* **Basics of C**: Variables, control flow, functions, pointers, memory management.
* **Advanced C**: Structs, unions, bit manipulation, inline assembly, volatile keyword.
* **Embedded C Concepts**: Register access, ISR, linker scripts, startup code.

---

## Phase 2: SystemVerilog Coding (Foundation of Hardware Design & Verification)

* **Verilog Basics**: Syntax, modules, combinational/sequential logic.
* **SystemVerilog Extensions**: Interfaces, assertions, OOP in verification.
* **Design and Verification**: FSMs, testbenches, UVM basics.

---

## Phase 3: IP Development (Reusable Hardware Modules)

* **Design Practices**: Parameterization, clock-domain crossing, low power design.
* **Verification**: Functional coverage, regression testing.
* **Packaging**: IP-XACT, interface standards (AXI, AHB, APB).

---

## Phase 4: SoC Integration (System-Level Design)

* **Subsystem Design**: Processor + memory + IPs.
* **Interconnects**: AMBA protocols (AXI4, AHB), NoCs.
* **Integration Tools**: Design tools (Synopsys, Cadence), simulation setups.

---

## Phase 5: Processor Architecture (Bridge Between HW & SW)

* **Fundamentals**: Instruction set architecture (ISA), pipeline, memory hierarchy.
* **Types of Processors**: RISC vs CISC, ARM, RISC-V.
* **Custom Extensions**: Coprocessors, instruction customizations.

---

## Phase 6: Compilers (SW Side of Hardware-Software Interface)

* **Compiler Basics**: Lexing, parsing, code generation.
* **Toolchains**: GCC, LLVM, building cross-compilers.
* **Optimizations**: Inline, loop unrolling, register allocation.

---

## Phase 7: Real-Time Operating Systems (RTOS)

* **Concepts**: Tasks, preemption, priorities, semaphores, queues.
* **Popular RTOSes**: FreeRTOS, Zephyr.
* **Bare-metal vs RTOS**: Comparison and use cases.

---

## Phase 8: Linux OS (Advanced SW Platform)

* **Linux Basics**: Kernel, user space, device tree, sysfs, procfs.
* **Kernel Programming**: Modules, drivers, scheduling.
* **Embedded Linux**: Yocto, Buildroot, init systems.

---

## Summary Chart

| Phase | Topic                   | Focus Areas                               |
| ----- | ----------------------- | ----------------------------------------- |
| 0     | Embedded Systems Basics | Hardware/software foundation, system view |
| 1     | C Coding                | Foundations for all system-level software |
| 2     | SystemVerilog Coding    | Core for digital hardware design & IP     |
| 3     | IP Development          | Practical, reusable hardware components   |
| 4     | SoC Integration         | Full-chip level integration & validation  |
| 5     | Processor Architecture  | Connects HW and SW worlds                 |
| 6     | Compilers               | Understand SW-to-HW translation           |
| 7     | RTOS                    | Lightweight embedded system software      |
| 8     | Linux OS                | High-end embedded platform and drivers    |

# Phase 0: Embedded Systems Basics (Hardware & Software Foundation)

## 1. Overview

Embedded systems are specialized computing systems designed to perform dedicated functions within a larger system. They integrate both hardware and software, often with constraints like real-time operation, power efficiency, and limited resources.

---

## 2. Hardware Concepts

### 2.1 Microcontrollers vs Microprocessors

* **Microcontroller (MCU):** Integrated CPU, memory, and peripherals (e.g., STM32, ATmega328).
* **Microprocessor (MPU):** More powerful CPU without integrated peripherals (e.g., ARM Cortex-A, Intel i5).

**Example:**

* ATmega328 on Arduino Uno for sensor control (MCU).
* Raspberry Pi 4 for media streaming or Linux (MPU).

### 2.2 Memory Types

* **ROM**: Stores firmware.
* **RAM**: Volatile runtime memory.
* **Flash**: Non-volatile program storage.
* **EEPROM**: Electrically erasable memory for small persistent data (e.g., configuration).

### 2.3 Buses and Interfaces

* **Data/Address Buses**: Connect CPU, memory, peripherals.
* **Peripheral Interfaces**:

  * UART (Serial Communication)
  * SPI (High-speed peripheral link)
  * I2C (Multi-slave communication)
  * GPIO (General-purpose input/output)
  * ADC/DAC (Analog interfaces)
  * PWM (Motor control, dimming LEDs)
  * CAN (Automotive and industrial control)
  * USB (Peripheral connection)
  * Ethernet (Networking)

**Example:** SPI to interface with external EEPROM:

```c
// Pseudocode
spi_init();
spi_send(CMD_READ);
spi_send(address);
uint8_t data = spi_receive();
```

### 2.4 Timers and Interrupts

* **Timers**: Generate periodic events, time-stamping, delays.
* **Interrupts**: Allow hardware to signal the CPU asynchronously.
* **Nested Vectored Interrupt Controller (NVIC)**: Prioritizes and manages interrupts.

---

## 3. Software Concepts

### 3.1 Firmware

* Low-level software controlling the device hardware.
* Usually written in C or assembly.

### 3.2 Bootloaders

* Small code that loads the main application firmware after power-on.
* Often supports firmware update over USB/UART.

### 3.3 Polling vs Interrupts

* **Polling**: CPU repeatedly checks a flag.
* **Interrupts**: CPU responds to hardware events.

### 3.4 Memory-mapped I/O

* Peripheral registers mapped to specific memory addresses.

**Example:**

```c
#define LED_PORT (*(volatile uint32_t*)0x40021014)
#define LED_PIN 5

void turn_on_led() {
    LED_PORT |= (1 << LED_PIN);
}

void turn_off_led() {
    LED_PORT &= ~(1 << LED_PIN);
}
```

---

## 4. System View: HW/SW Co-Design

* Embedded systems require tight coupling of software to specific hardware features.
* Firmware must respect timing, pin configuration, peripheral control.

**Example:** Use a timer interrupt to toggle an LED every 1 second.

```c
volatile int toggle = 0;

void TIM2_IRQHandler(void) {
    toggle ^= 1;
    if (toggle)
        turn_on_led();
    else
        turn_off_led();
    clear_timer_interrupt();
}
```

---

## 5. Exercises with Solutions

### Exercise 1

**Question:** What is the difference between a microcontroller and a microprocessor?

**Solution:**

* Microcontroller: Includes CPU, memory, peripherals on a single chip.
* Microprocessor: CPU only, external memory and peripherals required.

### Exercise 2

**Question:** Write C code to toggle a GPIO pin using a memory-mapped register.

**Solution:**

```c
#define GPIO_PORT (*(volatile uint32_t*)0x50000000)
#define PIN_MASK (1 << 3)

void toggle_pin() {
    GPIO_PORT ^= PIN_MASK;
}
```

### Exercise 3

**Question:** What are the advantages of using interrupts instead of polling?

**Solution:**

* Power efficiency, responsiveness, frees CPU to perform other tasks.

---

## 6. Challenge Problems

### Problem 1: ISR Design

Design an interrupt service routine in pseudocode that turns off an LED when a button connected to an interrupt pin is pressed.

**Hint:** Use `volatile` for shared variables, and configure the interrupt controller properly.

### Problem 2: Interface Mapping

Given a temperature sensor connected over I2C at address `0x48`, describe the software steps to read temperature data every 1 second using a timer interrupt.

### Problem 3: PWM Application

Generate a PWM signal to control the brightness of an LED. Increase brightness gradually every 100 ms.

**Hint:** Use timer with PWM mode and change the duty cycle.

---

## 7. Tools and Platforms

* **Development Boards:** Arduino, STM32 Nucleo, TI LaunchPad, ESP32.
* **Simulators:** Proteus, QEMU, Tinkercad Circuits.
* **IDEs:** STM32CubeIDE, MPLAB X, Keil MDK, PlatformIO.
* **Debugging Tools:** JTAG/SWD, logic analyzers, serial monitors, ST-Link, OpenOCD.

---

## 8. Open Source Tools and Development Flow

### 8.1 Toolchains

* **GCC (GNU Compiler Collection):** Standard compiler for embedded C/C++.
* **GDB:** GNU debugger for firmware.
* **Make/CMake:** Build system tools.

### 8.2 Development Environments

* **VS Code + PlatformIO:** Popular open source IDE with library support.
* **Eclipse with CDT:** Highly customizable for C/C++ projects.
* **Geany, Code::Blocks:** Lightweight alternatives.

### 8.3 Debugging and Programming

* **OpenOCD (Open On-Chip Debugger):** Interface to JTAG/SWD.
* **stlink, pyOCD:** Vendor-specific and open source programming/debugging tools.

### 8.4 CI/CD and Testing

* **Unity + Ceedling:** Unit testing framework for embedded C.
* **GitHub Actions:** Automate builds and test runs.
* **Simulators:** QEMU for virtual MCU environments.

### 8.5 Development Flow

1. **Write code** using VS Code + PlatformIO or Makefile.
2. **Compile** with GCC.
3. **Upload** using stlink/pyOCD/OpenOCD.
4. **Debug** with GDB.
5. **Test** using Unity.
6. **Version control** with Git.
7. **CI/CD** using GitHub Actions or GitLab CI.

This open-source ecosystem ensures reproducibility, transparency, and community support throughout embedded system development.

---

This detailed foundation equips you to write robust embedded C code and interact directly with peripherals, preparing you for real-world hardware-software integration.

# Phase 1: C Coding for Embedded Systems (Extended Overview)

## 1. Overview

C is the de facto programming language for embedded systems. It provides low-level access to memory, efficient performance, and is supported by virtually all microcontroller toolchains. This section offers a deep dive into C concepts essential for writing firmware that interacts with hardware.

---

## 2. Fundamental Concepts

### 2.1 Data Types and Operators

#### Standard Integer Types:

* `char` (1 byte): Can be `signed` or `unsigned`.
* `int` (typically 4 bytes): Platform-dependent.
* `short` (typically 2 bytes)
* `long` (typically 4 bytes or 8 bytes on 64-bit platforms)
* `long long` (at least 8 bytes)

#### Fixed-Width Types (from `stdint.h`):

* `int8_t`, `uint8_t`
* `int16_t`, `uint16_t`
* `int32_t`, `uint32_t`
* `int64_t`, `uint64_t`

#### Floating-Point Types:

* `float`: Typically 4 bytes (single precision)
* `double`: Typically 8 bytes (double precision)
* `long double`: Compiler-dependent (up to 16 bytes)

#### Qualifiers:

* `const`: Specifies that a variable's value cannot be modified after initialization. Commonly used to define read-only data and for function parameters to indicate the function will not change the passed data.

  ```c
  const uint8_t led_pin = 5; // Cannot modify led_pin later
  void print_msg(const char* msg); // msg will not be modified
  ```

* `volatile`: Informs the compiler that a variable can change unexpectedly, such as via hardware or interrupt routines. Prevents the compiler from optimizing out necessary reads/writes.

  ```c
  volatile uint8_t flag;
  while (!flag); // Wait until ISR sets the flag
  ```

* `static`: Has two main uses:

  1. Inside functions, retains value between calls (persistent local variable).
  2. At file scope, restricts visibility to that file (internal linkage).

  ```c
  static int counter = 0; // retains value across function calls
  static void helper_function() { ... } // not visible outside the file
  ```

* `extern`: Declares a variable or function that is defined in another file. Used for cross-module references.

  ```c
  // file1.c
  int global_value = 10;

  // file2.c
  extern int global_value; // Reference to external definition
  ```

* `register`: Suggests to the compiler that a variable be stored in a CPU register for faster access. Modern compilers often ignore this hint.

  ```c
  register int fast_var = 0; // Suggest storage in register
  ```

#### Type Modifiers:

* `signed` / `unsigned`: Apply to `char`, `int`, etc.

#### Operators:

* **Arithmetic**: `+`, `-`, `*`, `/`, `%`
* **Assignment**: `=`, `+=`, `-=`, `*=`, `/=`, `%=`
* **Comparison**: `==`, `!=`, `<`, `>`, `<=`, `>=`
* **Logical**: `&&`, `||`, `!`
* **Bitwise**: `&`, `|`, `^`, `~`, `<<`, `>>`
* **Increment/Decrement**: `++`, `--`
* **Conditional (Ternary)**: `condition ? value1 : value2`

**Example:**

```c
#include <stdint.h>

int main(void) {
    uint32_t flags = 0x05;        // Binary: 0000 0101
    flags |= (1 << 3);            // Set bit 3 => 0000 1101 (0x0D)
    flags &= ~(1 << 0);           // Clear bit 0 => 0000 1100 (0x0C)
    return 0;
}
```

### 2.2 Control Structures
- **Branching**: `if`, `else`, `switch`
- **Loops**: `for`, `while`, `do-while`
- **Jump**: `break`, `continue`, `goto`

**Example:**
```c
#include <stdint.h>

void digital_write(uint8_t pin);

int main(void) {
    for (uint8_t i = 0; i < 5; i++) {
        if (i == 2) continue; // Skip pin 2
        digital_write(i);    // Write to all other pins
    }
    return 0;
}
```

### 2.3 Functions and Recursion
- Arguments passed by value or by pointer
- Use `static` to restrict scope
- Recursion in limited cases (stack depth constraints)

**Example:**
```c
uint32_t factorial(uint32_t n) {
    return (n <= 1) ? 1 : n * factorial(n - 1);
}
````

### 2.4 Arrays, Strings, and Pointers

* Arrays are contiguous memory
* Strings are null-terminated arrays of `char`
* Pointer arithmetic must consider type size

**Example:**

```c
char msg[] = "Hello";
char* ptr = msg;
while (*ptr != '\0') {
    send_uart(*ptr++);
}
```

---

## 3. Embedded-Specific C Concepts

### 3.1 Memory-Mapped I/O

```c
#define GPIO_DIR (*(volatile uint32_t*)0x40004000)
#define GPIO_DATA (*(volatile uint32_t*)0x40004004)

void gpio_init(void) {
    GPIO_DIR |= (1 << 2);  // Set pin 2 as output
}

void gpio_write(uint8_t value) {
    if (value)
        GPIO_DATA |= (1 << 2);
    else
        GPIO_DATA &= ~(1 << 2);
}
```

### 3.2 Peripheral Access

* Enable/disable clocks, configure registers
* Use header files with base addresses and bit definitions

### 3.3 Bitfields

```c
typedef struct {
    uint8_t mode : 3;
    uint8_t enable : 1;
    uint8_t value : 4;
} control_reg_t;

control_reg_t ctrl = { .mode = 0b101, .enable = 1, .value = 0xF };
```

### 3.4 Inline Assembly

Used for critical timing or special instructions.

```c
__asm volatile ("NOP");
```

### 3.5 Startup Code and Linker Scripts

* Vector table definition
* `main()` is not the entry point — startup assembly sets up the stack, initializes variables
* Linker script defines memory layout

---

## 4. Code Optimization and Safety

### 4.1 Const Correctness

```c
void print_string(const char* str);
```

* Prevents accidental modification

### 4.2 Efficient Code Patterns

* Use bit masking instead of expensive math
* Prefer `switch` over nested `if`

### 4.3 Stack vs Heap

* Embedded systems usually avoid dynamic allocation (heap)
* Use static/global or stack variables

---

## 5. Exercises with Solutions

### Exercise 1

**Question:** Create a function that returns the number of set bits in a 32-bit integer.

**Solution:**

```c
uint8_t popcount(uint32_t val) {
    uint8_t count = 0;
    while (val) {
        count += val & 1;
        val >>= 1;
    }
    return count;
}
```

### Exercise 2

**Question:** Use a pointer to swap two variables.

**Solution:**

```c
void swap(uint8_t* a, uint8_t* b) {
    uint8_t temp = *a;
    *a = *b;
    *b = temp;
}
```

---

## 6. Challenge Problems

### Problem 1: LED State Machine

Design a function that cycles through 4 LED states using a state variable and timer interrupts.

### Problem 2: Minimal UART Driver

Implement `uart_init()`, `uart_send(char c)`, and `uart_receive()` for a bare-metal system.

### Problem 3: Software Debounce

Create a debounce function to filter noisy button presses using a timer.

---

## 7. Open Source Tools and Flow for C Development

### 7.1 Compiler and Toolchain

* **GCC ARM Embedded**: `arm-none-eabi-gcc`, standard toolchain
* **Clang/LLVM**: Alternative with modern diagnostics

### 7.2 Build and Project Management

* **Make**: Minimal, widely supported
* **CMake**: Recommended for modular, cross-platform builds
* **PlatformIO**: Higher-level abstraction for embedded projects

### 7.3 Debugging and Flashing

* **GDB**: Debug firmware via serial or SWD
* **OpenOCD**: Interface to JTAG/SWD hardware
* **stlink/pyOCD**: Vendor-specific tools

### 7.4 Code Quality and Testing

* **Cppcheck**, **Clang-Tidy**: Linting
* **Unity + Ceedling**: Unit testing for embedded code
* **gcov**, **lcov**: Code coverage tools

### 7.5 CI/CD Pipeline (GitHub Actions)

```yaml
name: Build and Test
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Install GCC
      run: sudo apt install gcc-arm-none-eabi
    - name: Build
      run: make
    - name: Run Tests
      run: ceedling test:all
```

---

Mastering embedded C development includes not only knowing the language syntax but understanding how to interact with hardware, structure your projects for maintainability, and integrate testing and automation practices for reliable firmware delivery.

## 8. Tutorial: Write, Compile, and Run a C Program

### Objective

Create a C program that calculates and prints the factorial of a number. Then, compile, disassemble, simulate, and debug it using open-source tools.

### Source Code (factorial.c)

```c
#include <stdio.h>

unsigned int factorial(unsigned int n) {
    return (n <= 1) ? 1 : n * factorial(n - 1);
}

int main() {
    unsigned int num = 5;
    printf("Factorial of %u is %u
", num, factorial(num));
    return 0;
}
```

### Compilation with GCC - Step by Step

To manage these steps efficiently, it's recommended to use a `Makefile`. Each step in the compilation process corresponds to a `make` target for clarity and reuse.

* `make preprocess`  → Runs the preprocessor to expand macros and includes.
* `make compile`     → Compiles the preprocessed source into assembly.
* `make assemble`    → Assembles the assembly code into an object file.
* `make link`        → Links the object file into a final executable.

These steps are all represented in the following Makefile:

### Example Makefile

Save the following content as `Makefile` in the same directory as your source file (e.g., `factorial.c`). Set `PROGRAM = your_program_name` at the top to adapt it to your specific project.

```Makefile
# Makefile for a generic C program
# This Makefile compiles, assembles, links, disassembles,
# generates VMEM, and supports debugging and cleanup.

PROGRAM = factorial
CC = gcc
CFLAGS = -Wall -g
SRC = $(PROGRAM).c
OBJ = $(PROGRAM).o
ASM = $(PROGRAM).s
PRE = $(PROGRAM).i
EXE = $(PROGRAM)
VMEM = $(PROGRAM).vmem

all: $(EXE)

preprocess:
	$(CC) -E $(SRC) -o $(PRE)

compile:
	$(CC) -S $(PRE) -o $(ASM)

assemble:
	$(CC) -c $(ASM) -o $(OBJ)

link:
	$(CC) $(OBJ) -o $(EXE)

vmem:
	objcopy -O verilog $(EXE) $(VMEM)

disasm:
	objdump -d $(EXE) > $(EXE).asm

debug:
	gdb ./$(EXE)

clean:
	rm -f $(EXE) $(OBJ) $(ASM) $(PRE) $(VMEM) *.asm

# Help target to list available commands
help:
	@echo "Available targets:"
	@echo "  make              - Build the executable (default)"
	@echo "  make preprocess   - Run C preprocessor (generates .i)"
	@echo "  make compile      - Compile preprocessed file to assembly (generates .s)"
	@echo "  make assemble     - Assemble .s to object file (generates .o)"
	@echo "  make link         - Link object to create final executable"
	@echo "  make disasm       - Disassemble executable (generates .asm)"
	@echo "  make vmem         - Generate Verilog memory file from executable"
	@echo "  make debug        - Launch GDB debugger"
	@echo "  make clean        - Remove all generated files"
```

### Run Compilation Step-by-Step Using Make

```bash
make preprocess   # Preprocess the source file
make compile      # Compile to assembly
make assemble     # Assemble to object file
make link         # Link to create executable
```

### Run Full Build

```bash
make              # Executes the default target (all)
```

### Generate Disassembly and VMEM

```bash
make disasm
make vmem
```

### Clean All Generated Files

```bash
make clean
```

### Optional: Generate Disassembly

```bash
gcc -g factorial.c -o factorial
objdump -d factorial > factorial.asm
```

### Optional: Generate Verilog Memory File (.vmem)

```bash
objcopy -O verilog factorial factorial.vmem
```

Useful for simulation with HDL testbenches.

### Run the Executable

```bash
./factorial
```

Expected output:

```
Factorial of 5 is 120
```

### Debug with GDB

Compile with debug symbols:

```bash
gcc -g factorial.c -o factorial
```

Start debugging:

```bash
gdb ./factorial
```

Basic GDB commands:

```gdb
(gdb) break main
(gdb) run
(gdb) step
(gdb) print num
(gdb) continue
(gdb) quit
```

### Cross-Compiling for ARM Cortex-M (Optional)

```bash
arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -nostdlib -T linker.ld -o factorial.elf factorial.c
```

Generate binary and Verilog memory file:

```bash
arm-none-eabi-objcopy -O binary factorial.elf factorial.bin
arm-none-eabi-objcopy -O verilog factorial.elf factorial.vmem
```

### Flash to Device (e.g., STM32 with stlink)

```bash
st-flash write factorial.bin 0x8000000
```

---

This expanded tutorial walks you through each compilation step with GCC, introduces disassembly and Verilog memory file generation, and shows how to debug with GDB — essential practices for low-level C and embedded system development.


# SystemVerilog Coding for Digital Design and Verification

## Overview

SystemVerilog is an industry-standard HDL for both RTL design and verification. It builds on Verilog with stronger typing, interfaces, object-oriented constructs, and advanced verification features.

This document follows the **lowRISC SystemVerilog Coding Guidelines**, emphasizing:

## 1. General Principles

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

---

## 2. Complex IP Design: Ready/Valid Transaction FIFO

### 2.1 Pseudo-code Specification

```
Design a ready/valid-based FIFO interface:
- Accepts input data when valid_i is high and ready_o is asserted
- Sends data to downstream when ready_i is high and valid_o is asserted
- Controlled by FSM (IDLE, WRITE, READ)
```

### 2.2 Package for Type Definitions (`fifo_pkg.sv`)

```systemverilog
package fifo_pkg;
  typedef logic [7:0] data_t;
  typedef enum logic [1:0] {
    IDLE  = 2'b00,
    WRITE = 2'b01,
    READ  = 2'b10
  } fsm_state_t;
endpackage
```

### 2.3 Interface (`fifo_if.sv`)

```systemverilog
interface fifo_if(input logic clk);
  import fifo_pkg::*;

  logic rst;
  logic valid_i;
  logic ready_o;
  data_t data_i;

  logic valid_o;
  logic ready_i;
  data_t data_o;

  modport dut (input clk, rst, valid_i, data_i, ready_i,
               output ready_o, valid_o, data_o);

  modport tb (output valid_i, data_i, ready_i,
              input clk, rst, ready_o, valid_o, data_o);
endinterface
```

### 2.4 RTL Modules

#### 2.4.1 Datapath (`ready_valid_fifo.sv`)

```systemverilog
module ready_valid_fifo 
  import fifo_pkg::*;
#(
  parameter int DATA_WIDTH = 8
)(
    input  logic         clk_i,
    input  logic         rst_i,
    input  logic         valid_i,
    input  fifo_pkg::data_t data_i,
    input  fifo_pkg::fsm_state_t state_i,
    output logic         ready_o,
    output logic         valid_o,
    output fifo_pkg::data_t data_o,
    input  logic         ready_i
);

    data_t buffer;

    always_ff @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            buffer   <= '0;
            ready_o  <= 0;
            valid_o  <= 0;
            data_o   <= '0;
        end else begin
            case (state_i)
                IDLE: begin
                    ready_o <= 1;
                    valid_o <= 0;
                end
                WRITE: begin
                    if (valid_i) buffer <= data_i;
                    ready_o <= 0;
                    valid_o <= 1;
                end
                READ: begin
                    data_o  <= buffer;
                    valid_o <= 1;
                    ready_o <= 0;
                end
            endcase
        end
    end
endmodule
```

#### 2.4.2 FSM Controller (`fifo_fsm.sv`)

```systemverilog
module fifo_fsm 
  import fifo_pkg::*;
#(
  parameter int STATE_BITS = 2
)(
    input  logic clk_i,
    input  logic rst_i,
    input  logic valid_i,
    input  logic ready_i,
    output fifo_pkg::fsm_state_t state_o
);

    fsm_state_t state, next_state;

    assign state_o = state;

    always_ff @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE:  if (valid_i) next_state = WRITE;
            WRITE: if (ready_i) next_state = READ;
            READ:  if (!valid_i) next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
endmodule
```

---

## 3. Arithmetic Module with `function automatic`

### 3.1 Module (`arithmetic_unit.sv`)

```systemverilog
module arithmetic_unit #(
  parameter int OP_WIDTH = 8,
  parameter int RES_WIDTH = 16
)(
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic [7:0]  op_a_i,
    input  logic [7:0]  op_b_i,
    input  logic [1:0]  opcode_i,
    output logic [15:0] result_o
);

    function automatic logic [15:0] compute_result (
        input logic [7:0] a,
        input logic [7:0] b,
        input logic [1:0] op
    );
        case (op)
            2'd0: compute_result = a + b;
            2'd1: compute_result = a - b;
            2'd2: compute_result = a * b;
            default: compute_result = 16'hDEAD;
        endcase
    endfunction

    always_ff @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            result_o <= '0;
        end else begin
            result_o <= compute_result(op_a_i, op_b_i, opcode_i);
        end
    end
endmodule
```

### 3.2 Usage and Benefits

* Reusable, clean combinational helpers
* Isolates logic without shared state
* Recommended for synthesizable functions

Example:

```systemverilog
function automatic logic [7:0] encode_priority(input logic [7:0] req);
  for (int i = 7; i >= 0; i--) begin
    if (req[i]) return i;
  end
  return 0;
endfunction
```

---

## 4. Verification Strategies and Methodologies

### 4.1 Testbench Methodology

A modular testbench typically includes:

* **Testbench Top** — Instantiates DUT and interface.
* **Driver/Monitor/Checker** — Drives inputs, monitors outputs, and checks results.
* **Stimulus Generation** — Either directed or constrained-random.

Use SystemVerilog constructs like:

* `interface` to group I/O.
* `program` blocks or clocking blocks to drive signals.
* `initial` or `always` blocks for stimulus.

### 4.2 Assertion-Based Verification (ABV)

Assertions catch bugs early and document design intent. SystemVerilog supports:

* **Immediate assertions**: evaluated at the time of execution.
* **Concurrent assertions**: monitor sequences over time using temporal expressions.

Example:

```systemverilog
property p_ready_implies_valid;
  @(posedge clk_i) disable iff (rst_i)
  ready_o |-> valid_i;
endproperty

assert property (p_ready_implies_valid);
```

Use assertions in RTL, testbench, or formal wrappers.

### 4.3 Formal Methods

Formal tools exhaustively check behavior over all possible inputs.

Steps:

1. **Define properties** using `assert` and `assume`.
2. **Isolate DUT** with minimal and constrained inputs.
3. **Use tools** like SymbiYosys, JasperGold, or VC Formal.

Tips:

* Start with safety properties.
* Use `assume` to limit input space.
* Add cover properties to guide proofs.

---

## Final Summary

This guide covered:

* Translating design from pseudocode to RTL
* Modular design via packages, interfaces
* FSM-based control logic
* `function automatic` usage
* RTL optimization techniques for area and performance
* Verification strategies: testbenches, assertions, and formal methods

By adhering to lowRISC guidelines, you've built a foundation suitable for industrial-quality SystemVerilog IPs.

