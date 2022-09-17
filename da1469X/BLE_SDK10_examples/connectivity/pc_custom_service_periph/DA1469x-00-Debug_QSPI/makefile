################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include startup/DA1469x/GCC/subdir.mk
-include startup/DA1469x/subdir.mk
-include startup/subdir.mk
-include sdk/util/src/subdir.mk
-include sdk/sys_man/subdir.mk
-include sdk/snc/src/subdir.mk
-include sdk/peripherals/src/subdir.mk
-include sdk/osal/subdir.mk
-include sdk/memory/src/subdir.mk
-include sdk/ble/stack/da14690/src/subdir.mk
-include sdk/ble/services/src/subdir.mk
-include sdk/ble/manager/src/subdir.mk
-include sdk/ble/clients/src/subdir.mk
-include sdk/ble/api/src/subdir.mk
-include sdk/ble/adapter/src/subdir.mk
-include sdk/adapters/src/subdir.mk
-include sdk/FreeRTOS/portable/MemMang/subdir.mk
-include sdk/FreeRTOS/portable/GCC/DA1469x/subdir.mk
-include sdk/FreeRTOS/portable/Common/subdir.mk
-include sdk/FreeRTOS/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
SECONDARY_FLASH += \
pc_custom_service_periph.bin \

SECONDARY_SIZE += \
pc_custom_service_periph.siz \


# All Target
all:
	$(MAKE) --no-print-directory pre-build
	$(MAKE) --no-print-directory main-build

# Main-build Target
main-build: pc_custom_service_periph.elf secondary-outputs

# Tool invocations
pc_custom_service_periph.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Cross ARM C Linker'
	arm-none-eabi-gcc -mcpu=cortex-m33 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall -Wno-cpp  -g3 -T "/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/DA1469x-00-Debug_QSPI/mem.ld" -T "/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/DA1469x-00-Debug_QSPI/sections.ld" -Xlinker --gc-sections -L"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/ldscripts/ble_projects" -L"/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/interfaces/ble/binaries/DA1469x-Release" -Wl,-Map,"pc_custom_service_periph.map" --specs=nano.specs --specs=nosys.specs -o "pc_custom_service_periph.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

pc_custom_service_periph.bin: pc_custom_service_periph.elf
	@echo 'Invoking: Cross ARM GNU Create Flash Image'
	arm-none-eabi-objcopy -O binary "pc_custom_service_periph.elf"  "pc_custom_service_periph.bin"
	@echo 'Finished building: $@'
	@echo ' '

pc_custom_service_periph.siz: pc_custom_service_periph.elf
	@echo 'Invoking: Cross ARM GNU Print Size'
	arm-none-eabi-size --format=berkeley "pc_custom_service_periph.elf"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(SECONDARY_FLASH)$(SECONDARY_SIZE)$(ASM_DEPS)$(S_UPPER_DEPS)$(C_DEPS) pc_custom_service_periph.elf
	-@echo ' '

pre-build:
	-@echo 'Generate linker scripts.'
	-make generate_ldscripts DEVICE=DEVICE_DA1469x USE_FPGA=0 PRE_BUILD_EXTRA_DEFS="" IC_REV=A IC_STEP=A APP_CONFIG_H="/Users/stan/work/DA1469X/BLE_SDK10_examples/connectivity/pc_custom_service_periph/config/custom_config_qspi.h" CC="arm-none-eabi-gcc" BSP_CONFIG_DIR="/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/config" MIDDLEWARE_CONFIG_DIR="/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/middleware/config" LDSCRIPT_PATH="/Users/stan/work/DA1469X/SDK_10.0.10.118/sdk/bsp/ldscripts/ble_projects"
	-@echo ' '

secondary-outputs: $(SECONDARY_FLASH) $(SECONDARY_SIZE)

.PHONY: all clean dependents main-build pre-build

-include ../makefile.targets
