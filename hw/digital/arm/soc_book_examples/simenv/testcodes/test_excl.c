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
// Purpose: Simple test for exclusive accesses
// ----------------------------------------------
#include "cm3_mcu.h"
#include <stdio.h>

extern void uart_config(void);
extern void uart_putc(char c);

int main(void)
{
  int  tmp;
  uint32_t volatile flag;
  uint32_t ex_status;
  
  

  uart_config();
  printf ("Exclusive access test\n");
  printf ("- address : 0x%x\n", ((uint32_t) &flag));
  __SEV();
  flag = 0;
  tmp = __LDREXW( &flag);
  tmp ++;
  ex_status = __STREXW(tmp, &flag);
  printf ("Expect STREX sucess (status=0) and flag update to 1\n");
  printf ("Status =  %d\n",ex_status);
  printf ("Flag =  %d\n",flag);
  if (flag!=1) {
    printf ("ERROR: Exclusive store failed #1\n");
    uart_putc(4);// end simulation
    }
  if (ex_status!=0) {
    printf ("ERROR: Exclusive store failed #1\n");
    uart_putc(4);// end simulation
    }
  // Now doing exclusive store without being in excl state
  ex_status = __STREXW(2, &flag);
  printf ("Expect STREX fail (status=1) and flag Not update to 2\n");
  printf ("Status =  %d\n",ex_status);
  printf ("Flag =  %d\n",flag);
  if (flag!=1) {
    printf ("ERROR: Exclusive store failed #2\n");
    uart_putc(4);// end simulation
    }
  if (ex_status!=1) {
    printf ("ERROR: Exclusive store failed #2\n");
    uart_putc(4);// end simulation
    }
  

  printf ("Test done\n");
  uart_putc(4);// end simulation
  
  while(1);
}   
