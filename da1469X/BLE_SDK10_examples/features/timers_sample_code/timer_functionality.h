/**
 ****************************************************************************************
 *
 * @file timer_functionality.h
 *
 * @brief Definition of APIs used for demonstrating TIMER functionality
 *
 * Copyright (c) 2019 Dialog Semiconductor. All rights reserved.
 *
 * This software ("Software") is owned by Dialog Semiconductor. By using this Software
 * you agree that Dialog Semiconductor retains all intellectual property and proprietary
 * rights in and to this Software and any use, reproduction, disclosure or distribution
 * of the Software without express written permission or a license agreement from Dialog
 * Semiconductor is strictly prohibited. This Software is solely for use on or in
 * conjunction with Dialog Semiconductor products.
 *
 * EXCEPT AS OTHERWISE PROVIDED IN A LICENSE AGREEMENT BETWEEN THE PARTIES OR AS
 * REQUIRED BY LAW, THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. EXCEPT AS OTHERWISE PROVIDED
 * IN A LICENSE AGREEMENT BETWEEN THE PARTIES OR BY LAW, IN NO EVENT SHALL DIALOG
 * SEMICONDUCTOR BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT, INCIDENTAL, OR
 * CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 * PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
 * ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THE SOFTWARE.
 *
 ****************************************************************************************
 */

#ifndef TIMER_FUNCTIONALITY_H_
#define TIMER_FUNCTIONALITY_H_



/*
 * @brief Macro used for selecting the active edge of the input capture signal.
 *
 * A value set to 1 will trigger the GPIO1 event counter on the rising edge of the
 * signal whilst, the GPIO2 event counter will be triggered on the opposite edge.
 * Thus, measuring the duty cycle ON of the trigger pulse.
 *
 *  GPIO1                  GPIO2
 *      _____________________               __________________
 *     |                     |             |
 *  ___|          ON         |_____OFF_____|
 *
 *
 * A value set to 0 will trigger the GPIO1 event counter on the falling edge of the
 * signal whilst, the GPIO2 event counter will be triggered on the opposite edge.
 * Thus, measuring the duty cycle OFF of the trigger pulse.
 *
 *                        GPIO1         GPIO2
 *      _____________________               __________________
 *     |                     |             |
 *  ___|         ON          |_____OFF_____|
 *
 */
#define TIMER1_CAPTURE_DUTY_CYCLE_ON     (0)


/*
 * @brief GPIO pin used by the PWM functionality.
 *
 * \note TIMER1 can drive P1_1 pin even when the system is in extended sleep mode.
 *       RED LED1 on Pro DevKit is connected to P1_1 pin.
 */
#define TIMER1_PWM_PORT   HW_GPIO_PORT_1
#define TIMER1_PWM_PIN    HW_GPIO_PIN_1


/*
 * @brief GPIO pin used for timer capture functionality
 *
 * \note  HW_TIMER & HW_TIMER3 functionality is mapped on PORT0 pins whilst,
 *       HW_TIMER2 & HW_TIMER4 functionality is mapped on PORT1 pins.
 */
#define TIMER1_GPIO1_CAPTURE_EVENT_PIN   HW_TIMER_GPIO_PIN_6 /* The KEY1 push button on Pro DevKit is connected to P0_6 pin */
#define TIMER1_GPIO2_CAPTURE_EVENT_PIN   HW_TIMER_GPIO_PIN_6 /* The KEY1 push button on Pro DevKit is connected to P0_6 pin */


/*
 * @brief GPIO pin used for debugging functionality. The pin is toggled following
 *        a TIMERx input capture IRQ event.
 */
#define DBG_CAPTURE_ISR_PORT   HW_GPIO_PORT_0
#define DBG_CAPTURE_ISR_PIN    HW_GPIO_PIN_20



/********** Notification Bitmasks ********/
#define TIMER1_GPIO2_CAPTURE_EVENT_NOTIF   (1 << 1)



/*
 * @brief TIMER initialization
 *
 * This function configures TIMER in capture mode  as well as enables its PWM functionality.
 *
 * \param [in] id  Timer id.
 */
void _timer_init(HW_TIMER_ID id);


/*
 * @brief Change the duty cycle (PWM) of \p id timer based on the measured pulse width
 *
 * This function implements 3 different time windows.
 *
 * \param [in] id           Timer id
 * \param [in] pulse_wdith  The time distance, expressed in timer ticks, between two successive
 *                          events (GPIO1 and GPIO2)
 *
 * \warning It's a prerequisite that timer with \p id has been configured (_timer_init)
 */
void _configure_pwm_duty_cycle(HW_TIMER_ID id, uint32_t pulse_width);


/*
 * @brief Compute the time distance between successive timer capture events (e.g. GPIO1 and GPIO2)
 *
 * \return The time distance between the two events, expressed in timer ticks
 *
 * \warning It's a prerequisite that timer with \p id has been configured (_timer_init)
 */
uint32_t _compute_pulse_width(HW_TIMER_ID id);



/*
 * @brief Convert microseconds to timer ticks
 *
 * \param [in] id Timer id
 *
 * \param [in] time_in_us Time distance expressed in microseconds
 *
 * \warning It's a prerequisite that timer with \p id has been configured (_timer_init)
 */
uint32_t _convert_us_2_timer_ticks(HW_TIMER_ID id, uint32_t time_in_us);


/*
 * @brief Convert timer ticks to microseconds
 *
 * \param [in] id Timer id
 *
 * \param [in] timer_ticks Time distance expressed in timer ticks
 *
 * \warning It's a prerequisite that timer with \p id has been configured (_timer_init)
 */
uint32_t _convert_timer_ticks_2_us(HW_TIMER_ID id, uint32_t timer_ticks);


#endif /* TIMER_FUNCTIONALITY_H_ */
