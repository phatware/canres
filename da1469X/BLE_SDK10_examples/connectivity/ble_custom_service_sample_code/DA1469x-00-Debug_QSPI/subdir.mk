################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ble_peripheral_task.c \
../main.c 

CPP_SRCS += \
../checksum.cpp 

OBJS += \
./ble_peripheral_task.o \
./checksum.o \
./main.o 

C_DEPS += \
./ble_peripheral_task.d \
./main.d 

CPP_DEPS += \
./checksum.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config" -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/misc" -I"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/custom_service_framework/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/adapter/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/api/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/manager/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/services/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/stack/da14690/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/snc/src" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

checksum.o: ../checksum.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM Cross C++ Compiler'
	arm-none-eabi-g++ -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -std=gnu++11 -fabi-version=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"checksum.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


