# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR := ../src
PROJECT_SOURCES = tt_um_rc_servo_motor_xy_ea.v

ifneq ($(GATES),yes)

# RTL simulation:
VERILOG_SOURCES += $(PWD)/tb.v $(SRC_DIR)/tt_um_rc_servo_motor_xy_ea.v $(SRC_DIR)/rc_servo_core_xy.v

else

# Gate level simulation:

COMPILE_ARGS    += -DGL_TEST
COMPILE_ARGS    += -DFUNCTIONAL
COMPILE_ARGS    += -DUSE_POWER_PINS
COMPILE_ARGS    += -DSIM
COMPILE_ARGS    += -DUNIT_DELAY=\#1
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

# this gets copied in by the GDS action workflow
VERILOG_SOURCES +=  $(PWD)/tb.v $(PWD)/gate_level_netlist.v

endif

# Allow sharing configuration between design and testbench via `include`:
#COMPILE_ARGS 		+= -I$(SRC_DIR)

# Include the testbench sources:
#VERILOG_SOURCES += $(PWD)/tb.v
TOPLEVEL = tt_um_rc_servo_motor_xy_ea

# List test modules to run, separated by commas and without the .py suffix:
COCOTB_TEST_MODULES = test

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
