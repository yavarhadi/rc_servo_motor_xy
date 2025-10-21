# test/test.py
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer, Edge, with_timeout

@cocotb.test()
async def smoke(dut):
    """Minimal smoke test: clock, reset, wiggle inputs, and ensure uo_out changes at least once."""
    # 50 MHz clock (20 ns period)
    cocotb.start_soon(Clock(dut.clk, 20, unit="ns").start())

    # initial states
    dut.ena.value    = 1
    dut.ui_in.value  = 0
    dut.uio_in.value = 0
    dut.rst_n.value  = 0
    await Timer(200, unit="ns")
    dut.rst_n.value  = 1

    # give some time to settle
    for _ in range(2000):
        await RisingEdge(dut.clk)

    # drive some activity on the comparator inputs (~200 us)
    async def drive():
        for i in range(10_000):
            dut.ui_in.value = (i & 1) | (((i >> 1) & 1) << 1)
            await RisingEdge(dut.clk)
    cocotb.start_soon(drive())

    # Wait for ANY change on the whole bus (don't index packed vectors in triggers)
    try:
        await with_timeout(Edge(dut.uo_out), 2, "ms")
    except cocotb.result.SimTimeoutError:
        assert False, "uo_out never changed within 2 ms"

    cocotb.log.info("Smoke test completed.")

