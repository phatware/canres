################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/init_da1469x.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/system_da1469x.c 

OBJS += \
./startup/DA1469x/init_da1469x.o \
./startup/DA1469x/system_da1469x.o 

C_DEPS += \
./startup/DA1469x/init_da1469x.d \
./startup/DA1469x/system_da1469x.d 


# Each subdirectory must supply rules for building sources it contributes
startup/DA1469x/init_da1469x.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/init_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config" -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/misc" -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/custom_service_framework/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

startup/DA1469x/system_da1469x.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/system_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config" -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/misc" -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/custom_service_framework/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


