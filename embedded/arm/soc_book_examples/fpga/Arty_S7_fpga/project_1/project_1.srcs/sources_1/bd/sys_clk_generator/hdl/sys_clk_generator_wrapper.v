//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Sat Jul  6 12:17:18 2019
//Host        : Boston running 64-bit major release  (build 9200)
//Command     : generate_target sys_clk_generator_wrapper.bd
//Design      : sys_clk_generator_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module sys_clk_generator_wrapper
   (clk_in1_0,
    clk_out1_0,
    locked_0,
    resetn_0);
  input clk_in1_0;
  output clk_out1_0;
  output locked_0;
  input resetn_0;

  wire clk_in1_0;
  wire clk_out1_0;
  wire locked_0;
  wire resetn_0;

  sys_clk_generator sys_clk_generator_i
       (.clk_in1_0(clk_in1_0),
        .clk_out1_0(clk_out1_0),
        .locked_0(locked_0),
        .resetn_0(resetn_0));
endmodule
