################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/deepsleep.S \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/exception_handlers.S \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/startup_da1469x.S \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/vector_table_da1469x.S 

OBJS += \
./startup/DA1469x/GCC/deepsleep.o \
./startup/DA1469x/GCC/exception_handlers.o \
./startup/DA1469x/GCC/startup_da1469x.o \
./startup/DA1469x/GCC/vector_table_da1469x.o 

S_UPPER_DEPS += \
./startup/DA1469x/GCC/deepsleep.d \
./startup/DA1469x/GCC/exception_handlers.d \
./startup/DA1469x/GCC/startup_da1469x.d \
./startup/DA1469x/GCC/vector_table_da1469x.d 


# Each subdirectory must supply rules for building sources it contributes
startup/DA1469x/GCC/deepsleep.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/deepsleep.S
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM GNU Assembler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -x assembler-with-cpp -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config/custom_config_qspi.h" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

startup/DA1469x/GCC/exception_handlers.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/exception_handlers.S
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM GNU Assembler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -x assembler-with-cpp -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config/custom_config_qspi.h" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

startup/DA1469x/GCC/startup_da1469x.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/startup_da1469x.S
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM GNU Assembler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -x assembler-with-cpp -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config/custom_config_qspi.h" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

startup/DA1469x/GCC/vector_table_da1469x.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/startup/DA1469x/GCC/vector_table_da1469x.S
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM GNU Assembler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -Wno-cpp  -g3 -x assembler-with-cpp -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/connectivity/ble_custom_service_sample_code/config/custom_config_qspi.h" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


