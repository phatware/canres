################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ble_peripheral_task.c \
../main.c 

OBJS += \
./ble_peripheral_task.o \
./main.o 

C_DEPS += \
./ble_peripheral_task.d \
./main.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Werror -Wall  -g3 -Ddg_configBLACK_ORCA_IC_REV=BLACK_ORCA_IC_REV_A -Ddg_configBLACK_ORCA_IC_STEP=BLACK_ORCA_IC_STEP_E -I"../../../../../sdk/interfaces/ble_stack/" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/projects/dk_apps/features/ble_peripheral/config" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/adapters/include" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/config" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/include" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/include/adapter" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/include/manager" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/config" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/att" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/att/attc" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/att/attm" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/att/atts" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/gap" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/gap/gapc" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/gap/gapm" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/gatt" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/gatt/gattc" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/gatt/gattm" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/l2c/l2cc" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/l2c/l2cm" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/smp" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/smp/smpc" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/host/smp/smpm" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/hl/src/rwble_hl" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/ll/src/controller/em" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/ll/src/controller/llc" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/ll/src/controller/lld" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/ll/src/controller/llm" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/ll/src/rwble" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ble/profiles" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/ea/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/em/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/hci/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/ip/hci/src" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/common/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/dbg/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/gtl/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/gtl/src" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/h4tl/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/ke/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/ke/src" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/nvds/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/modules/rwip/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/arch" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/arch/ll/armgcc_4_8" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/arch/boot/armgcc_4_8" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/arch/compiler/armgcc_4_8" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/build/ble-full/reg/fw" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/driver/flash" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/driver/reg" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/driver/rf" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble/src/stack/plf/black_orca/src/driver/rf/api" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/interfaces/ble_services/include" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/include" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/config" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/system/sys_man/include" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/free_rtos/include" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/osal" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/peripherals/include" -I"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/sdk/bsp/memory/include" -include"/Users/stan/work/DA1468x_DA15xxx_SDK_1.0.14.1081/DA1468x_DA15xxx_SDK_1.0.14.1081/projects/dk_apps/features/ble_peripheral/config/custom_config_qspi.h" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


