# ----------------------------------------------
# Example code for
#
# System-on-Chip Design with Arm(R) Cortex(R)-M 
# Processors
#
# Reference Book
#	   by Joseph Yiu, 2019 (first edition)
# 
# ISBN: 978-1-911531-19-7
# Arm Education Media
# https://www.armedumedia.com
#
# Disclaimer
# This example design is created for educational
# purpose only and are not validated to the same 
# quality level as Arm IP products. 
# Arm Education Media and author do not make any 
# warranties of these designs.
# ----------------------------------------------
# Purpose: Makefile for simulation
# ----------------------------------------------

# Simulator = mti / iverilog
SIMULATOR = mti

MTI_VC_OPTIONS  += -f tbench_cm3.vc
MTI_OPTIONS      = -novopt
TESTCODE_DIR     = testcodes


code:
	cd ../$(TESTCODE_DIR); make all ; cd ../rtl_sim; cp ../$(TESTCODE_DIR)/image.dat image.dat

compile: compile_$(SIMULATOR)

sim: sim_$(SIMULATOR)

run: run_$(SIMULATOR)

#------------------------------------------
# Modelsim / Questasim
compile_mti:
	@if [ -d work ] ; then \
          true ; \
	else \
	  vlib work; \
	fi
	vlog -incr -lint +v2k $(MTI_OPTIONS) $(MTI_VC_OPTIONS) | tee compile_mti.log

# Run simulation in interactive mode
sim_mti: code
	vsim $(MTI_OPTIONS) -gui tbench_cm3 &

# Run simulation in batch mode
run_mti : code
	@if [ ! -d logs ] ; then \
	  mkdir logs; \
	fi
	vsim $(MTI_OPTIONS) -c tbench_cm3 -do "radix hex;run -all;quit -f" | tee logs/run.log ;

#------------------------------------------
# Icarus Verilog (Experimental)
IVERILOG_EXEC = iverilog_exe
compile_iverilog:
	iverilog -o $(IVERILOG_EXEC) -c tbench_cm3.vc | tee compile_iverilog.log


# Run simulation in interactive mode
sim_iverilog: code
	echo ERROR: no interactive simulation for Icarus Verilog in this makefile

# Run simulation in batch mode
run_iverilog : code
	@if [ ! -d logs ] ; then \
	  mkdir logs; \
	fi
	vvp $(IVERILOG_EXEC) | tee run_iverlog.log


