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
#define dg_configUSE_LP_CLK                     (LP_CLK_32768)
#define dg_configCODE_LOCATION                  (NON_VOLATILE_IS_NONE)
#define dg_configFLASH_CONNECTED_TO             (FLASH_IS_NOT_CONNECTED)
#define dg_configUSE_WDOG                       (0)
#define dg_configUSE_SW_CURSOR                  (1)

#define CONFIG_RTT

/*************************************************************************************************\
 * FreeRTOS specific config
 */
#define OS_FREERTOS                             /* Use FreeRTOS */
#define configTOTAL_HEAP_SIZE                   (14000) /* FreeRTOS total Heap size */

/*************************************************************************************************\
 * Peripheral specific config
 */
#define dg_configRF_ENABLE_RECALIBRATION        (0)

#define dg_configFLASH_ADAPTER                  (0)
#define dg_configNVMS_ADAPTER                   (0)
#define dg_configNVMS_VES                       (0)
#define dg_configHAPTIC_ADAPTER                 (1)
#define dg_configUSE_HW_LRA                     (1)

/* Include bsp default values */
#include "bsp_defaults.h"
/* Include middleware default values */
#include "middleware_defaults.h"

#endif /* CUSTOM_CONFIG_RAM_H_ */