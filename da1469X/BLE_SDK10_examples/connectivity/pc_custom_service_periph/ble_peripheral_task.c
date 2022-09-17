/**
 ****************************************************************************************
 *
 * @file ble_peripheral_task.c
 *
 * @brief BLE peripheral task
 *
 * Copyright (C) 2015-2019 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
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

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "user_power_measurement_configurations.h"

#include "osal.h"
#include "time.h"
#include "sys_watchdog.h"
#include "ble_att.h"
#include "ble_common.h"
#include "ble_gap.h"
#include "ble_gatts.h"
#include "ble_service.h"
#include "ble_uuid.h"

/* Required libraries for the target application */
#include "ble_custom_service.h"
#include "sys_power_mgr.h"

/*
 * Array used for holding the value of the Characteristic Attribute registered
 * in Dialog BLE database.
 */
__RETAINED_RW uint8_t _characteristic_attr_val[USER_CHARACTERISTIC_VALUE_SIZE] = { 0 };

/*
 * Notification bits reservation
 * bit #0 is always assigned to BLE event queue notification
 */

#if(USER_AUTO_UPDATE_AND_NOTIFY_EN == 1)
/*
 * Notify Bit for changing characteristic value in order to notify peers without receiving a read request.
 */
#define VALUE_CHANGE_NOTIF                          (1<<3)

/*
 * Timer for notification events.
 */
__RETAINED OS_TIMER val_change_timer;
#endif

/*
 * BLE peripheral advertising data(max 26 characters)
 */
static const uint8_t adv_data[] = {
        USER_ADV_SIZE, GAP_DATA_TYPE_LOCAL_NAME,
        USER_ADV_DATA_CHARS
};

/* Task handle */
__RETAINED_RW static OS_TASK ble_task_handle = NULL;


#if(USER_AUTO_UPDATE_AND_NOTIFY_EN == 1)
/*
 * val_change_timer callback
 */
static void val_change_timer_cb(OS_TIMER xTimer)
{
        OS_TASK_NOTIFY(ble_task_handle,VALUE_CHANGE_NOTIF,eSetBits);
}
#endif

/*
 * @brief Read request callback
 *
 * This callback is fired when a peer device issues a read request. This implies that
 * that the peer device wants to read the Characteristic Attribute value. User should
 * provide the requested data.
 *
 * \param [in] value: The value returned back to the peer device
 *
 * \param [in] length: The number of bytes/octets returned
 *
 *
 * \warning: The callback function should have that specific prototype
 *
 * \warning: The BLE stack will not proceed with the next BLE event until the
 *        callback returns.
 */
void get_var_value_cb(uint8_t **value, uint16_t *length)
{

        /* Return the requested data back to the peer device */
        *value  = _characteristic_attr_val;       // A pointer that points to the returned data
        *length = USER_CHARACTERISTIC_VALUE_SIZE;  // The size of the returned data, expressed in bytes.

        /*
         * This is just for debugging/demonstration purposes. UART is a slow interface
         * and will add significant delays compared to BLE speeds.
         */
#if (!USER_SUPPRESS_LOGS_EN)
        printf("\nRead callback function hit! - Returned value: %s\n\r", (char *)_characteristic_attr_val);
#endif
}


/*
 *
 * @brief Write request callback
 *
 * This callback is fired when a peer device issues a write request. This implies that
 * the peer device requested to modify the Characteristic Attribute value.
 *
 * \param [out] value:  The value written by the peer device.
 *
 * \param [out] length: The length of the written value, expressed in bytes/octets.
 *
 *
 * \warning: The callback function should have that specific prototype
 *
 * \warning: The BLE stack will not proceed with the next BLE event until the
 *        callback returns.
 *
 */
void set_var_value_cb(const uint8_t *value, uint16_t length)
{
        /* Clear the current Characteristic Attribute value */
        memset((void *)_characteristic_attr_val, 0x20, sizeof(_characteristic_attr_val));

        /* Update the Characteristic Attribute value as requested by the peer device */
        memcpy((void *)_characteristic_attr_val, (void *)value, length);

        /*
         * This is just for debugging/demonstration purposes. UART is a slow interface
         * and will add significant delays compared to BLE speeds.
         */
#if (!USER_SUPPRESS_LOGS_EN)
        printf("\nWrite callback function hit! - Written value: %s, length: %d\n\r",
                                                        _characteristic_attr_val, length);
#endif
}

