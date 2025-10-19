// Simple two-channel RC-servo PWM core (DUT)
// Clock: 50 MHz (20 ns). Active-high reset_i.
`default_nettype none

module rc_servo_xy_ea (
    input  wire clk_i,
    input  wire reset_i,          // synchronous active-high reset
    input  wire comp_async_x_i,   // comparator / command input (X)
    input  wire comp_async_y_i,   // comparator / command input (Y)
    output wire pwm_pin_x_o,      // PWM output X
    output wire pwm_pin_y_o       // PWM output Y
);

  // Parameters for 50 MHz clock
  // Frame ~20 ms -> 1_000_000 cycles
  // Pulse 1.0 ms -> 50_000 cycles, 2.0 ms -> 100_000 cycles
  localparam integer CLK_HZ           = 50_000_000;
  localparam integer FRAME_TICKS      = CLK_HZ / 50;          // 20 ms
  localparam integer PULSE_MIN_TICKS  = CLK_HZ / 1000;        // 1.0 ms
  localparam integer PULSE_MAX_TICKS  = CLK_HZ / 500;         // 2.0 ms
  localparam integer CNT_WIDTH        = 20;                   // enough for 1e6 (< 2^20)

  // Map inputs to a pulse width (simple: low=min, high=max)
  wire [CNT_WIDTH-1:0] width_x = comp_async_x_i ? PULSE_MAX_TICKS[CNT_WIDTH-1:0]
                                                : PULSE_MIN_TICKS[CNT_WIDTH-1:0];
  wire [CNT_WIDTH-1:0] width_y = comp_async_y_i ? PULSE_MAX_TICKS[CNT_WIDTH-1:0]
                                                : PULSE_MIN_TICKS[CNT_WIDTH-1:0];

  // Reusable PWM channel
  pwm_servo #(
    .CNT_WIDTH  (CNT_WIDTH),
    .FRAME_TICKS(FRAME_TICKS)
  ) ch_x (
    .clk_i      (clk_i),
    .reset_i    (reset_i),
    .width_i    (width_x),
    .pwm_o      (pwm_pin_x_o)
  );

  pwm_servo #(
    .CNT_WIDTH  (CNT_WIDTH),
    .FRAME_TICKS(FRAME_TICKS)
  ) ch_y (
    .clk_i      (clk_i),
    .reset_i    (reset_i),
    .width_i    (width_y),
    .pwm_o      (pwm_pin_y_o)
  );

endmodule


// -----------------------------------------------------------------------------
// Parameterized PWM generator for RC servos
// Outputs high for width_i ticks once per FRAME_TICKS period.
// -----------------------------------------------------------------------------
module pwm_servo #(
    parameter integer CNT_WIDTH   = 20,
    parameter integer FRAME_TICKS = 1_000_000
)(
    input  wire                    clk_i,
    input  wire                    reset_i,   // synchronous active-high
    input  wire [CNT_WIDTH-1:0]    width_i,   // high-time in clock ticks
    output reg                     pwm_o
);
  reg [CNT_WIDTH-1:0] ctr;

  always @(posedge clk_i) begin
    if (reset_i) begin
      ctr   <= {CNT_WIDTH{1'b0}};
      pwm_o <= 1'b0;
    end else begin
      // period counter
      if (ctr == FRAME_TICKS[CNT_WIDTH-1:0] - 1) begin
        ctr <= {CNT_WIDTH{1'b0}};
      end else begin
        ctr <= ctr + {{(CNT_WIDTH-1){1'b0}}, 1'b1};
      end
      // pulse high while ctr < width
      pwm_o <= (ctr < width_i);
    end
  end
endmodule

`default_nettype wire

