################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../utilities/fsl_debug_console.c \
../utilities/fsl_str.c 

OBJS += \
./utilities/fsl_debug_console.o \
./utilities/fsl_str.o 

C_DEPS += \
./utilities/fsl_debug_console.d \
./utilities/fsl_str.d 


# Each subdirectory must supply rules for building sources it contributes
utilities/%.o: ../utilities/%.c utilities/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__REDLIB__ -DCPU_MIMXRT1062DVL6A -DCPU_MIMXRT1062DVL6A_cm7 -DSDK_OS_BAREMETAL -DXIP_EXTERNAL_FLASH=1 -DXIP_BOOT_HEADER_ENABLE=1 -DSERIAL_PORT_TYPE_UART=1 -DSDK_DEBUGCONSOLE=1 -DCR_INTEGER_PRINTF -DPRINTF_FLOAT_ENABLE=0 -DSDK_OS_FREE_RTOS -D__MCUXPRESSO -D__USE_CMSIS -DDEBUG -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\board" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\source" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\freertos\freertos_kernel\include" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\freertos\freertos_kernel\portable\GCC\ARM_CM4F" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\drivers" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\xip" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\drivers\freertos" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\component\serial_manager" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\component\uart" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\utilities" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\component\lists" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\CMSIS" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\device" -O0 -fno-common -g3 -Wall -c -ffunction-sections -fdata-sections -ffreestanding -fno-builtin -fmerge-constants -fmacro-prefix-map="$(<D)/"= -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -D__REDLIB__ -fstack-usage -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


