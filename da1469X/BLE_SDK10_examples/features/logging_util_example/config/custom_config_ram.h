/**
 ****************************************************************************************
 *
 * @file custom_config_ram.h
 *
 * @brief Board Support Package. User Configuration file for execution from RAM.
 *
 * Copyright (C) 2015-2019 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */

#ifndef CUSTOM_CONFIG_RAM_H_
#define CUSTOM_CONFIG_RAM_H_

#include "bsp_definitions.h"

/*************************************************************************************************\
 * System configuration
 */

#define dg_configUSE_LP_CLK                     ( LP_CLK_32768 )
#define dg_configCODE_LOCATION                  NON_VOLATILE_IS_NONE

#define dg_configUSE_WDOG                       (1)

#define dg_configFLASH_CONNECTED_TO             ( FLASH_CONNECTED_TO_1V8 )
#define dg_configFLASH_POWER_DOWN               ( 0 )
#define dg_configPOWER_1V8_ACTIVE               ( 1 )
#define dg_configPOWER_1V8_SLEEP                ( 1 )
#define dg_configPOWER_1V8P                     ( 1 )

#define CONFIG_USE_BLE

#define dg_configUSE_SW_CURSOR                  (1)

#define dg_configWDOG_MAX_TASKS_CNT             (10)

/*************************************************************************************************\
 * FreeRTOS specific config
 */
#define OS_FREERTOS                              /* Define this to use FreeRTOS */
#define configTOTAL_HEAP_SIZE                    40000   /* This is the FreeRTOS Total Heap Size */

/*************************************************************************************************\
 * Peripheral specific config
 */

#define dg_configRF_ENABLE_RECALIBRATION        (0)

#define dg_configFLASH_ADAPTER                  ( 1 )
#define dg_configNVMS_ADAPTER                   ( 1 )
#define dg_configNVMS_VES                       ( 1 )
#define dg_configNVPARAM_ADAPTER                ( 0 )

/*************************************************************************************************\
 * Logging configuration
 */
#define LOGGING_ACTIVE                          ( 1 )

#if  LOGGING_ACTIVE == 1
/* Set one of the following logging modes
 * LOGGING_MODE_STANDALONE
 * LOGGING_MODE_QUEUE
 * LOGGING_MODE_RETARGET
 * LOGGING_MODE_RTT
 */
#define LOGGING_MODE_QUEUE

#ifdef LOGGING_MODE_QUEUE
#define CONFIG_USE_BLE_SERVICES
#endif

#ifdef LOGGING_MODE_RETARGET
#define CONFIG_RETARGET
#endif

#ifdef LOGGING_MODE_RTT
#define CONFIG_RTT
#endif

#ifdef LOGGING_MODE_STANDALONE
#define LOGGING_STANDALONE_GPIO_PORT_UART_TX    (HW_GPIO_PORT_0)
#define LOGGING_STANDALONE_GPIO_PIN_UART_TX     (HW_GPIO_PIN_9)
#define LOGGING_STANDALONE_GPIO_PORT_UART_RX    (HW_GPIO_PORT_0)
#define LOGGING_STANDALONE_GPIO_PIN_UART_RX     (HW_GPIO_PIN_8)
#endif

#define LOGGING_MIN_COMPILED_SEVERITY           LOG_DEBUG       // Logs with a severity less than this will not be compiled in
#define LOGGING_MIN_DEFAULT_SEVERITY            LOG_WARNING     // This is the default minimum severity level (if not changed in runtime using

#define LOGGING_MIN_MSG_SIZE                    100
#define LOGGING_QUEUE_LENGTH                    12              // The amount of messages that will be pushed into the queue before discarding additional messages
#endif

/* Include bsp default values */
#include "bsp_defaults.h"
/* Include middleware default values */
#include "middleware_defaults.h"

#endif /* CUSTOM_CONFIG_RAM_H_ */
