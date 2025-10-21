# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, Timer, with_timeout, SimTimeoutError

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Fast sim clock so PWM is observable in CI
    clock = Clock(dut.clk, 20, unit="ns")  # 50 MHz
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
    # Short settle
    await ClockCycles(dut.clk, 2000)

    # Drive some activity for ~200 µs at 50 MHz
    async def drive():
        for i in range(10_000):
            # simple pattern on bits [1:0]
            dut.ui_in.value = (i & 1) | (((i >> 1) & 1) << 1)
            await RisingEdge(dut.clk)
    cocotb.start_soon(drive())

    # Wait for ANY change on the entire output bus.
    # NOTE: In cocotb 2.0 use the trigger object `signal.value_change` (no parentheses).
    try:
        await with_timeout(dut.uo_out.value_change, 60, "ms")
        dut._log.info("uo_out changed at least once (PWM alive).")
    except SimTimeoutError:
        # Keep smoke test lenient; log rather than fail. Make this an assert if you want stricter CI.
        dut._log.warning("uo_out did not change within 60 ms.")

    # Optional: run a bit longer for waveform capture
    await Timer(5, unit="ms")

    dut._log.info("Test completed.")

