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
// Purpose: UART utility functions
// ----------------------------------------------
#include "cm3_mcu.h"

void uart_config(void);
void uart_putc(char c);
char uart_getc(void);
int  stdout_putchar (int ch);

void uart_config(void)
{
  CM3MCU_UART0->BAUDDIV = 4167; // 40MHz / 9600
  CM3MCU_UART0->CTRL    = CM3MCU_UART_CTRL_TXEN_Msk|
                          CM3MCU_UART_CTRL_RXEN_Msk; // Enable TX & RX  
  return;
}

void uart_putc(char c)
{
  while (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_TXFULL_Msk); // wait if TX FIFO full
  CM3MCU_UART0->TXD = (uint32_t) c;
  return;
}

char uart_getc(void)
{
  while ((CM3MCU_UART0->STATE & CM3MCU_UART_STATE_RXFULL_Msk)==0); // wait if RX FIFO empty
  return ((char) CM3MCU_UART0->RXD);
}

// Function used by retarget_io.c
int stdout_putchar (int ch)
{
  if (ch==10) stdout_putchar(13);	
  uart_putc(ch);
  return (ch);
}
