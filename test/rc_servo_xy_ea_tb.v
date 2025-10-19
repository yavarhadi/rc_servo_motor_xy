`timescale 1ns/1ps
`default_nettype none

// Testbench for rc_servo_xy
module rc_servo_xy_tb;

  // === Parameters (adapt if CLK_FREQUENCY comes from a package elsewhere) ===
  parameter integer CLK_FREQUENCY   = 50_000_000;             // 50 MHz
  localparam integer CLK_PERIOD_NS  = 1_000_000_000 / CLK_FREQUENCY; // 20 ns @ 50 MHz

  // === DUT I/O ===
  reg  clk_i;
  reg  reset_i;
  reg  comp_async_x_i;
  reg  comp_async_y_i;
  wire pwm_x_o;
  wire pwm_y_o;

  // === DUT Instance ===
  // VHDL: entity rc_servo_xy(rtl_rc_servo_xy)
  rc_servo_xy dut (
    .clk_i          (clk_i),
    .reset_i        (reset_i),
    .comp_async_x_i (comp_async_x_i),
    .comp_async_y_i (comp_async_y_i),
    .pwm_pin_x_o    (pwm_x_o),
    .pwm_pin_y_o    (pwm_y_o)
  );

  // === Clock generation ===
  initial begin
    clk_i = 1'b0;
    forever #(CLK_PERIOD_NS/2) clk_i = ~clk_i; // 50% duty
  end

  // === Reset (VHDL had 0 for 10 ns, then 1 forever) ===
  initial begin
    reset_i = 1'b0;
    #10;
    reset_i = 1'b1;
  end

  // === comp_async_x_i generator (200 ms high, 50 ms low, repeats) ===
  initial begin
    comp_async_x_i = 1'b1;
    forever begin
      #(200_000_000); // 200 ms
      comp_async_x_i = 1'b0;
      #(50_000_000);  // 50 ms
      comp_async_x_i = 1'b1;
    end
  end

  // === comp_async_y_i generator (30 ms high, 10 ms low, repeats) ===
  initial begin
    comp_async_y_i = 1'b1;
    forever begin
      #(30_000_000); // 30 ms
      comp_async_y_i = 1'b0;
      #(10_000_000); // 10 ms
      comp_async_y_i = 1'b1;
    end
  end

  // === Optional: waveform dump + auto-finish ===
  initial begin
    // Comment these two lines out if you don't want VCDs
    $dumpfile("rc_servo_xy_tb.vcd");
    $dumpvars(0, rc_servo_xy_tb);

    // Run long enough to observe multiple PWM frames and async changes
    #(1_000_000_000); // 1 second
    $finish;
  end

endmodule

`default_nettype wire

