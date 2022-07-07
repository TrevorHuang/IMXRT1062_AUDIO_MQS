################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../freertos/freertos_kernel/croutine.c \
../freertos/freertos_kernel/event_groups.c \
../freertos/freertos_kernel/list.c \
../freertos/freertos_kernel/queue.c \
../freertos/freertos_kernel/stream_buffer.c \
../freertos/freertos_kernel/tasks.c \
../freertos/freertos_kernel/timers.c 

OBJS += \
./freertos/freertos_kernel/croutine.o \
./freertos/freertos_kernel/event_groups.o \
./freertos/freertos_kernel/list.o \
./freertos/freertos_kernel/queue.o \
./freertos/freertos_kernel/stream_buffer.o \
./freertos/freertos_kernel/tasks.o \
./freertos/freertos_kernel/timers.o 

C_DEPS += \
./freertos/freertos_kernel/croutine.d \
./freertos/freertos_kernel/event_groups.d \
./freertos/freertos_kernel/list.d \
./freertos/freertos_kernel/queue.d \
./freertos/freertos_kernel/stream_buffer.d \
./freertos/freertos_kernel/tasks.d \
./freertos/freertos_kernel/timers.d 


# Each subdirectory must supply rules for building sources it contributes
freertos/freertos_kernel/%.o: ../freertos/freertos_kernel/%.c freertos/freertos_kernel/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__REDLIB__ -DCPU_MIMXRT1062DVL6A -DCPU_MIMXRT1062DVL6A_cm7 -DSDK_OS_BAREMETAL -DXIP_EXTERNAL_FLASH=1 -DXIP_BOOT_HEADER_ENABLE=1 -DSERIAL_PORT_TYPE_UART=1 -DSDK_DEBUGCONSOLE=1 -DCR_INTEGER_PRINTF -DPRINTF_FLOAT_ENABLE=0 -DSDK_OS_FREE_RTOS -D__MCUXPRESSO -D__USE_CMSIS -DDEBUG -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\board" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\source" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\freertos\freertos_kernel\include" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\freertos\freertos_kernel\portable\GCC\ARM_CM4F" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\drivers" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\xip" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\drivers\freertos" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\component\serial_manager" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\component\uart" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\utilities" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\component\lists" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\CMSIS" -I"C:\Users\nxf75461\Documents\MCUXpressoIDE_11.5.0_7232\workspace\MIMXRT1062_MQS_TEST\device" -O0 -fno-common -g3 -Wall -c -ffunction-sections -fdata-sections -ffreestanding -fno-builtin -fmerge-constants -fmacro-prefix-map="$(<D)/"= -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -D__REDLIB__ -fstack-usage -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


