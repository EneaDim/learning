# ----------------------------------------------
# Example code for
#
# System-on-Chip Design with Arm(R) Cortex(R)-M 
# Processors
#
# Reference Book
#          by Joseph Yiu, 2019 (first edition)
# 
# Arm Education Media (university@arm.com)
# https://www.arm.com/resources/education
# ISBN: 978-1-911531-19-7
# ----------------------------------------------
# Purpose: Makefile for software compilation
#
# Disclaimer
# This example design is created for educational
# purpose only and are not validated to the same 
# quality level as Arm IP products. 
# Arm Education Media and author do not make any 
# warranties of these designs.
# ----------------------------------------------

# Tool chain : ac5 / ac6 / gcc
TOOL_CHAIN      = gcc

# Makefile using Arm Compiler 5 / Arm Compiler 6 / gcc
TESTNAME = example

INC_DIR1 = cmsis_include
INC_DIR2 = .
USER_DEF =

ifeq ($(TOOL_CHAIN),ac5)
  # Arm compiler 5
  ARM_CC_OPTS  = --cpu Cortex-M3 -c -O3 -g -Otime -I $(INC_DIR1) -I $(INC_DIR2)
  COMPILE      = armcc
  ARM_LINK_OPTS = "--keep=startup_cm3_mcu.o(RESET)" "--first=startup_cm3_mcu.o(RESET)" \
		 --rw_base 0x20000000 --ro_base 0x00000000 --map
else
  # Arm compiler 6
  ARM_CC_OPTS  = --target=arm-arm-none-eabi -mcpu=cortex-m3 -c -O3 -g -I $(INC_DIR1) -I $(INC_DIR2) 
  COMPILE      = armclang
  ARM_LINK_OPTS = "--keep=startup_cm3_mcu.o(RESET)" "--first=startup_cm3_mcu.o(RESET)" \
		--force_scanlib --rw_base 0x20000000 --ro_base 0x00000000 --map
endif

ARM_ASM_OPTS = --cpu Cortex-M3 -g

GCC_OPTS  = -mthumb -mcpu=cortex-m3 -O3 -g -I $(INC_DIR1) -I $(INC_DIR2) 
GCC_LINKER_SCRIPT_PATH = ldscripts
GCC_LINKER_SCRIPT = ldscripts/mem.ld
GCC_LINK_OPTS = -T $(GCC_LINKER_SCRIPT)

all: all_$(TOOL_CHAIN)

#-------------------------------------------------------
# Arm Compiler 5 /Arm Compiler 6

all_ac5: $(TESTNAME).hex $(TESTNAME).lst itcm0 

all_ac6: $(TESTNAME).hex $(TESTNAME).lst itcm0 

$(TESTNAME).o: $(TESTNAME).c
	$(COMPILE) $(ARM_CC_OPTS) $< -o  $@

system_cm3_mcu.o: system_cm3_mcu.c
	$(COMPILE) $(ARM_CC_OPTS) $< -o  $@

uart_util.o: uart_util.c
	$(COMPILE) $(ARM_CC_OPTS) $< -o  $@

LED.o: LED.c
	$(COMPILE) $(ARM_CC_OPTS) $< -o  $@

retarget_io.o: retarget_io.c RTE_Components.h
	$(COMPILE) $(ARM_CC_OPTS) $< -o  $@

startup_cm3_mcu.o: startup_codes/arm/startup_cm3_mcu.s
	armasm $(ARM_ASM_OPTS) $< -o  $@

$(TESTNAME).elf: $(TESTNAME).o system_cm3_mcu.o uart_util.o retarget_io.o startup_cm3_mcu.o LED.o
	armlink $(TESTNAME).o system_cm3_mcu.o uart_util.o retarget_io.o startup_cm3_mcu.o LED.o $(ARM_LINK_OPTS) -o $@

$(TESTNAME).hex : $(TESTNAME).elf
	fromelf --vhx --8x1 $< --output $@
	cp $(TESTNAME).hex image.dat

itcm0 : $(TESTNAME).elf
	fromelf --vhx --8x4 $< --output itcm
	cp $(TESTNAME).hex image.dat


$(TESTNAME).lst : $(TESTNAME).elf
	fromelf -c -d -e -s $< --output $@

#-------------------------------------------------------
# gcc
all_gcc: $(TESTNAME).c system_cm3_mcu.c uart_util.c retarget_gcc.c startup_codes/gcc/startup_cm3_mcu.S LED.c LED.h
	arm-none-eabi-gcc $(GCC_OPTS) $(TESTNAME).c system_cm3_mcu.c LED.c \
		uart_util.c retarget_gcc.c startup_codes/gcc/startup_cm3_mcu.S \
		-L $(GCC_LINKER_SCRIPT_PATH) $(GCC_LINK_OPTS) -o $(TESTNAME).elf
	arm-none-eabi-objcopy -S $(TESTNAME).elf -O verilog  $(TESTNAME).hex
	arm-none-eabi-objdump -S $(TESTNAME).elf > $(TESTNAME).lst
	cp $(TESTNAME).hex image.dat
	# Generate binary file
	arm-none-eabi-objcopy -S $(TESTNAME).elf -O binary $(TESTNAME).bin
	# Generate hex file
	od -v -A n -t x1 --width=1  $(TESTNAME).bin > $(TESTNAME).vhx
	# Generate itcm hex files
	./vhx2itcm.pl $(TESTNAME).vhx

#-------------------------------------------------------
clean:
	rm *.elf
	rm *.lst
	rm *.hex
	rm image.dat
	rm itcm*
	rm *.o

	
