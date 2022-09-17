/**
\addtogroup BSP
\{
\addtogroup CONFIG
\{
\addtogroup CUSTOM
\{
*/

/**
 ****************************************************************************************
 *
 * @file custom_config_qspi.h
 *
 * @brief Board Support Package. User Configuration file for cached QSPI mode.
 *
 * Copyright (C) 2016-2017 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */

#ifndef CUSTOM_CONFIG_QSPI_H_
#define CUSTOM_CONFIG_QSPI_H_

#include "bsp_definitions.h"
#include "power_demo_config.h"

#ifndef POWER_DEMO_CLI_CONFIGURATION
        #define POWER_DEMO_CLI_CONFIGURATION    0
#endif

#ifndef POWER_DEMO_GPIO_CONFIGURATION
        #define POWER_DEMO_GPIO_CONFIGURATION   0
#endif

#define CONFIG_USE_BLE
#undef CONFIG_USE_FTDF

#define CONFIG_RETARGET
#define CONFIG_RETARGET_UART                    HW_UART2

#define dg_configUSE_LP_CLK                     LP_CLK_32768
#define dg_configEXEC_MODE                      MODE_IS_CACHED
#define dg_configCODE_LOCATION                  NON_VOLATILE_IS_FLASH
#define dg_configEXT_CRYSTAL_FREQ               EXT_CRYSTAL_IS_16M

#define dg_configIMAGE_SETUP                    DEVELOPMENT_MODE
#define dg_configEMULATE_OTP_COPY               (0)

#define dg_configUSER_CAN_USE_TIMER1            (0)

#define dg_configOPTIMAL_RETRAM                 (1)

#if (dg_configOPTIMAL_RETRAM == 1)
        #if (dg_configBLACK_ORCA_IC_REV == BLACK_ORCA_IC_REV_A)
                #define dg_configMEM_RETENTION_MODE             (0x1B)
                #define dg_configSHUFFLING_MODE                 (0x1)
        #else
                #define dg_configMEM_RETENTION_MODE             (0x07)
                #define dg_configSHUFFLING_MODE                 (0x3)
        #endif
#endif

#define dg_configUSE_WDOG                       (1)

#define dg_configPM_MAX_ADAPTERS_CNT            (6)

#define dg_configFLASH_CONNECTED_TO             (FLASH_CONNECTED_TO_1V8)
#define dg_configFLASH_POWER_DOWN               (0)

#define dg_configPOWER_1V8_ACTIVE               (1)
#define dg_configPOWER_1V8_SLEEP                (1)

#define dg_configBATTERY_TYPE                   (BATTERY_TYPE_LIMN2O4)
#define dg_configBATTERY_CHARGE_CURRENT         2       // 30mA
#define dg_configBATTERY_PRECHARGE_CURRENT      20      // 2.1mA
#define dg_configBATTERY_CHARGE_NTC             1       // disabled

#define dg_configUSE_USB                        0
#define dg_configUSE_USB_CHARGER                0
#define dg_configALLOW_CHARGING_NOT_ENUM        1

#define dg_configUSE_ProDK                      (1)

#define dg_configUSE_SW_CURSOR                  (1)

#define dg_configCACHEABLE_QSPI_AREA_LEN        (NVMS_PARAM_PART_start - MEMORY_QSPIF_BASE)


/*************************************************************************************************\
 * FreeRTOS specific config
 */
#define OS_FREERTOS                              /* Define this to use FreeRTOS */
#define configTOTAL_HEAP_SIZE                    13312   /* This is the FreeRTOS Total Heap Size */

/*************************************************************************************************\
 * Memory layout specific config
 */
#define dg_configQSPI_CACHED_OPTIMAL_RETRAM_0_SIZE_AE   ( 64 * 1024)
#define dg_configQSPI_CACHED_RAM_SIZE_AE                ( 32 * 1024)
#define dg_configQSPI_CACHED_RETRAM_0_SIZE_AE           ( 96 * 1024)

/*************************************************************************************************\
 * Peripheral specific config
 */
#define dg_configFLASH_ADAPTER                  1
#define dg_configNVMS_ADAPTER                   1
#define dg_configGPADC_ADAPTER                  1
#define dg_configUART_ADAPTER                   1
#define dg_configUSE_CLI                        1
#define dg_configUSE_CONSOLE                    1

/*************************************************************************************************\
 * BLE device config
 */
#define dg_configBLE_CENTRAL                    (0)
#define dg_configBLE_GATT_CLIENT                (0)
#define dg_configBLE_OBSERVER                   (0)
#define dg_configBLE_BROADCASTER                (0)
#define dg_configBLE_L2CAP_COC                  (0)

#if !POWER_DEMO_CLI_CONFIGURATION
        #define dg_configUSE_CLI_STUBS          1
        #define dg_configUSE_CONSOLE_STUBS      1
#endif

/* Include bsp default values */
#include "bsp_defaults.h"
/* Include memory layout */
#include "bsp_memory_layout.h"

#endif /* CUSTOM_CONFIG_QSPI_H_ */

/**
\}
\}
\}
*/
