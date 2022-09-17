################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/src/sdk_crc16.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/src/sdk_list.c \
/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/src/sdk_queue.c 

OBJS += \
./sdk/util/src/sdk_crc16.o \
./sdk/util/src/sdk_list.o \
./sdk/util/src/sdk_queue.o 

C_DEPS += \
./sdk/util/src/sdk_crc16.d \
./sdk/util/src/sdk_list.d \
./sdk/util/src/sdk_queue.d 


# Each subdirectory must supply rules for building sources it contributes
sdk/util/src/sdk_crc16.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/src/sdk_crc16.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/util/src/sdk_list.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/src/sdk_list.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/util/src/sdk_queue.o: /Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/src/sdk_queue.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


