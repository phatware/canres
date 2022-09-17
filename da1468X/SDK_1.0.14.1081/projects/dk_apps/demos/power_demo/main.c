/**
 ****************************************************************************************
 *
 * @file main.c
 *
 * @brief Power Demo application
 *
 * Copyright (C) 2016-2018 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 ****************************************************************************************
 */
/* Standard includes. */
#include <string.h>
#include <stdbool.h>
#include "osal.h"
#include "resmgmt.h"
#include "ad_ble.h"
#include "ad_nvms.h"
#include "ble_mgr.h"
#include "cli.h"
#include "console.h"
#include "hw_wkup.h"
#include "sys_clock_mgr.h"
#include "sys_power_mgr.h"
#include "sys_watchdog.h"
#include "platform_devices.h"
#include "power_demo_settings.h"

#if (dg_configBLACK_ORCA_IC_REV != BLACK_ORCA_IC_REV_A)
/*
 * ## Known issue
 * For DA14682/3-00, DA15100/1-00 chip application is stoped on assert in 'rwble.c':
 * ASSERT_WARNING(ble_slp_delays_cnt < (BLE_MAX_DELAYS_ALLOWED + 1));
 * It is reproduced only on Release build.
 * Step to reproduce:
 * 1. connect cli console to terminal
 * 2. disconnect from terminal
 * 3. wait few seconds
 * */
#endif

/* Task priorities */
#define mainPOWER_DEMO_TASK_PRIORITY              ( OS_TASK_PRIORITY_NORMAL )

#if dg_configUSE_WDOG
INITIALISED_PRIVILEGED_DATA int8_t idle_task_wdog_id = -1;
#endif

/*
 * Perform any application specific hardware configuration.  The clocks,
 * memory, etc. are configured before main() is called.
 */
static void prvSetupHardware( void );
/*
 * Task functions .
 */
void power_demo_task(void *params);

/**
 * @brief System Initialization and creation of the BLE task
 */
static void system_init( void *pvParameters )
{
        OS_TASK handle;

        /* Prepare clocks. Note: cm_cpu_clk_set() and cm_sys_clk_set() can be called only from a
         * task since they will suspend the task until the XTAL16M has settled and, maybe, the PLL
         * is locked.
         */
        cm_sys_clk_init(sysclk_XTAL16M);
        cm_apb_set_clock_divider(apb_div1);
        cm_ahb_set_clock_divider(ahb_div1);
        cm_lp_clk_init();

        /*
         * Initialize platform watchdog
         */
        sys_watchdog_init();

#if dg_configUSE_WDOG
        // Register the Idle task first.
        idle_task_wdog_id = sys_watchdog_register(false);
        ASSERT_WARNING(idle_task_wdog_id != -1);
        sys_watchdog_configure_idle_id(idle_task_wdog_id);
#endif

        /* Set system clock */
        cm_sys_clk_set(sysclk_XTAL16M);

        /* Prepare the hardware to run this demo. */
        prvSetupHardware();

        /* init resources */
        resource_init();

        /* Set the desired sleep mode. */
        pm_set_wakeup_mode(true);
        pm_set_sleep_mode(pm_mode_extended_sleep);

        /* Initialize BLE Manager */
        ble_mgr_init();

        console_init();
        cli_init();

        /* Start the Power Demo application task. */
        OS_TASK_CREATE("Power Demo",                    /* The text name assigned to the task, for
                                                           debug only; not used by the kernel. */
                       power_demo_task,                 /* The function that implements the task. */
                       NULL,                            /* The parameter passed to the task. */
                       768,                             /* The number of bytes to allocate to the
                                                           stack of the task. */
                       mainPOWER_DEMO_TASK_PRIORITY,    /* The priority assigned to the task. */
                       handle);                         /* The task handle. */
        OS_ASSERT(handle);

        /* SysInit task is no longer needed */
        OS_TASK_DELETE(OS_GET_CURRENT_TASK());
}
/*-----------------------------------------------------------*/

/**
 * @brief Basic initialization and creation of the system initialization task.
 */
int main( void )
{
        OS_TASK handle;
        OS_BASE_TYPE status;

        cm_clk_init_low_level();                            /* Basic clock initializations. */

        /* Start SysInit task. */
        status = OS_TASK_CREATE("SysInit",                /* The text name assigned to the task, for
                                                             debug only; not used by the kernel. */
                                system_init,              /* The System Initialization task. */
                                ( void * ) 0,             /* The parameter passed to the task. */
                                1024,                     /* The number of bytes to allocate to the
                                                             stack of the task. */
                                OS_TASK_PRIORITY_HIGHEST, /* The priority assigned to the task. */
                                handle );                 /* The task handle */
        OS_ASSERT(status == OS_TASK_CREATE_SUCCESS);

        /* Start the tasks and timer running. */
        vTaskStartScheduler();

        /* If all is well, the scheduler will now be running, and the following
           line will never be reached.  If the following line does execute, then
           there was insufficient FreeRTOS heap memory available for the idle and/or
           timer tasks     to be created.  See the memory management section on the
           FreeRTOS web site for more details. */
        for( ;; );
}

