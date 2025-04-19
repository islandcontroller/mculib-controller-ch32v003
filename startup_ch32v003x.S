.include "Core/startup_riscv.s"

/******************************************************************************
 * _vector_base
 * Interrupt Vector Table (Address LUT Mode)
 *
 * In order to use this IVT, startup has to  configure mtvec[1:0] = 0b11 !!
 ******************************************************************************/
.section  .isr_vector,"ax",@progbits
.globl  _vector_base
_vector_base:
  .option push
  .option norvc
  /* Internal interrupts                                                      */
  j     _start                        /* Reset Handler                        */
  .word 0
  .word NMI_Handler                   /* NMI Handler                          */
  .word HardFault_Handler             /* Hard Fault Handler                   */
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word SysTick_Handler               /* SysTick Handler                      */
  .word 0
  .word SW_Handler                    /* SW Handler                           */
  .word 0
  /* External Interrupts                                                      */
  .word WWDG_IRQHandler               /* Window Watchdog                      */
  .word PVD_IRQHandler                /* PVD through EXTI Line detect         */
  .word FLASH_IRQHandler              /* Flash                                */
  .word RCC_IRQHandler                /* RCC                                  */
  .word EXTI7_0_IRQHandler            /* EXTI Line 7..0                       */
  .word AWU_IRQHandler                /* AWU                                  */
  .word DMA1_Channel1_IRQHandler      /* DMA1 Channel 1                       */
  .word DMA1_Channel2_IRQHandler      /* DMA1 Channel 2                       */
  .word DMA1_Channel3_IRQHandler      /* DMA1 Channel 3                       */
  .word DMA1_Channel4_IRQHandler      /* DMA1 Channel 4                       */
  .word DMA1_Channel5_IRQHandler      /* DMA1 Channel 5                       */
  .word DMA1_Channel6_IRQHandler      /* DMA1 Channel 6                       */
  .word DMA1_Channel7_IRQHandler      /* DMA1 Channel 7                       */
  .word ADC1_IRQHandler               /* ADC1                                 */
  .word I2C1_EV_IRQHandler            /* I2C1 Event                           */
  .word I2C1_ER_IRQHandler            /* I2C1 Error                           */
  .word USART1_IRQHandler             /* USART1                               */
  .word SPI1_IRQHandler               /* SPI1                                 */
  .word TIM1_BRK_IRQHandler           /* TIM1 Break                           */
  .word TIM1_UP_IRQHandler            /* TIM1 Update                          */
  .word TIM1_TRG_COM_IRQHandler       /* TIM1 Trigger and Commutation         */
  .word TIM1_CC_IRQHandler            /* TIM1 Capture Compare                 */
  .word TIM2_IRQHandler               /* TIM2                                 */
  .option pop

/* Weak definitions of interrupt handlers in .text                            */
.section  .text.vector_handler, "ax", @progbits
.weak NMI_Handler
.weak HardFault_Handler
.weak SysTick_Handler
.weak SW_Handler
.weak WWDG_IRQHandler
.weak PVD_IRQHandler
.weak FLASH_IRQHandler
.weak RCC_IRQHandler
.weak EXTI7_0_IRQHandler
.weak AWU_IRQHandler
.weak DMA1_Channel1_IRQHandler
.weak DMA1_Channel2_IRQHandler
.weak DMA1_Channel3_IRQHandler
.weak DMA1_Channel4_IRQHandler
.weak DMA1_Channel5_IRQHandler
.weak DMA1_Channel6_IRQHandler
.weak DMA1_Channel7_IRQHandler
.weak ADC1_IRQHandler
.weak I2C1_EV_IRQHandler
.weak I2C1_ER_IRQHandler
.weak USART1_IRQHandler
.weak SPI1_IRQHandler
.weak TIM1_BRK_IRQHandler
.weak TIM1_UP_IRQHandler
.weak TIM1_TRG_COM_IRQHandler
.weak TIM1_CC_IRQHandler
.weak TIM2_IRQHandler

/* Default to generic handler if not implemented                              */
.set NMI_Handler, Default_Handler
.set HardFault_Handler, Default_Handler
.set SysTick_Handler, Default_Handler
.set SW_Handler, Default_Handler
.set WWDG_IRQHandler, Default_Handler
.set PVD_IRQHandler, Default_Handler
.set FLASH_IRQHandler, Default_Handler
.set RCC_IRQHandler, Default_Handler
.set EXTI7_0_IRQHandler, Default_Handler
.set AWU_IRQHandler, Default_Handler
.set DMA1_Channel1_IRQHandler, Default_Handler
.set DMA1_Channel2_IRQHandler, Default_Handler
.set DMA1_Channel3_IRQHandler, Default_Handler
.set DMA1_Channel4_IRQHandler, Default_Handler
.set DMA1_Channel5_IRQHandler, Default_Handler
.set DMA1_Channel6_IRQHandler, Default_Handler
.set DMA1_Channel7_IRQHandler, Default_Handler
.set ADC1_IRQHandler, Default_Handler
.set I2C1_EV_IRQHandler, Default_Handler
.set I2C1_ER_IRQHandler, Default_Handler
.set USART1_IRQHandler, Default_Handler
.set SPI1_IRQHandler, Default_Handler
.set TIM1_BRK_IRQHandler, Default_Handler
.set TIM1_UP_IRQHandler, Default_Handler
.set TIM1_TRG_COM_IRQHandler, Default_Handler
.set TIM1_CC_IRQHandler, Default_Handler
.set TIM2_IRQHandler, Default_Handler


/******************************************************************************
 * Default_Handler
 * Default interrupt handler for unimplemented interrupts
 ******************************************************************************/
.section  .text.Default_Handler
.balign 4
.globl  Default_Handler
Default_Handler:
  j     Default_Handler

