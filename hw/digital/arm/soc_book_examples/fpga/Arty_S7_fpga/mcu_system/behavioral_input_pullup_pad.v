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
// Purpose: Behavioral model for simple input pad
//          with pullup
// ----------------------------------------------
module behavioral_input_pullup_pad (
  input   wire     PIN,
  output  wire     POUT
  );

  assign   POUT = PIN;
  
  pullup(PIN);
  
endmodule
