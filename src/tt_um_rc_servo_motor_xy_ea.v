// src/tt_um_rc_servo_motor_xy_ea.v
`default_nettype none
//`include "rc_servo_core_xy.v"



module tt_um_rc_servo_motor_xy_ea (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,     // TT clock
    input  wire       rst_n    // TT reset (active-low)
);
    // Unused bidirectional pads
    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;

    // Map TT pins → core pins
    wire comp_async_x_i = ui_in[0];
    wire comp_async_y_i = ui_in[1];
    //core expects active-high reset_i; TT gives active-low rst_n
   // wire reset_i = ~rst_n;
    wire pwm_x, pwm_y;
    wire pwm_pin_x, pwm_pin_y;
    wire _unused_ok = &{1'b0, ui_in[7:2], uio_in};
    // Instantiate your existing design as a core
    rc_servo_core_xy core (
        .clk_i         (clk),
        .reset_i       (reset_i),
        .comp_async_x_i(comp_async_x_i),
        .comp_async_y_i(comp_async_y_i),
        .pwm_x_o        (pwm_x),      
        .pwm_y_o        (pwm_y),       
	.pwm_pin_x_o    (pwm_pin_x),
        .pwm_pin_y_o    (pwm_pin_y)
    );

        // Gate user outputs by ena (TT convention)
    assign uo_out = {
        4'b0000,                       // uo_out[7:4] free/debug
        (ena ? pwm_y : 1'b0),           // uo_out[3] 
        (ena ? pwm_x : 1'b0),           // uo_out[2] 
        (ena ? pwm_pin_y : 1'b0),      // uo_out[1]
        (ena ? pwm_pin_x : 1'b0)       // uo_out[0]
    };

endmodule
`default_nettype wire