/*
 * @brief Notification event callback
 *
 *  A notification callback function is fired for each connected device.
 *  It's a prerequisite that peer devices will have their notifications/
 *  indications enabled.
 *
 * \param [in] conn_idx: Connection index
 *
 * \param [in] status: The status of the aforementioned operation:
 *
 *                     0 --> notification/indication wasn't sent successfully
 *                     1 --> notification/indication was sent successfully
 *
 * \param [in] type: Signifies whether a notification or indication has been sent
 *                   to the peer device:
 *
 *                   0 --> when a notification is sent
 *                   1 --> when an indications is sent
 *
 *
 * \warning: The BLE stack will not proceed with the next BLE event until the
 *        callback returns.
 */
void event_sent_cb(uint16_t conn_idx, bool status, gatt_event_t type)
{
        /*
         * This is just for debugging/demonstration purposes. UART is a slow interface
         * and will add significant delay compared to the BLE speeds.
         */
#if (!USER_SUPPRESS_LOGS_EN)
        printf("\nNotify callback - Connection idx: %d, Status: %d, Type: %d\n\r",
                                                                conn_idx, status, type);
#endif
}

/*
 * Main code
 */
static void handle_evt_gap_connected(ble_evt_gap_connected_t *evt)
{
        /*
         * Manage connection information
         */
}

static void handle_evt_gap_disconnected(ble_evt_gap_disconnected_t *evt)
{
        // restart advertising so we can connect again
        ble_gap_adv_start(GAP_CONN_MODE_UNDIRECTED);
}

static void handle_evt_gap_adv_completed(ble_evt_gap_adv_completed_t *evt)
{

}

