################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_crypto.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_flash.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_gpadc.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_haptic.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_i2c.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_iso7816.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_keyboard_scanner.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_lcdc.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvms.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvms_direct.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvms_ves.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvparam.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_pmu.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_sdadc.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_snc.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_spi.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_template.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_uart.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/sys_platform_devices_internal.c 

OBJS += \
./sdk/adapters/src/ad_crypto.o \
./sdk/adapters/src/ad_flash.o \
./sdk/adapters/src/ad_gpadc.o \
./sdk/adapters/src/ad_haptic.o \
./sdk/adapters/src/ad_i2c.o \
./sdk/adapters/src/ad_iso7816.o \
./sdk/adapters/src/ad_keyboard_scanner.o \
./sdk/adapters/src/ad_lcdc.o \
./sdk/adapters/src/ad_nvms.o \
./sdk/adapters/src/ad_nvms_direct.o \
./sdk/adapters/src/ad_nvms_ves.o \
./sdk/adapters/src/ad_nvparam.o \
./sdk/adapters/src/ad_pmu.o \
./sdk/adapters/src/ad_sdadc.o \
./sdk/adapters/src/ad_snc.o \
./sdk/adapters/src/ad_spi.o \
./sdk/adapters/src/ad_template.o \
./sdk/adapters/src/ad_uart.o \
./sdk/adapters/src/sys_platform_devices_internal.o 

C_DEPS += \
./sdk/adapters/src/ad_crypto.d \
./sdk/adapters/src/ad_flash.d \
./sdk/adapters/src/ad_gpadc.d \
./sdk/adapters/src/ad_haptic.d \
./sdk/adapters/src/ad_i2c.d \
./sdk/adapters/src/ad_iso7816.d \
./sdk/adapters/src/ad_keyboard_scanner.d \
./sdk/adapters/src/ad_lcdc.d \
./sdk/adapters/src/ad_nvms.d \
./sdk/adapters/src/ad_nvms_direct.d \
./sdk/adapters/src/ad_nvms_ves.d \
./sdk/adapters/src/ad_nvparam.d \
./sdk/adapters/src/ad_pmu.d \
./sdk/adapters/src/ad_sdadc.d \
./sdk/adapters/src/ad_snc.d \
./sdk/adapters/src/ad_spi.d \
./sdk/adapters/src/ad_template.d \
./sdk/adapters/src/ad_uart.d \
./sdk/adapters/src/sys_platform_devices_internal.d 


# Each subdirectory must supply rules for building sources it contributes
sdk/adapters/src/ad_crypto.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_crypto.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_flash.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_flash.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_gpadc.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_gpadc.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_haptic.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_haptic.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_i2c.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_i2c.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_iso7816.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_iso7816.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_keyboard_scanner.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_keyboard_scanner.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_lcdc.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_lcdc.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_nvms.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvms.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_nvms_direct.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvms_direct.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_nvms_ves.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvms_ves.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_nvparam.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_nvparam.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_pmu.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_pmu.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_sdadc.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_sdadc.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_snc.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_snc.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_spi.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_spi.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_template.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_template.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/ad_uart.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/ad_uart.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/adapters/src/sys_platform_devices_internal.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/src/sys_platform_devices_internal.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


