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
// Purpose: Simple tests for timer peripheral
// ----------------------------------------------
#include "cm3_mcu.h"
#include <stdio.h>

extern void uart_config(void);
extern void uart_putc(char c);
void set_Timer0ExtInput(int state);
void set_Timer1ExtInput(int state);
volatile int timer0_irq_occurred=0;
volatile int timer1_irq_occurred=0;
volatile int timer0_irq_expected=0;
volatile int timer1_irq_expected=0;


int main(void)
{
  int  i;
  uint32_t start_time, stop_time;
  int  timeout_count;

  uart_config();
  printf ("Timer test\n");
  
  //---------------------------------
  // test 1 - internal timer
  //---------------------------------
  printf ("Test 1: - polling\n");
  CM3MCU_TIMER0->CTRL   = 0;
  CM3MCU_TIMER0->RELOAD = 0x1000;
  CM3MCU_TIMER0->CURRVAL = 0x0;
  CM3MCU_TIMER0->CTRL   = CM3MCU_TIMER_CTRL_EN_Msk;
  start_time = CM3MCU_TIMER0->CURRVAL;
  __ISB();
  __ISB();
  __ISB();
  CM3MCU_TIMER0->CTRL   = 0;
  stop_time = CM3MCU_TIMER0->CURRVAL;
  printf("- short delay: 0x%x, 0x%x\n", start_time, stop_time);
  if (start_time==stop_time) {
      printf ("ERROR: Timer is not running\n"); 
      uart_putc(4);// end simulation
    }
  if (stop_time != CM3MCU_TIMER0->CURRVAL){
      printf ("ERROR: Unable to stop timer\n"); 
      uart_putc(4);// end simulation
    }
  printf("- run to 0...\n");  
  CM3MCU_TIMER0->CTRL   =  CM3MCU_TIMER_CTRL_EN_Msk|CM3MCU_TIMER_CTRL_IRQEN_Msk;
  timeout_count=0;
  while ((CM3MCU_TIMER0->IRQSTATE==0)&(timeout_count<0x1000)){
    timeout_count++;
    }
  CM3MCU_TIMER0->CTRL   = 0; // stop
  if (timeout_count >= 0x1000){
      printf ("ERROR: Timeout #1\n"); 
      uart_putc(4);// end simulation
    }
  printf ("- current VAL=0x%x\n", CM3MCU_TIMER0->CURRVAL);
  if (CM3MCU_TIMER0->CURRVAL > 0x1000)  {
      printf ("ERROR: Reload error #1\n"); 
      uart_putc(4);// end simulation
    }
  CM3MCU_TIMER0->IRQSTATE = CM3MCU_TIMER0->IRQSTATE; //clear IRQ state
  if (CM3MCU_TIMER0->IRQSTATE!=0){
      printf ("ERROR: IRQSTATE cannot be cleared\n"); 
      uart_putc(4);// end simulation
    }

  //---------------------------------
  // test 2 - interrupt
  //---------------------------------
  printf ("Test 2: - timer#0 IRQ\n");
  NVIC_ClearPendingIRQ(TIMER0_IRQn);
  NVIC_EnableIRQ(TIMER0_IRQn);
  timer0_irq_occurred=0;
  timer0_irq_expected=1;
  CM3MCU_TIMER0->CTRL   =  CM3MCU_TIMER_CTRL_EN_Msk|CM3MCU_TIMER_CTRL_IRQEN_Msk;
  timeout_count=0;
  while ((timer0_irq_occurred==0)&(timeout_count<0x1000)){
    timeout_count++;
    }
  CM3MCU_TIMER0->CTRL   = 0; // stop
  if (timeout_count >= 0x1000){
      printf ("ERROR: Timeout #1\n"); 
      uart_putc(4);// end simulation
    }
  timer0_irq_occurred=0;
  timer0_irq_expected=0;
  
  //---------------------------------
  // test 3 - interrupt
  //---------------------------------
  printf ("Test 3: - timer#1 IRQ\n");
  NVIC_ClearPendingIRQ(TIMER1_IRQn);
  NVIC_EnableIRQ(TIMER1_IRQn);
  timer1_irq_occurred=0;
  timer1_irq_expected=1;
  CM3MCU_TIMER1->CTRL   = 0;
  CM3MCU_TIMER1->RELOAD = 0x1000;
  CM3MCU_TIMER1->CURRVAL = 0x0;
  CM3MCU_TIMER1->CTRL   =  CM3MCU_TIMER_CTRL_EN_Msk|CM3MCU_TIMER_CTRL_IRQEN_Msk;
  timeout_count=0;
  while ((timer1_irq_occurred==0)&(timeout_count<0x1000)){
    timeout_count++;
    }
  CM3MCU_TIMER1->CTRL   = 0; // stop
  if (timeout_count >= 0x1000){
      printf ("ERROR: Timeout #1\n"); 
      uart_putc(4);// end simulation
    }
  timer1_irq_occurred=0;
  timer1_irq_expected=0;
  NVIC_DisableIRQ(TIMER1_IRQn);
  
  //---------------------------------
  // test 4 - external level enable
  //---------------------------------
  printf ("Test 4: - timer#0 ext level input\n");
  NVIC_DisableIRQ(TIMER0_IRQn);

  CM3MCU_TIMER0->CTRL   = 0;
  CM3MCU_TIMER0->IRQSTATE = CM3MCU_TIMER0->IRQSTATE;
  CM3MCU_TIMER0->RELOAD = 0x1000;
  CM3MCU_TIMER0->CURRVAL = 0x1000;
  CM3MCU_TIMER0->CTRL   = CM3MCU_TIMER_CTRL_ExtENSel_Msk;
  
  printf ("- ext level input=0\n");  
  set_Timer0ExtInput(0); // Pull low Time0 Ext
  CM3MCU_TIMER0->CTRL   |=    CM3MCU_TIMER_CTRL_EN_Msk; // Enable
  // Should not be running as external enable is low
  start_time = CM3MCU_TIMER0->CURRVAL;
  __ISB();
  __ISB();
  __ISB();
  CM3MCU_TIMER0->CTRL   = 0;
  stop_time = CM3MCU_TIMER0->CURRVAL;
  printf("- short delay: 0x%x, 0x%x\n", start_time, stop_time);
  if (start_time!=stop_time) {
      printf ("ERROR: Timer is running when ExtEn is 0\n"); 
      uart_putc(4);// end simulation
    }
  CM3MCU_TIMER0->CTRL   = CM3MCU_TIMER_CTRL_ExtENSel_Msk;
  CM3MCU_TIMER0->CTRL   |=    CM3MCU_TIMER_CTRL_EN_Msk; // Enable

  printf ("- ext level input=1\n");
  set_Timer0ExtInput(1); // Pull high Time0 Ext
  // Should be running as external enable is high
  start_time = CM3MCU_TIMER0->CURRVAL;
  __ISB();
  __ISB();
  __ISB();
  CM3MCU_TIMER0->CTRL   = 0;
  stop_time = CM3MCU_TIMER0->CURRVAL;
  printf("- short delay: 0x%x, 0x%x\n", start_time, stop_time);
  if (start_time==stop_time) {
      printf ("ERROR: Timer is not running when ExtEn is 1\n"); 
      uart_putc(4);// end simulation
    }

  printf ("- ext level input=0\n");  
  printf ("- set ext level as clock\n");  
  set_Timer0ExtInput(0); // Pull low Time0 Ext
  CM3MCU_TIMER0->RELOAD  = 0x100;
  CM3MCU_TIMER0->CURRVAL = 0x100;
  CM3MCU_TIMER0->CTRL   = CM3MCU_TIMER_CTRL_ExtENSel_Msk|
                          CM3MCU_TIMER_CTRL_ExtClkSel_Msk|
                          CM3MCU_TIMER_CTRL_EN_Msk|
                          CM3MCU_TIMER_CTRL_IRQEN_Msk;
  
  // Should not be running as external enable is low
  start_time = CM3MCU_TIMER0->CURRVAL;
  __ISB();
  __ISB();
  __ISB();
  CM3MCU_TIMER0->CTRL   = 0;
  stop_time = CM3MCU_TIMER0->CURRVAL;
  printf("- short delay: 0x%x, 0x%x\n", start_time, stop_time);
  if (start_time!=stop_time) {
      printf ("ERROR: Timer is running when ExtEn is 0\n"); 
      uart_putc(4);// end simulation
    }
  CM3MCU_TIMER0->CTRL   = CM3MCU_TIMER_CTRL_ExtENSel_Msk|
                          CM3MCU_TIMER_CTRL_ExtClkSel_Msk|
                          CM3MCU_TIMER_CTRL_EN_Msk|
                          CM3MCU_TIMER_CTRL_IRQEN_Msk;
    
  start_time = CM3MCU_TIMER0->CURRVAL;
  for (i=0;i< 0xFE;i++){
    set_Timer0ExtInput(1);
    set_Timer0ExtInput(0);
    }
  stop_time = CM3MCU_TIMER0->CURRVAL;
  printf("- loop 0xFFE times: 0x%x, 0x%x\n", start_time, stop_time);
  if (start_time==stop_time) {
      printf ("ERROR: Timer is not running when ExtEn is clocked\n"); 
      uart_putc(4);// end simulation
    }

  if (CM3MCU_TIMER0->IRQSTATE!=0){
      printf ("ERROR: IRQSTATE set unexpectedly\n"); 
      uart_putc(4);// end simulation
    }

  set_Timer0ExtInput(1);
  set_Timer0ExtInput(0);
  printf("- 1x clock: val=0x%x, irqstate=%x\n", CM3MCU_TIMER0->CURRVAL, CM3MCU_TIMER0->IRQSTATE);

  set_Timer0ExtInput(1);
  set_Timer0ExtInput(0);
  printf("- 1x clock: val=0x%x, irqstate=%x\n", CM3MCU_TIMER0->CURRVAL, CM3MCU_TIMER0->IRQSTATE);

  if (CM3MCU_TIMER0->IRQSTATE==0){
      printf ("ERROR: IRQSTATE not set when count to 0\n"); 
      uart_putc(4);// end simulation
    }

  set_Timer0ExtInput(1);
  set_Timer0ExtInput(0);
  printf("- 1x clock: val=0x%x, irqstate=%x\n", CM3MCU_TIMER0->CURRVAL, CM3MCU_TIMER0->IRQSTATE);
    
  if (CM3MCU_TIMER0->CURRVAL!=0x100){
      printf ("ERROR: Current value not reloaded correctly\n"); 
      uart_putc(4);// end simulation
    }
  
  printf ("Test done\n");
  uart_putc(4);// end simulation
  
  while(1);
}   
  
