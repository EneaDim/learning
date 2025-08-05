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
// Purpose: Hello World example program
// ----------------------------------------------


#include "cm3_mcu.h"
#include <stdio.h>

extern void uart_config(void);
extern void uart_putc(char c);


int main(void)
{
  uart_config();
  printf ("Hello world\n");
  uart_putc(4);// end simulation
  while(1);
}   


