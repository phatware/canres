################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/croutine.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/event_groups.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/list.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/queue.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/stream_buffer.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/tasks.c \
/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/timers.c 

OBJS += \
./sdk/FreeRTOS/croutine.o \
./sdk/FreeRTOS/event_groups.o \
./sdk/FreeRTOS/list.o \
./sdk/FreeRTOS/queue.o \
./sdk/FreeRTOS/stream_buffer.o \
./sdk/FreeRTOS/tasks.o \
./sdk/FreeRTOS/timers.o 

C_DEPS += \
./sdk/FreeRTOS/croutine.d \
./sdk/FreeRTOS/event_groups.d \
./sdk/FreeRTOS/list.d \
./sdk/FreeRTOS/queue.d \
./sdk/FreeRTOS/stream_buffer.d \
./sdk/FreeRTOS/tasks.d \
./sdk/FreeRTOS/timers.d 


# Each subdirectory must supply rules for building sources it contributes
sdk/FreeRTOS/croutine.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/croutine.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/FreeRTOS/event_groups.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/event_groups.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/FreeRTOS/list.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/list.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/FreeRTOS/queue.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/queue.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/FreeRTOS/stream_buffer.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/stream_buffer.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/FreeRTOS/tasks.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/tasks.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

sdk/FreeRTOS/timers.o: /Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/timers.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -Ddg_configDEVICE=DEVICE_DA1469x -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_A -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/adapters/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/util/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/memory/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/config" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/free_rtos/portable/GCC/DA1469x" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/middleware/osal" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/system/sys_man/include" -I"/Volumes/Development/Embedded/DA1469X/SDK_10.0.10.118/sdk/bsp/peripherals/include" -include"/Volumes/Development/Embedded/DA1469X/BLE_SDK10_examples/interfaces/led_driver/config/custom_config_ram.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


