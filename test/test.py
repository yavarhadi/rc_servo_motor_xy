# test/test.py
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, First

@cocotb.test()
async def smoke(dut):
    """
    Very loose sanity test:
    - drive 50 MHz clock (20 ns)
    - release reset
    - wiggle ui_in[0]/ui_in[1] a bit
    - observe that uo_out[0] toggles at least once within ~60 ms
    """
    # 50 MHz to match 1_000_000 tick 20 ms period in your RTL
    cocotb.start_soon(Clock(dut.clk, 20, units="ns").start())

    # default states
    dut.ena.value   = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # reset low-active
    dut.rst_n.value = 0
    await Timer(200, units="ns")
    dut.rst_n.value = 1

    # Give the design time to settle
    for _ in range(2000):
        await RisingEdge(dut.clk)

    # Wiggle comparator inputs to create some activity
    async def drive_inputs():
        for i in range(100_000):  # ~2 ms @ 50 MHz
            dut.ui_in.value = (i & 1) | (((i >> 1) & 1) << 1)
            await RisingEdge(dut.clk)

    drv = cocotb.start_soon(drive_inputs())

    # We expect a PWM with ~20 ms period.
    # Wait up to 60 ms for any transition on uo_out[0].
    # (Very loose — just proves the block is alive.)
    timeout = Timer(60, units="ms")
    evt = await First(RisingEdge(dut.uo_out[0]),
                      FallingEdge(dut.uo_out[0]),
                      timeout)

    assert evt is not timeout, "PWM output (uo_out[0]) never toggled within 60 ms"

    # Optional: wait another frame and make sure it toggles again
    timeout2 = Timer(40, units="ms")
    evt2 = await First(RisingEdge(dut.uo_out[0]),
                       FallingEdge(dut.uo_out[0]),
                       timeout2)
    assert evt2 is not timeout2, "PWM output failed to toggle again"

