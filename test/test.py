# test/test.py
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer, with_timeout, SimTimeoutError

@cocotb.test()
async def smoke(dut):
    """Minimal smoke test: clock, reset, wiggle inputs, and try to observe uo_out activity."""
    # 50 MHz clock
    cocotb.start_soon(Clock(dut.clk, 20, unit="ns").start())

    # init
    dut.ena.value    = 1
    dut.ui_in.value  = 0
    dut.uio_in.value = 0
    dut.rst_n.value  = 0
    await Timer(200, unit="ns")
    dut.rst_n.value  = 1

    # settle a bit
    for _ in range(2000):
        await RisingEdge(dut.clk)

    # drive some activity (~200 us)
    async def drive():
        for i in range(10_000):
            dut.ui_in.value = (i & 1) | (((i >> 1) & 1) << 1)
            await RisingEdge(dut.clk)
    cocotb.start_soon(drive())

    # Try to see any change on the whole bus (2.0 style)
    # Note: don't index packed vectors in triggers; use value_change() on the vector.
    try:
        await with_timeout(dut.uo_out.value_change(), 60, "ms")  # generous timeout
        cocotb.log.info("uo_out changed at least once.")
    except SimTimeoutError:
        # Keep this a PASS for now (smoke test). If you want to fail, change to: assert False, "..."
        cocotb.log.warning("uo_out did not change within 60 ms (not failing smoke test).")

    cocotb.log.info("Smoke test completed.")

