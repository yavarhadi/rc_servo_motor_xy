![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout Verilog Project Template

- [Read the documentation for project](docs/info.md)

##Features

Two independent RC-servo PWM channels (X & Y)

20 ms frame (50 Hz), 1.0–2.0 ms pulse width range (typical RC servo)

Parameterizable clock frequency (default 50 MHz from TT harness)

Asynchronous step inputs per axis
Debounced/synchronized edge events increment/decrement the target pulse width (“tilt/hold” logic).

TinyTapeout wrapper (tt_um_rc_servo_motor_xy_ea.v) with clean I/O mapping

Synthesisable (Sky130 sky130_fd_sc_hd) and verified with Icarus/GTKWave

Fits in TT gate budget with conservative counters/adders (shift-add friendly)


##Repository Structure

.
├─ src/                               # RTL
│  ├─ rc_servo_core_xy.v              # Core: dual PWM (X/Y) + step/tilt control
│  ├─ tt_um_rc_servo_motor_xy_ea.v    # TinyTapeout wrapper (top-level)
│  ├─ impl.sdc                        # Timing coimplementation
│  ├─ signoff.sdc                     # signoff
│  ├─ pin_order.cfg                   # Pin order
│  └─ .config.json.swo                # Swap file
├─ test/                              # Test assets (cocotb/pytest or helpers)
│  ├─  rc_servo_xy_ea_tb.v
│  ├─  tb.v                           # TinyTapeout template-style TB
│  ├─  tb.gtkw                        # GTKWave view
│  ├─  test.py                        # Python test (e.g., cocotb)
│  └─ requirements.txt
├─ Makefile                           # Shortcuts: sim, lint, clean
├─ config.json                        # OpenLane/LibreLane config (STD cell lib, clock)
├─ info.yaml                          # TinyTapeout manifest (list sources, set top)
├─ .gitignore                         # Git ignores
├─ LICENSE                            # Project license
└─ README.md                          # Project overview & instructions


#Top-Level (TinyTapeout) I/O Map

TinyTapeout signals: clk, rst_n, ena, ui[7:0], uo[7:0], uio[7:0].

mapping :

Inputs (ui)

  -ui[0] → comp_async_x_i (step/compare for X)

  -ui[1] → comp_async_y_i (step/compare for Y)

  -others reserved

Outputs (uo)

  -uo[0] → pwm_x_o

  -uo[1] → pwm_y_o

  -others reserved

Bidirectional (uio)

unused (set to inputs with pull-downs)

Clock/Reset:

  -clk 50 MHz from harness (default)

  -rst_n 

  -ena gate from harness (only drive outputs when ena==1)


#Core Architecture:

 - PWM generator per axis
   A 20 ms frame counter (at 50 MHz → 1 000 000 ticks) asserts the output high for pulse_width_ticks ∈ [50_000 .. 100_000] (i.e., 1.0–2.0 ms).

 - Step/tilt controller
Asynchronous edge on comp_async_*_i is synchronized, debounced, and converted to a ±Δ change to pulse_width_ticks. Optional step_dir_i sets direction.










