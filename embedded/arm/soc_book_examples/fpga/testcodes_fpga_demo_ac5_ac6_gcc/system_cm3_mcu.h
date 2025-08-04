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
// Purpose: System Initialization header file for
//          example Cortex-M3 device based on 
//          CMSIS-CORE 
//
// Disclaimer
// This example design is created for educational
// purpose only and are not validated to the same 
// quality level as Arm IP products. 
// Arm Education Media and author do not make any 
// warranties of these designs.
// ----------------------------------------------

#ifndef SYSTEM_CM3MCU_H
#define SYSTEM_CM3MCU_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

extern uint32_t SystemFrequency;    /*!< System Clock Frequency (Core Clock)  */
extern uint32_t SystemCoreClock;    /*!< Processor Clock Frequency            */


/**
 * Initialize the system
 *
 * @param  none
 * @return none
 *
 * @brief  Setup the microcontroller system.
 *         Initialize the System and update the SystemCoreClock variable.
 */
extern void SystemInit (void);

/**
 * Update SystemCoreClock variable
 *
 * @param  none
 * @return none
 *
 * @brief  Updates the SystemCoreClock with current core Clock 
 *         retrieved from cpu registers.
 */
extern void SystemCoreClockUpdate (void);

#ifdef __cplusplus
}
#endif

#endif /* SYSTEM_CM3MCU_H */
