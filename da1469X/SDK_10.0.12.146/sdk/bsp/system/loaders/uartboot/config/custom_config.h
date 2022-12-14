/**
 ****************************************************************************************
 *
 * @file custom_config.h
 *
 * @brief Custom configuration file for non-FreeRTOS applications executing from RAM.
 *
 * Copyright (C) 2015-2022 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */

#ifndef CUSTOM_CONFIG_RAM_H_
#define CUSTOM_CONFIG_RAM_H_

#include "bsp_definitions.h"

#define OS_BAREMETAL

#define __HEAP_SIZE                             0x2000

#define dg_configUSE_LP_CLK                     ( LP_CLK_32768 )
#define dg_configCODE_LOCATION                  NON_VOLATILE_IS_NONE

#define dg_configMEM_RETENTION_MODE             (0x1F)
#define dg_configSHUFFLING_MODE                 (0x3)

#define dg_configUSE_WDOG                       (0)
#define dg_configUSE_BOD                        (0)

#define dg_configUSE_DCDC                       (1)

#define dg_configFLASH_CONNECTED_TO             (FLASH_CONNECTED_TO_1V8)
#define dg_configFLASH_POWER_DOWN               (0)
#define dg_configFLASH_AUTODETECT               (1)

#define dg_configPOWER_1V8_ACTIVE               (1)
#define dg_configPOWER_1V8_SLEEP                (1)


#define dg_configUSE_SW_CURSOR                  (1)

#define dg_configPOWER_1V8P                     (1)

#define dg_configDISABLE_BACKGROUND_FLASH_OPS   (1)

#define dg_configCRYPTO_ADAPTER                 (0)

#define dg_configUSE_HW_WKUP                    (0)
#define dg_configUSE_HW_QSPI2                   (0)

#define dg_configSUPPRESS_HelloMsg              (0)

#define dg_configVERIFY_QSPI_WRITE              (1)
#define dg_configFLASH_CONFIG_VERIFY            (1)

#define dg_configFLASH_ADAPTER                  (1)
#define dg_configNVMS_ADAPTER                   (1)
#define dg_configNVMS_VES                       (1)
#define CONFIG_PARTITION_TABLE_CREATE           (0)
#define dg_configUSE_SYS_TCS                    (1)

#define dg_configUSE_HW_TIMER                   (1)

#include "bsp_defaults.h"
/* Include middleware default values */
#include "middleware_defaults.h"

#endif /* CUSTOM_CONFIG_RAM_H_ */
