/*!****************************************************************************
 * @file
 * system_ch32v00x.c
 *
 * @brief
 * Early system initialisation
 *
 * @date  20.03.2023
 ******************************************************************************/

/*- Header files -------------------------------------------------------------*/
#include "ch32v00x.h"
#include "system_ch32v00x.h"


/*- Compiler options ---------------------------------------------------------*/
#pragma GCC push_options
#pragma GCC optimize("O1")


/*- Global variables ---------------------------------------------------------*/
/*! Calculated SYSCLK frequency in Hz                                         */
volatile uint32_t SystemCoreClock;


/*- Private functions --------------------------------------------------------*/
/*!****************************************************************************
 * @brief
 * Determine SYSCLK base clock frequency for PLL configuration
 *
 * @param[in] uCfgR0      Cached RCC_CFGR0 value
 * @return  (unsigned)  Base clock frequency in Hz
 * @date  20.03.2023
 ******************************************************************************/
static inline unsigned uCalcPllBaseClk(unsigned uCfgR0)
{
  if ((uCfgR0 & RCC_PLLSRC) == RCC_PLLSRC_HSE_Mul2) return HSE_VALUE * 2u;
  else                                              return HSI_VALUE * 2U;
}

/*!****************************************************************************
 * @brief
 * Calculate HCLK (System Core Clock) from Baseclock and Prescaler setting
 *
 * @param[in] uCfgR0      Cached RCC_CFGR0 value
 * @param[in] uBaseClk    Base clock frequency from HSI, HSE or PLL, in Hz
 * @return  (unsigned)  System Core Clock frequency in Hz
 * @date  20.03.2023
 ******************************************************************************/
static inline unsigned uCalcSysCoreClk(unsigned uCfgR0, unsigned uBaseClk)
{
  /* Pre-calculate divider/shift count (always >= 1)      */
  unsigned uDiv = 1u + (((uCfgR0 & RCC_HPRE) >> 4) & 0x7u);

  /* Mode Select: Off, shift or integer divide            */
  if ((uCfgR0 & RCC_HPRE) == RCC_HPRE_DIV1) return uBaseClk;
  else if (!!(uCfgR0 & RCC_HPRE_3))         return uBaseClk >> uDiv;
  else                                      return uBaseClk / uDiv;
}


/*!****************************************************************************
 * @brief
 * Early system init
 *
 * Initialises minimum-config for clocking tree
 *
 *        24 MHz                            24 MHz       3 MHz
 *   HSI ------> SYSCLK ---[ /1 ]---> HCLK ---+---[ /8 ]--------------> SysTick
 *                                            |          12 MHz
 *                                            +---[ /2 ]--------------> ADC
 *
 * References:
 *  [1] CH32V003RM "CH32x003 Reference Manual", p. 13ff
 *      http://www.wch-ic.com/downloads/CH32V003RM_PDF.html
 *
 * @date  20.03.2023
 ******************************************************************************/
void SystemInit(void)
{
  /* Enable HSI and switch SYSCLK to it                   */
  RCC->CTLR |= RCC_HSION;
  RCC->CFGR0 &= ~(RCC_CFGR0_MCO | RCC_ADCPRE | RCC_HPRE | RCC_SW);

  /* Power down and de-configure PLL and HSE              */
  RCC->CTLR &= ~(RCC_PLLON | RCC_CSSON | RCC_HSEON);
  RCC->CTLR &= ~RCC_HSEBYP;
  RCC->CFGR0 &= ~RCC_PLLSRC;

  /* Disable RCC interrupts and clear interrupt flags     */
  RCC->INTR &= ~(RCC_PLLRDYIE | RCC_HSERDYIE | RCC_HSIRDYIE | RCC_LSERDYIE | RCC_LSIRDYIE);
  RCC->INTR |= RCC_CSSC | RCC_PLLRDYC | RCC_HSERDYC | RCC_HSIRDYC | RCC_LSERDYC | RCC_LSIRDYC;

  /* Update System Core clock frequency variable          */
  SystemCoreClock = HSI_VALUE;
}

/*!****************************************************************************
 * @brief
 * Calculate HCLK from current configuration
 *
 * @date  20.03.2023
 ******************************************************************************/
void SystemCoreClockUpdate(void)
{
  unsigned uConfigVal = RCC->CFGR0;
  unsigned uBaseClk;

  /* Determine SYSCLK base clock frequency                */
  switch (uConfigVal & RCC_SWS)
  {
    case RCC_SWS_HSI: uBaseClk = HSI_VALUE; break;
    case RCC_SWS_HSE: uBaseClk = HSE_VALUE; break;
    case RCC_SWS_PLL: uBaseClk = uCalcPllBaseClk(uConfigVal); break;
    default:
      /* Invalid configuration                            */
      uBaseClk = HSI_VALUE;
  }

  /* Apply HCLK prescalers                                */
  SystemCoreClock = uCalcSysCoreClk(uConfigVal, uBaseClk);
}


/*- Restore previous compiler options ----------------------------------------*/
#pragma GCC pop_options

