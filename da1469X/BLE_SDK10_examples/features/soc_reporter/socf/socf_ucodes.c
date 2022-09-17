/**
 ****************************************************************************************
 *
 * @file socf_ucodes.c
 *
 * @brief SOC function
 *
 * Copyright (C) 2015-2019 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */

#include "socf_config.h"

#if (SOCF_USE_SNC == 1)

#include "SeNIS.h"
#include "snc_queues.h"
#include "socf_ucodes.h"
#include "snc_hw_gpadc.h"
#include "platform_devices.h"

_SNC_RETAINED static uint32_t socf_num_of_samples = 0;
_SNC_RETAINED static uint32_t *writeQp;
_SNC_RETAINED static uint32_t socf_notify_samples;
_SNC_RETAINED static uint32_t queue_is_full;

SNC_UCODE_BLOCK_DEF(ucode_socf_collect_samples_queue)
{
        // Clear the RTC PDC event
        SNC_hw_sys_clear_rtc_pdc_event();

        SENIS_assign(da(&queue_is_full), 0);
        SNC_queues_snc_wq_is_full(da(&queue_is_full));
        SENIS_if (da(&queue_is_full), EQ, 1) {
                SNC_CM33_NOTIFY();
                SENIS_return;
        }

        SNC_queues_snc_get_wq(da(&writeQp), SOCF_SNC_GPADC_QUEUE_CHUNK_SIZE, 0);

        // Initialize - Acquire the selected GPADC source device
        SNC_gpadc_open(&BATTERY_LEVEL_GP);

        // Get adc measurement
        SNC_gpadc_read(&BATTERY_LEVEL_GP,ia(&writeQp));

        // De-initialize - Release the GPADC
        SNC_gpadc_close(&BATTERY_LEVEL_GP);

        // Push the recently acquired data into the SNC queue
        SNC_queues_snc_push();

        // ++num_of_samples;
        SENIS_inc1(da(&socf_num_of_samples));

        // If GPADC have been collected
        SENIS_if (da(&socf_num_of_samples), EQ, da(&socf_notify_samples)) {
                // Set the number of samples to 0
                SENIS_assign(da(&socf_num_of_samples), 0);

                // Notify CM33 that collecting the desired amount of samples has finished
                SNC_CM33_NOTIFY();
        }

}

void ucode_socf_set_notify_samples(uint32_t notify_samples)
{
        socf_notify_samples =  notify_samples;
}
#endif
