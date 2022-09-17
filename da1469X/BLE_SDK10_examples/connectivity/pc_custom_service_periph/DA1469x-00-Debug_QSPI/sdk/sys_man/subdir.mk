################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_adc.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_audio_mgr.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_bsr.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_charger_da1469x.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_clock_mgr_da1469x.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_power_mgr_da1469x.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_rcx_calibrate.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_tcs_da1469x.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_timer.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_trng.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_usb_da1469x.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_watchdog.c 

OBJS += \
./sdk/sys_man/sys_adc.o \
./sdk/sys_man/sys_audio_mgr.o \
./sdk/sys_man/sys_bsr.o \
./sdk/sys_man/sys_charger_da1469x.o \
./sdk/sys_man/sys_clock_mgr_da1469x.o \
./sdk/sys_man/sys_power_mgr_da1469x.o \
./sdk/sys_man/sys_rcx_calibrate.o \
./sdk/sys_man/sys_tcs_da1469x.o \
./sdk/sys_man/sys_timer.o \
./sdk/sys_man/sys_trng.o \
./sdk/sys_man/sys_usb_da1469x.o \
./sdk/sys_man/sys_watchdog.o 

C_DEPS += \
./sdk/sys_man/sys_adc.d \
./sdk/sys_man/sys_audio_mgr.d \
./sdk/sys_man/sys_bsr.d \
./sdk/sys_man/sys_charger_da1469x.d \
./sdk/sys_man/sys_clock_mgr_da1469x.d \
./sdk/sys_man/sys_power_mgr_da1469x.d \
./sdk/sys_man/sys_rcx_calibrate.d \
./sdk/sys_man/sys_tcs_da1469x.d \
./sdk/sys_man/sys_timer.d \
./sdk/sys_man/sys_trng.d \
./sdk/sys_man/sys_usb_da1469x.d \
./sdk/sys_man/sys_watchdog.d 


# Each subdirectory must supply rules for building sources it contributes
sdk/sys_man/sys_adc.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_adc.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_audio_mgr.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_audio_mgr.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_bsr.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_bsr.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_charger_da1469x.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_charger_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_clock_mgr_da1469x.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_clock_mgr_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_power_mgr_da1469x.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_power_mgr_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_rcx_calibrate.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_rcx_calibrate.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_tcs_da1469x.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_tcs_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_timer.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_timer.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_trng.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_trng.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_usb_da1469x.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_usb_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/sys_man/sys_watchdog.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/sys_watchdog.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

