// ----------------------------------------------
// Example code for
//
// System-on-Chip Design with Arm(R) Cortex(R)-M 
// Processors
//
// Reference Book
//          by Joseph Yiu, 2019 (first edition)
// 
// Arm Education Media (university@arm.com)
// https://www.arm.com/resources/education
// ISBN: 978-1-911531-19-7
// ----------------------------------------------
// Purpose: Retarget functions for GNU Tools for 
//          ARM Embedded Processors 
//
// Disclaimer
// This example design is created for educational
// purpose only and are not validated to the same 
// quality level as Arm IP products. 
// Arm Education Media and author do not make any 
// warranties of these designs.
// ----------------------------------------------

#include <stdio.h>
#include <sys/stat.h>

extern int stdout_putchar(int ch);

__attribute__ ((used))  int _write (int fd, char *ptr, int len)
{
  size_t i;
  for (i=0; i<len;i++) {
    stdout_putchar((int) ptr[i]); // call character output function
    }
  return len;
}
