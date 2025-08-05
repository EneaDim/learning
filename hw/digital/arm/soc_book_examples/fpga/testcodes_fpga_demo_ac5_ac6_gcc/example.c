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
// Purpose: FPGA example program
//
// Disclaimer
// This example design is created for educational
// purpose only and are not validated to the same 
// quality level as Arm IP products. 
// Arm Education Media and author do not make any 
// warranties of these designs.
// ----------------------------------------------

#include "cm3_mcu.h"
#include "LED.h"
#include "stdio.h"

volatile uint32_t SysTickCntr=0;
void     TickDelay(int32_t);
extern void uart_config(void);
extern void uart_putc(char c);
extern char uart_getc(void);
extern void LED_scroll(void);
extern void RGB_LED_show(void);
int main(void)
{    
    uint32_t LastTick=0, NewTick=0, DivideCntr=0, LoopTick=0;    
    uart_config();
    printf ("Cortex-M3 hello world\n");
    printf ("- CPUID = 0x%x\n", SCB->CPUID);
    if (MPU->TYPE!=0) {
      printf ("- MPU with %d regions detected\n", ((MPU->TYPE>>8)&0xFF));
    } else {
      printf ("- MPU not detected\n");
    }
        
    LED_Initialize();
    SysTick_Config(SystemCoreClock/1000); // 1KHz Ticks
    
    LastTick = SysTickCntr;
    while(1){
        // UART echo
        if (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_RXFULL_Msk) {
            uart_putc(uart_getc());}
        // LED scroll
        NewTick = SysTickCntr;
        LoopTick=0;
        if (NewTick!=LastTick){
            LastTick = NewTick;
            LoopTick=1;
            DivideCntr++;
            if (DivideCntr==199){
              LED_scroll();
              DivideCntr = 0;}
        }            
        // RGB LED 0
        if (LoopTick) RGB_LED_show();
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
