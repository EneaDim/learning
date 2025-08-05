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