#if POWER_DEMO_GPIO_CONFIGURATION
void button_trigger_cb(void);
#endif

void wkup_cb(void)
{
        hw_wkup_reset_interrupt();
#if POWER_DEMO_GPIO_CONFIGURATION
        if (!hw_gpio_get_pin_status(CFG_BUTTON_TRIGGER_GPIO_PORT, CFG_BUTTON_TRIGGER_GPIO_PIN)) {
                button_trigger_cb();
        }
#endif
}


static void periph_init(void)
{
#if POWER_DEMO_CLI_CONFIGURATION
                hw_gpio_set_pin_function(HW_GPIO_PORT_1, HW_GPIO_PIN_3, HW_GPIO_MODE_OUTPUT,
                                                                        HW_GPIO_FUNC_UART2_TX);
                hw_gpio_set_pin_function(HW_GPIO_PORT_2, HW_GPIO_PIN_3, HW_GPIO_MODE_OUTPUT,
                                                                        HW_GPIO_FUNC_UART2_RX);
                /* Configure UART CTS gpio port and pin */
                hw_gpio_configure_pin(HW_GPIO_PORT_1, HW_GPIO_PIN_6, HW_GPIO_MODE_INPUT_PULLUP,
                                                                HW_GPIO_FUNC_UART2_CTSN, 1);
#endif
#if POWER_DEMO_GPIO_CONFIGURATION
        hw_gpio_configure_pin(CFG_BUTTON_TRIGGER_GPIO_PORT, CFG_BUTTON_TRIGGER_GPIO_PIN,
                                                HW_GPIO_MODE_INPUT_PULLUP, HW_GPIO_FUNC_GPIO, 1);

        init_gpios();
#endif
}

static void init_wkup(void)
{
        hw_wkup_init(NULL);
#if POWER_DEMO_GPIO_CONFIGURATION
        hw_wkup_configure_pin(CFG_BUTTON_TRIGGER_GPIO_PORT, CFG_BUTTON_TRIGGER_GPIO_PIN, true,
                                                                         HW_WKUP_PIN_STATE_LOW);
        hw_wkup_set_debounce_time(10);
#endif
#if  dg_configBLACK_ORCA_IC_REV == BLACK_ORCA_IC_REV_A
        hw_wkup_set_counter_threshold(1);
#endif
        hw_wkup_register_interrupt(wkup_cb, 1);
}

static void prvSetupHardware( void )
{
        /* Init hardware */
        pm_system_init(periph_init);
        init_wkup();
}

/**
 * @brief Malloc fail hook
 */
void vApplicationMallocFailedHook( void )
{
        /* vApplicationMallocFailedHook() will only be called if
           configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
           function that will get called if a call to pvPortMalloc() fails.
           pvPortMalloc() is called internally by the kernel whenever a task, queue,
           timer or semaphore is created.  It is also called by various parts of the
           demo application.  If heap_1.c or heap_2.c are used, then the size of the
           heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
           FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
           to query the size of free heap space that remains (although it does not
           provide information on how the remaining heap might be fragmented). */
        taskDISABLE_INTERRUPTS();
        for( ;; );
}

/**
 * @brief Application idle task hook
 */
void vApplicationIdleHook( void )
{
        /* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
           to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
           task. It is essential that code added to this hook function never attempts
           to block in any way (for example, call xQueueReceive() with a block time
           specified, or call vTaskDelay()).  If the application makes use of the
           vTaskDelete() API function (as this demo application does) then it is also
           important that vApplicationIdleHook() is permitted to return to its calling
           function, because it is the responsibility of the idle task to clean up
           memory allocated by the kernel to any task that has since been deleted. */

#if dg_configUSE_WDOG
        sys_watchdog_notify(idle_task_wdog_id);
#endif
}

/**
 * @brief Application stack overflow hook
 */
void vApplicationStackOverflowHook( OS_TASK pxTask, char *pcTaskName )
{
        ( void ) pcTaskName;
        ( void ) pxTask;

        /* Run time stack overflow checking is performed if
           configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
           function is called if a stack overflow is detected. */
        taskDISABLE_INTERRUPTS();
        for( ;; );
}

/**
 * @brief Application tick hook
 */
void vApplicationTickHook( void )
{

        OS_POISON_AREA_CHECK( OS_POISON_ON_ERROR_HALT, result );

}

