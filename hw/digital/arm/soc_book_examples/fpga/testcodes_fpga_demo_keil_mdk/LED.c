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
// Purpose: LED utility functions
// ----------------------------------------------

#include "LED.h"
#include "cm3_mcu.h"

#define FPGA_CONFIG

#ifdef FPGA_CONFIG
typedef struct
{
  __IO   uint32_t  CTRL;          /*!< Offset: 0x000 CTRL Register  (R/W) */
  __IO   uint32_t  LED;           /*!< Offset: 0x004 LED Register (R/W) */
  __IO   uint32_t  RGBled0;       /*!< Offset: 0x008 RGBled0 Register  (R/W) */
  __IO   uint32_t  RGBled1;       /*!< Offset: 0x00C RGBled1 Register  (R/W) */
  __I    uint32_t  SW;            /*!< Offset: 0x010 Switch Register  (R/ ) */
  __IO   uint32_t  BTN;           /*!< Offset: 0x014 Button Register  (R/ ) */
} CM3MCU_FPGAIO_TypeDef;

#define CM3MCU_FPGAIO_BASE        (CM3MCU_PERIPH_BASE + 0x7000UL)
#define CM3MCU_FPGAIO             ((CM3MCU_FPGAIO_TypeDef   *) CM3MCU_FPGAIO_BASE )
#endif

//-----------------------------------
void    LED_On         (void)
{
#ifdef FPGA_CONFIG
  CM3MCU_FPGAIO->LED |= (0xFUL);
#else
  CM3MCU_GPIO0->DATAOUT |= (0x01UL); // Set data output to 1    
#endif
  return;
}
//-----------------------------------
void    LED_Off        (void)
{
#ifdef FPGA_CONFIG
  CM3MCU_FPGAIO->LED &= ~(0xFUL);
#else
  CM3MCU_GPIO0->DATAOUT &= ~(0x01UL); // Set data output to 0
#endif
  return;
}

//-----------------------------------
int32_t LED_Initialize (void)
{
#ifdef FPGA_CONFIG
#else
  CM3MCU_GPIO0->DATAOUT &= ~(0x01UL); // Set data output to 0
  CM3MCU_GPIO0->OUTEN   |= 0x1UL; // Enable bit 0 as output
#endif
  return (0);
}

#ifdef FPGA_CONFIG
void LED_scroll(void){
    int static led_scroll_state=0;
    switch (led_scroll_state) {
        case 0:
          CM3MCU_FPGAIO->LED = 1UL<<0;
        if ((CM3MCU_FPGAIO->BTN & 0x1)==0) led_scroll_state++;
            break;
        case 1:
          CM3MCU_FPGAIO->LED = 1UL<<1;    
        if ((CM3MCU_FPGAIO->BTN & 0x2)==0) led_scroll_state++;
            break;
        case 2:
          CM3MCU_FPGAIO->LED = 1UL<<2;    
        if ((CM3MCU_FPGAIO->BTN & 0x4)==0) led_scroll_state++;
            break;
        case 3:
          CM3MCU_FPGAIO->LED = 1UL<<3;    
        if ((CM3MCU_FPGAIO->BTN & 0x8)==0) led_scroll_state++;
            break;
        case 4:
          CM3MCU_FPGAIO->LED = 1UL<<2;    
        if ((CM3MCU_FPGAIO->BTN & 0x4)==0) led_scroll_state++;
            break;
        case 5:
          CM3MCU_FPGAIO->LED = 1UL<<1;    
        if ((CM3MCU_FPGAIO->BTN & 0x2)==0) led_scroll_state=0;
            break;
        default:
            led_scroll_state = 0;
          break;
    }  
    if (led_scroll_state > 5) led_scroll_state=0;

  return;
}
void RGB_LED_show(void)
{
    static uint32_t rgb0_r=0,rgb0_g=0,rgb0_b=0;
    static uint32_t rgb0_r_cntr=0,rgb0_g_cntr=0,rgb0_b_cntr=0;
    static uint32_t rgb1_r=0,rgb1_g=0,rgb1_b=0;
    static uint32_t rgb1_r_cntr=0,rgb1_g_cntr=0,rgb1_b_cntr=0;
    uint32_t rgb0_all,rgb1_all;

    rgb0_r_cntr++;
    rgb0_g_cntr++;
    rgb0_b_cntr++;
    rgb1_r_cntr++;
    rgb1_g_cntr++;
    rgb1_b_cntr++;
    if (rgb0_r_cntr > 300) {rgb0_r_cntr = 0;rgb0_r++;}
    if (rgb0_g_cntr > 400) {rgb0_g_cntr = 0;rgb0_g++;}
    if (rgb0_b_cntr > 500) {rgb0_b_cntr = 0;rgb0_b++;}
    if (rgb1_r_cntr > 350) {rgb1_r_cntr = 0;rgb1_r++;}
    if (rgb1_g_cntr > 450) {rgb1_g_cntr = 0;rgb1_g++;}
    if (rgb1_b_cntr > 550) {rgb1_b_cntr = 0;rgb1_b++;}
    if (rgb0_r>31) rgb0_r=0;
    if (rgb0_g>31) rgb0_g=0;
    if (rgb0_b>31) rgb0_b=0;
    if (rgb1_r>31) rgb1_r=0;
    if (rgb1_g>31) rgb1_g=0;
    if (rgb1_b>31) rgb1_b=0;
    rgb0_all = 0;
    rgb1_all = 0;
    if (rgb0_r>15) rgb0_all |= (31-rgb0_r);
    else           rgb0_all |= rgb0_r;
    if (rgb0_g>15) rgb0_all |= ((31-rgb0_g)<<4);         
    else           rgb0_all |= (rgb0_g<<4);
    if (rgb0_b>15) rgb0_all |= ((31-rgb0_b)<<8);         
    else           rgb0_all |= (rgb0_b<<8);
    if (rgb1_r>15) rgb1_all |= (31-rgb1_r);
    else           rgb1_all |= rgb1_r;
    if (rgb1_g>15) rgb1_all |= ((31-rgb1_g)<<4);         
    else           rgb1_all |= (rgb1_g<<4);
    if (rgb1_b>15) rgb1_all |= ((31-rgb1_b)<<8);         
    else           rgb1_all |= (rgb1_b<<8);
    // Tune down LED brightness
    rgb0_all = (rgb0_all>>2) & 0x333UL;
    rgb1_all = (rgb1_all>>2) & 0x333UL;
            
    CM3MCU_FPGAIO->RGBled0=rgb0_all;
    CM3MCU_FPGAIO->RGBled1=rgb1_all;
    return;
}
#endif
