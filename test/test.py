# test/test.py
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer, Edge
from cocotb.result import TestFailure

@cocotb.test()
async def smoke(dut):
    """Minimal smoke test: clock, reset, wiggle inputs, and wait for any change on uo_out."""
    # 50 MHz clock (20 ns period)
    cocotb.start_soon(Clock(dut.clk, 20, unit="ns").start())

    # init
    dut.ena.value    = 1
    dut.ui_in.value  = 0
    dut.uio_in.value = 0
    dut.rst_n.value  = 0
    await Timer(200, unit="ns")
    dut.rst_n.value  = 1

    # let it settle a little
    for _ in range(2000):
        await RisingEdge(dut.clk)

    # wiggle comparator inputs to create activity (≈ 200 µs)
    async def drive():
        for i in range(10_000):
            dut.ui_in.value = (i & 1) | (((i >> 1) & 1) << 1)
            await RisingEdge(dut.clk)
    cocotb.start_soon(drive())

    # Wait up to 2 ms for ANY change on the whole bus (no bit indexing)
    # If you want stricter behavior later, we can tighten this.
    try:
        await cocotb.triggers.with_timeout(Edge(dut.uo_out), 2, "ms")
    except cocotb.result.SimTimeoutError:
        raise TestFailure("uo_out never changed within 2 ms")

    cocotb.log.info("Smoke test completed.")

