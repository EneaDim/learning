/*
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
// Purpose: Example linker script for gcc
// ----------------------------------------------
*/

/* Linker script to configure memory regions.
 * Need modifying for a specific board.
 *   FLASH.ORIGIN: starting address of flash
 *   FLASH.LENGTH: length of flash
 *   RAM.ORIGIN: starting address of RAM bank 0
 *   RAM.LENGTH: length of RAM bank 0
 */
/*GROUP(libgcc.a libc.a libm.a librdimon.a)*/

/* Library configurations */
GROUP(libgcc.a libc.a libm.a libnosys.a)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x0,        LENGTH = 0x8000  /* 32KB */
  RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 0x4000  /* 16KB */
}

INCLUDE "sections.ld"
