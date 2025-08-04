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
// Purpose: System configuration options
//-------------------------------------
// Include a system control register block
// (currently the only feature implemented is
// 1 control bit to enable system to be automatically
// reset when the processor enter LOCKUP state).

// `define INCLUDE_SYSCTRL_REGBLK

//-------------------------------------
// Memory for FPGA
`define FPGA_CONFIG

// Initialization
`define CM_SRAM_INIT

// System Control Register block
// Needed for FPGA
`define INCLUDE_SYSCTRL_REGBLK
