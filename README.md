![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout Verilog Project Template

- [Read the documentation for project](docs/info.md)

## Features

- Two independent RC-servo PWM channels (X & Y)

- 20 ms frame (50 Hz), 1.0–2.0 ms pulse width range (typical RC servo)

- Parameterizable clock frequency (default 50 MHz from TT harness)

- Asynchronous step inputs per axis
- Debounced/synchronized edge events increment/decrement the target pulse width (“tilt/hold” logic).

- TinyTapeout wrapper (tt_um_rc_servo_motor_xy_ea.v) with clean I/O mapping

- Synthesisable (Sky130 sky130_fd_sc_hd) and verified with Icarus/GTKWave

- Fits in TT gate budget with conservative counters/adders (shift-add friendly)


## Repository Structure

```text
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




























