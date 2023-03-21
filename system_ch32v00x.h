/*!****************************************************************************
 * @file
 * system_ch32v00x.h
 *
 * @brief
 * Early system initialisation
 *
 * @date  20.03.2023
 ******************************************************************************/

#ifndef SYSTEM_CH32V00x_H_
#define SYSTEM_CH32V00x_H_

/*- Header files -------------------------------------------------------------*/
#include <stdint.h>


/*- Global variables ---------------------------------------------------------*/
/*! Calculated SYSCLK frequency in Hz                                         */
extern volatile uint32_t SystemCoreClock;


/*- Exported methods ---------------------------------------------------------*/
void SystemInit(void);
void SystemCoreClockUpdate(void);

#endif /*SYSTEM_CH32V00x_H_ */



