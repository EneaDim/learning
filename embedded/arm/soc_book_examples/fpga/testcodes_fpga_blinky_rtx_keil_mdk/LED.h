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
// Purpose: Header file for LED utility functions
// ----------------------------------------------

#include "stdint.h"  // Required for the return type of LED_initialize
int32_t LED_Initialize (void); // function prototype for LED_Initialize
void    LED_On         (void); // function prototype for LED_On
void    LED_Off        (void); // function prototype for LED_Off

