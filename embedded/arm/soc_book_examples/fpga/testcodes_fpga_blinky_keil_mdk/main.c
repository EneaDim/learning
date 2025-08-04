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

volatile  uint32_t SysTickCntr=0;
void      TickDelay(int32_t);

int main(void)
{	
  LED_Initialize();
  SysTick_Config(SystemCoreClock/1000); // 1KHz Ticks
  while(1){
    LED_On();
    TickDelay(500);
    LED_Off();
    TickDelay(500);
  }; // end while
}   

void TickDelay(int32_t tnum)
{
  uint32_t LastTick=0, NewTick=0, DivideCntr=0;
  LastTick = SysTickCntr;
  NewTick = LastTick;
  DivideCntr = tnum;
  while (DivideCntr>0) {
    NewTick = SysTickCntr;
    if (NewTick!=LastTick) { // SysTickCntr changed
      LastTick = NewTick;
      DivideCntr--;
      }
    }
  return;
}

void SysTick_Handler(void)
{ // Trigger at 1KHz
  SysTickCntr++;
  return;
}