//-----------------------

void TIMER0_Handler(void)
{
  if (timer0_irq_expected) {
    timer0_irq_occurred=1;
    if (CM3MCU_TIMER0->IRQSTATE==0) {
      printf ("ERROR: reached TIMER0_Handler with T0-IRQSTATE=0\n"); 
      uart_putc(4);// end simulation
      }      
    // Clear Interrupt state
    CM3MCU_TIMER0->IRQSTATE=CM3MCU_TIMER0->IRQSTATE;
    if (CM3MCU_TIMER0->IRQSTATE!=0) {
      printf ("ERROR: Unable to clear T0-IRQSTATE=0\n"); 
      uart_putc(4);// end simulation
      }      
    } else {
      printf ("ERROR:Unexpected T0 IRQ\n"); 
      uart_putc(4);// end simulation
      }      
    
  return;
}
//-----------------------
void TIMER1_Handler(void)
{
  if (timer1_irq_expected) {
    timer1_irq_occurred=1;
    if (CM3MCU_TIMER1->IRQSTATE==0) {
      printf ("ERROR: reached TIMER1_Handler with T1-IRQSTATE=0\n"); 
      uart_putc(4);// end simulation
      }      
    // Clear Interrupt state
    CM3MCU_TIMER1->IRQSTATE=CM3MCU_TIMER1->IRQSTATE;
    if (CM3MCU_TIMER1->IRQSTATE!=0) {
      printf ("ERROR: Unable to clear T1-IRQSTATE=0\n"); 
      uart_putc(4);// end simulation
      }      
    } else {
      printf ("ERROR:Unexpected T1 IRQ\n"); 
      uart_putc(4);// end simulation
      }      
    
  return;
}
//-----------------------
void HardFault(void)
{
  printf ("[HardFault]\n");
  uart_putc(4);// end simulation

}
//-----------------------
void set_Timer0ExtInput(int state)
{
  if (state) {
    CM3MCU_GPIO1->DATAOUT |=   0x01UL ; // Pull high
    CM3MCU_GPIO1->OUTEN   |=   0x01UL ; 
  } else {
    CM3MCU_GPIO1->DATAOUT &= ~(0x01UL); // Pull Low
    CM3MCU_GPIO1->OUTEN   |=   0x01UL ; 
  }
  return;
}  


//-----------------------
void set_Timer1ExtInput(int state)
{
  if (state) {
    CM3MCU_GPIO1->DATAOUT |=   0x02UL ; // Pull high
    CM3MCU_GPIO1->OUTEN   |=   0x02UL ; 
  } else {
    CM3MCU_GPIO1->DATAOUT &= ~(0x02UL); // Pull Low
    CM3MCU_GPIO1->OUTEN   |=   0x02UL ; 
  }
  return;
}  


