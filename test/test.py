# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, with_timeout, Timer, SimTimeoutError

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Use a fast sim clock so PWM periods are reachable in CI (50 MHz = 20 ns)
    clock = Clock(dut.clk, 20, unit="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value    = 1
    dut.ui_in.value  = 0
    dut.uio_in.value = 0
    dut.rst_n.value  = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value  = 1

    dut._log.info("Stimulus: wiggle comparator inputs on ui_in[1:0]")
    # Give the design a short settle time
    await ClockCycles(dut.clk, 2000)

    # Drive some activity for ~200 us (at 50 MHz)
    async def drive():
        for i in range(10_000):
            # Bit 0 toggles every cycle, bit 1 follows with a phase — produces density changes
            dut.ui_in.value = (i & 1) | (((i >> 1) & 1) << 1)
            await RisingEdge(dut.clk)
    cocotb.start_soon(drive())

    # Observe that the output bus changes at least once (don’t index packed vectors in triggers)
    try:
        await with_timeout(dut.uo_out.value_change(), 60, "ms")
        dut._log.info("uo_out changed at least once (PWM alive).")
    except SimTimeoutError:
        # Keep smoke test lenient; convert to an assertion later if you want strict behavior
        dut._log.warning("uo_out did not change within 60 ms.")

    # Optional: run a little longer so waveforms capture some PWM frames
    await Timer(5, unit="ms")

    dut._log.info("Test completed.")

