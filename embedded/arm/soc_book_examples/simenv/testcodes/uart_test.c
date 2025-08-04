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
// Purpose: Simple tests for UART peripheral
// ----------------------------------------------

#include "cm3_mcu.h"
#include <stdio.h>

extern void uart_config(void);
extern void uart_putc(char c);
extern char uart_getc(void);
void set_UART_loop(int state);

char test_buf[20];

volatile int tx_irq_occurred=0;
volatile int rx_irq_occurred=0;
volatile int tx_irq_expected=0;
volatile int rx_irq_expected=0;


int main(void)
{
  int  loop_exit,i;
  int  tx_count;
  int  rx_count;
  int  timeout_count;
  const char test_msg[]="0123456789";
  
  uart_config();
  printf ("UART test\n");
  
  //---------------------------------
  // test 1 - polling
  //---------------------------------
  printf ("Test 1: - polling\n");
  for (i=0; i<256; i++) { // Delay until printf msg is cleared
    __ISB();   }
    
  CM3MCU_UART0->CTRL    |= 
  (CM3MCU_UART_CTRL_TXEN_Msk | CM3MCU_UART_CTRL_RXEN_Msk); // Enable both TX and RX
  
  set_UART_loop(1); // enable loop back
  tx_count = 0;
  rx_count = 0;
  loop_exit= 0;
  while (loop_exit==0){
    // TX operations
    if (
        (tx_count < 10) & 
        ((CM3MCU_UART0->STATE & CM3MCU_UART_STATE_TXFULL_Msk)==0)
       ) {
       uart_putc(test_msg[tx_count]);
       tx_count++;
       }
    // RX operations
    if (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_RXFULL_Msk){
       test_buf[rx_count] = uart_getc();
       rx_count++;
       if (rx_count>=10) {
         loop_exit=1;
	 test_buf[10]=0; // NULL character
         }
       }
    } // end-while
  set_UART_loop(0); // disable loop back
  printf ("- 10 characters transferred %s\n", &test_buf[0]);

  //---------------------------------
  // test 2 - interrutp based transfers
  //---------------------------------
  printf ("Test 2: - interrupt\n");
  for (i=0; i<256; i++) { // Delay until printf msg is cleared
    __ISB();   }

   // Enable both TX IRQ and RX IRQ
  CM3MCU_UART0->CTRL    |= 
  (CM3MCU_UART_CTRL_TXIRQEN_Msk | CM3MCU_UART_CTRL_RXIRQEN_Msk);
  NVIC_EnableIRQ(UARTTX0_IRQn);
  NVIC_EnableIRQ(UARTRX0_IRQn);
  tx_irq_occurred=0;
  rx_irq_occurred=0;
  tx_irq_expected=1;
  rx_irq_expected=1;
   
  set_UART_loop(1); // enable loop back
  tx_count = 0;
  rx_count = 0;
  loop_exit= 0;
  // Transmit first character
  uart_putc(test_msg[tx_count]);
  tx_count++;
  
  while (loop_exit==0){
    // TX operations
    if (tx_irq_occurred) {
       tx_irq_occurred = 0;
       if (tx_count>=10) { // Clear TX IRQ       
         CM3MCU_UART0->CTRL &= ~(CM3MCU_UART_CTRL_TXIRQEN_Msk);
         } else {
         uart_putc(test_msg[tx_count]);
         tx_count++;
	 if (tx_count==10) {
            // Clear TX IRQ       
            CM3MCU_UART0->CTRL &= ~(CM3MCU_UART_CTRL_TXIRQEN_Msk);	   
	   }
	 }
       }
    // RX operations
    if (rx_irq_occurred){
       rx_irq_occurred = 0;
       test_buf[rx_count] = uart_getc();
       rx_count++;
       if (rx_count>=10) {
         loop_exit=1;
	 test_buf[10]=0; // NULL character
         }
       }
    } // end-while
  set_UART_loop(0); // disable loop back
  NVIC_DisableIRQ(UARTTX0_IRQn);
  NVIC_DisableIRQ(UARTRX0_IRQn);
  // Disable IRQ
  CM3MCU_UART0->CTRL    &= 
  ~(CM3MCU_UART_CTRL_TXIRQEN_Msk | CM3MCU_UART_CTRL_RXIRQEN_Msk);

  tx_irq_expected=0;
  rx_irq_expected=0;

  printf ("- 10 characters transferred %s\n", &test_buf[0]);
 
  //---------------------------------
  // test 3 - Overrun error
  //---------------------------------
  printf ("Test 3a: - TX overrun\n");
  // Transmit 3 characters 
  uart_putc(test_msg[0]);
  uart_putc(test_msg[1]);
  CM3MCU_UART0->TXD = (uint32_t) test_msg[2];
  // Overrun should happened by now
  if (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_TXOVR_Msk) {
    printf ("- TX overflow correctly detected\n");
    // Clear overflow status
    CM3MCU_UART0->STATE = CM3MCU_UART_STATE_TXOVR_Msk;
    __ISB(); // delay
    __ISB();
    if (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_TXOVR_Msk) {
      printf ("- ERROR: TX overflow not cleared correctly\n");
      uart_putc(4);// end simulation
      }
  } else {
    printf ("- ERROR:TX overflow not detected\n");
    uart_putc(4);// end simulation
  }
  printf ("Test 3b: - RX overrun\n");
  for (i=0; i<256; i++) { // Delay until printf msg is cleared
    __ISB();   }

  set_UART_loop(1); // enable loop back
  uart_putc(test_msg[0]);// 1st character
  uart_putc(test_msg[1]);// 2nd character
  timeout_count=0;
  loop_exit=0;
  while (loop_exit==0) {
    if (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_RXOVR_Msk){
      loop_exit=1;
      }
    timeout_count++;
    __ISB(); // delay
    if (timeout_count > 5000) {
      loop_exit=1;
      }
    }
  set_UART_loop(0); // disable loop back

  // See if RX overflow correctly received  
  if ((CM3MCU_UART0->STATE & CM3MCU_UART_STATE_RXOVR_Msk)  !=0) {    
    printf ("- RX overflow correctly detected\n");

    // Clear overflow status
    CM3MCU_UART0->STATE = CM3MCU_UART_STATE_RXOVR_Msk;

    while (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_RXFULL_Msk) {
      i = CM3MCU_UART0->RXD;}
    if (CM3MCU_UART0->STATE & CM3MCU_UART_STATE_RXOVR_Msk) {
      printf ("- ERROR: RX overflow not cleared correctly\n");
      uart_putc(4);// end simulation
      }
  } else {
    if  (timeout_count>5000) {
      printf ("ERROR: timeout while waiting for RX overflow\n");
      uart_putc(4);// end simulation
      }   
    }
  
  
 
  printf ("Test done\n");
  uart_putc(4);// end simulation
  
  while(1);
}   
//-----------------------

