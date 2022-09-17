/**
 ****************************************************************************************
 *
 * @file motor_sample_code.h
 *
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

#ifndef MOTOR_SAMPLE_CODE_H_
#define MOTOR_SAMPLE_CODE_H_


/*
 * Structure used for declaring motor commands. Each commandFIFO word should adhere to the following format:
 *
 *  ___bits 15:13______bits 12:11_____ bits 10:6_____ bits 5:0___
 * |               |               |               |             |
 * |      PG_ID    |     PG_SIG    |     N_CMDs    |    W_PTR    |
 * |_______________|_______________|_______________|_____________|
 *
 */
typedef struct {
        uint8_t pg_id;
        uint8_t pg_sig;
        uint8_t n_cmds;
        uint8_t w_ptr;
} _motor_commandFIFO;



/*
 * Enable/disable the mirroring mode of the motor controller. Valid values are:
 *
 * 1 --> The mirroring mode is enabled. In single mirroring mode, PGx_SIG0 is reflected on PGx_SIG2 whereas,
         in pair mirroring mode PGx_SIG0 & PGx_SIG1 are reflected on PGx_SIG2 and PGx_SIG3 respectively.
 * 0 --> The motor controller operates in Flex mode (no mirroring mode).
 *
 **/
#define SMOTOR_MIRRORING_MODE_ENABLE  (1)


/*
 * This macro is used for setting the depth of the commandFIFO when operates in cyclic mode.
 * The value depends on the total motor commands invoked. For instance, if two commands are
 * to be executed set this value to 2.
 */
#define SMOTOR_COMMAND_FIFO_DEPTH     0x3


/*
 * XTAL32K clock divider used for generating motor "slots". The maximum allowable value
 * is 0x1F whereas the minimum value is 0x0. If set to max value LP_CLOCK is divided by
 * 32 and thus, producing 1ms "slots". If set to min value a "slot" is equal to ~30.5us.
 */
#define SMOTOR_SLOT_LP_CLK_DIVIDER    0x0



/*
 * Configure the RTC block to generate periodic events towards the PDC block.
 *
 * \param [in] period The period of the generated RTC events expressed in milliseconds.
 *                    The actual time interval is \p period * 10 ms
 *
 **/
void _rtc_init(uint16_t period);


/*
 * This function performs the following operations:
 *
 * 1) Initializes the motor controller
 * 2) Loads the configurations of all five Pattern Generators (PG)
 * 3) Enables/disables motor IRQs
 * 4) Cleans the commandFIFO of the motor controller
 * 5) Resets the index used for pointing to the next empty space within the Wave memory
 *
 **/
void _motor_init(void);



/* Initialize all the 64 entries of the commandFIFO with zeros */
void _motor_clear_commandFIFO(void);


/*
 * Push commands into the commandFIFO which consists of 64 entries 16 bits each.
 *
 * \param [in] commands  An array with the physical addresses of the commands that should be pushed into the commandFIFO
 *
 * \param [in] len       The number of commands that should be pushed into the commandFIFO
 *
 **/
void  _motor_push_commandFIFO(_motor_commandFIFO *commands[], uint8_t len);


/*
 * Read commadFIFO by its index. The FIFO consists of 64 entries. Valid values are 0-63.
 *
 * \param [in] index  A valid index within the commandFIFO.
 *
 * \param [out] The contents of the commadFIFO pointed by \p index.
 *
 **/
uint16_t _read_commandFIFO_by_index(uint8_t index);


/*
 * Add wave definitions into the Wave Table
 *
 * \param [in] waves  An array with the physical addresses of the waves that should be pushed into the Wave Table
 *
 * \param [in] len    The number of waveforms that should be pushed into the Wave Table
 *
 *
 * \param [out] waves_idx An array holding the index of each waveform pushed into the Wave Table. This index should
 *                        be used when pushing commands into the commandFIFO.
 *
 **/
void _motor_fill_wave_table(const uint8_t *waves[], uint8_t waves_idx[], uint8_t len);


#endif /* MOTOR_SAMPLE_CODE_H_ */
