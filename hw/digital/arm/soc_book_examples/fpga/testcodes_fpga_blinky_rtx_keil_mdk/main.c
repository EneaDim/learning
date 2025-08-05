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
// Purpose: LED blinky example program
// ----------------------------------------------

#include "cm3_mcu.h"
#include "LED.h"
#include "cm3_mcu.h"
#include "LED.h"
#include "cmsis_os2.h"

void thread_led (void *arg);

int main(void)
{	
  LED_Initialize();
  osKernelInitialize(); // Initialize CMSIS-RTOS
  osThreadNew(thread_led, NULL, NULL); // create thead for thread_led
  osKernelStart();                      // Start thread execution
  for (;;) {}	
}   

void thread_led (void *argument) {
  while(1){
    LED_On();
    osDelay(500);
    LED_Off();
    osDelay(500);
  }; // end while
}