void UARTTX0_Handler(void)
{
  if (tx_irq_expected!=0) {
    tx_irq_occurred = 1;
    if ((CM3MCU_UART0->IRQSTATE & CM3MCU_UART_IRQSTATE_TX_Msk)==0) {
      // ERROR report
      set_UART_loop(0); // disable loop back
      printf ("[UARTTX0_Handler] ERROR: IRQSTATE-TX is 0\n");
      uart_putc(4);// end simulation
    } else { // Clear UART TX Interrupt state   
      CM3MCU_UART0->IRQSTATE = CM3MCU_UART_IRQSTATE_TX_Msk;
    }
    } else {
    set_UART_loop(0); // disable loop back
    printf ("[UARTTX0_Handler] ERROR: Unexpected\n");
    uart_putc(4);// end simulation
    }
  return;
}
//-----------------------

void UARTRX0_Handler(void)
{
  if (rx_irq_expected!=0) { // expected
    rx_irq_occurred = 1;
    if ((CM3MCU_UART0->IRQSTATE & CM3MCU_UART_IRQSTATE_RX_Msk)==0) {
      // ERROR report
      set_UART_loop(0); // disable loop back
      printf ("[UARTRX0_Handler] ERROR: IRQSTATE-RX is 0\n");
      uart_putc(4);// end simulation
    } else { // Clear UART RX Interrupt state   
      CM3MCU_UART0->IRQSTATE = CM3MCU_UART_IRQSTATE_RX_Msk;
    }
      
    } else {
    set_UART_loop(0); // disable loop back
    printf ("[UARTRX0_Handler] ERROR: Unexpected\n");
    uart_putc(4);// end simulation
    }
  return;
}
//-----------------------
void HardFault(void)
{
  set_UART_loop(0); // disable loop back
  printf ("[HardFault]\n");
  uart_putc(4);// end simulation

}
//-----------------------

void set_UART_loop(int state)
{
  if (state) {
    CM3MCU_GPIO0->DATAOUT &= ~(0x80UL); // Pull low
    CM3MCU_GPIO0->OUTEN   |=   0x80UL ; 
  } else {
    CM3MCU_GPIO0->DATAOUT |=   0x80UL ; // Pull high
    CM3MCU_GPIO0->OUTEN   |=   0x80UL ; 
  }
  return;
}  
//-----------------------
