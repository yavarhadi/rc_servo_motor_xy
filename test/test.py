# test/test.py
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def smoke(dut):
    # 'dut' is the TB top (module tb), so signals are dut.clk, dut.rst_n, dut.ui_in, ...
    cocotb.start_soon(Clock(dut.clk, 20, units="ns").start())  # 50 MHz

    dut.ena.value    = 1
    dut.ui_in.value  = 0
    dut.uio_in.value = 0
    dut.rst_n.value  = 0
    await Timer(200, units="ns")
    dut.rst_n.value  = 1

    # Run ~200 µs and wiggle inputs. No assertions -> always produces results.xml
    for i in range(10_000):
        dut.ui_in.value = (i & 1) | (((i >> 1) & 1) << 1)
        await RisingEdge(dut.clk)

    cocotb.log.info("Smoke test completed.")
