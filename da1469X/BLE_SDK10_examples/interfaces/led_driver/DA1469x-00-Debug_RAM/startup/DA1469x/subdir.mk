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
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

startup/DA1469x/system_da1469x.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/system_da1469x.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