void ble_peripheral_task(void *params)
{
        int8_t wdog_id;
        ble_service_t *svc;

#if (USER_AUTO_UPDATE_AND_NOTIFY_EN == 1)
        uint8_t notif_msg[]={'A', ' ', 's' ,'t', 'r', 'i', 'n', 'g', ' ', 'o', 'f', ' ', '2', '0', ' ', 'c', 'h', 'a', 'r', '$'};

        uint16_t msg_size = sizeof(notif_msg);
#endif

        printf("\n*** Custom BLE Service Demonstration ***\n\n\r");

        // in case services which do not use svc are all disabled, just suppress -Wunused-variable
        (void) svc;

        /* register ble_peripheral task to be monitored by watchdog */
        wdog_id = sys_watchdog_register(false);

        /* Get task's handler */
        ble_task_handle = OS_GET_CURRENT_TASK();

        srand(time(NULL));

        ble_peripheral_start();
        ble_register_app();

        ble_gap_device_name_set("Custom BLE Service", ATT_PERM_READ);

        uint16_t mtu_size;
        ble_error_t mtu_err;

        /*
         * Get the old MTU size and print it on the serial console.
         */
        mtu_err = ble_gap_mtu_size_get(&mtu_size);
        printf("Old MTU size: %d, Status: %d\n\r", mtu_size, mtu_err);

        /*
         * @brief Change the MTU size.
         *
         * \note: The maximum supported MTU size is 512 octets.  The minimum supported MTU size,
         *        as defined by Bluetooth SIG, is 65 octets when LE secure connections are used,
         *        23 otherwise.
         *
         * \warning: The MTU size change should take place prior to creating the BLE attribute database.
         *           Otherwise, any already defined attribute database will be deleted!!!
         */
        mtu_err = ble_gap_mtu_size_set(USER_MTU);

        /*
         * Get the updated MTU size and print it on the serial console.
         */
        mtu_err = ble_gap_mtu_size_get(&mtu_size);
        printf("New MTU size: %d, Status: %d\n\r", mtu_size, mtu_err);

        //************ Characteristic declarations for the 1st custom BLE Service  *************
        const mcs_characteristic_config_t custom_service_1[] = {

                /* Initialized Characteristic Attribute */
                CHARACTERISTIC_DECLARATION(11111111-0000-0000-0000-000000000001, USER_CHARACTERISTIC_VALUE_SIZE,
                        CHAR_WRITE_NO_RESP_PROP_EN, CHAR_WRITE_PROP_EN, CHAR_READ_PROP_EN, CHAR_NOTIF_NOTIF_EN,
                        Initialized Characteristic, get_var_value_cb, set_var_value_cb, event_sent_cb),

                 // -----------------------------------------------------------------
                 // -- Here you can continue adding more Characteristic Attributes --
                 // -----------------------------------------------------------------
        };
        // ***************** Register the Bluetooth Service in Dialog BLE framework *****************
        SERVICE_DECLARATION(custom_service_1, 11111111-0000-0000-0000-111111111111)

        ble_gap_adv_intv_set(BLE_ADV_INTERVAL_FROM_MS(USER_MIN_ADV_INTV_MS),BLE_ADV_INTERVAL_FROM_MS(USER_MAX_ADV_INTV_MS));
        ble_gap_adv_data_set(sizeof(adv_data), adv_data, 0, NULL);

        if (USER_SLEEP_MODE != (pm_mode_deep_sleep))
        {
                ble_gap_adv_start(USER_ADV_TYPE);

#if(USER_AUTO_UPDATE_AND_NOTIFY_EN == 1)
                val_change_timer= OS_TIMER_CREATE("val_change", OS_MS_2_TICKS(USER_VALUE_AUTO_UPDATE_INTV),
                        OS_TIMER_SUCCESS, (void *)OS_GET_CURRENT_TASK(),
                        val_change_timer_cb);

                OS_TIMER_START(val_change_timer,OS_TIMER_FOREVER);
#endif
        }

        for (;;)
        {
                OS_BASE_TYPE ret;
                uint32_t notif;


                /* notify watchdog on each loop */
                sys_watchdog_notify(wdog_id);

                /* suspend watchdog while blocking on OS_TASK_NOTIFY_WAIT() */
                sys_watchdog_suspend(wdog_id);

                /*
                 * Wait on any of the notification bits, then clear them all
                 */
                ret = OS_TASK_NOTIFY_WAIT(0, OS_TASK_NOTIFY_ALL_BITS, &notif, OS_TASK_NOTIFY_FOREVER);
                /* Blocks forever waiting for task notification. The return value must be OS_OK */
                OS_ASSERT(ret == OS_OK);

                /* resume watchdog */
                sys_watchdog_notify_and_resume(wdog_id);

                /* notified from BLE manager, can get event */
                if (notif & BLE_APP_NOTIFY_MASK)
                {
                        ble_evt_hdr_t *hdr;

                        hdr = ble_get_event(false);
                        if (!hdr)
                        {
                                goto no_event;
                        }

                        if (ble_service_handle_event(hdr))
                        {
                                goto handled;
                        }

                        switch (hdr->evt_code)
                        {
                        case BLE_EVT_GAP_CONNECTED:
                                handle_evt_gap_connected((ble_evt_gap_connected_t *) hdr);
                                break;
                        case BLE_EVT_GAP_ADV_COMPLETED:
                                handle_evt_gap_adv_completed((ble_evt_gap_adv_completed_t *) hdr);
                                break;
                        case BLE_EVT_GAP_DISCONNECTED:
                                handle_evt_gap_disconnected((ble_evt_gap_disconnected_t *) hdr);
                                break;
                        case BLE_EVT_GAP_PAIR_REQ:
                        {
                                ble_evt_gap_pair_req_t *evt = (ble_evt_gap_pair_req_t *) hdr;
                                ble_gap_pair_reply(evt->conn_idx, true, evt->bond);
                                break;
                        }
                        default:
                                ble_handle_event_default(hdr);
                                break;
                        }

handled:
                        OS_FREE(hdr);

no_event:
                        // notify again if there are more events to process in queue
                        if (ble_has_event())
                        {
                                OS_TASK_NOTIFY(OS_GET_CURRENT_TASK(), BLE_APP_NOTIFY_MASK, eSetBits);
                        }
                }

#if (USER_AUTO_UPDATE_AND_NOTIFY_EN == 1)
                if (notif & VALUE_CHANGE_NOTIF)
                {
                        set_var_value_cb(notif_msg, msg_size);

                        mcs_auto_notify_all(msg_size, notif_msg , 0x0b, 0x0d);
#if(!USER_SUPPRESS_LOGS_EN)
                        printf("Value Change Notifications sent. Size:%d Msg Address:0X%lX\r\n\n", msg_size, (uint32_t)notif_msg);
#endif
                }
#endif


        }
}
