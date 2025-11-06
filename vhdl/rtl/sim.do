vlib work
vmap work work

vcom -work work std_def_p.vhd

vcom -work work d_ff_ea.vhd
vcom -work work synchonizer_ea.vhd
vcom -work work strb_ea.vhd
vcom -work work pwm_ea.vhd
vcom -work work adc_value_ea.vhd
vcom -work work filter_shift_register_ea.vhd
vcom -work work moving_average_ea.vhd
vcom -work work DeltaADC_ea.vhd
vcom -work work Delta_ADC_XY_ea.vhd
vcom -work work HoldValueOnStrb_ea.vhd
vcom -work work Tilt_ea.vhd
vcom -work work servo_control_ea.vhd
vcom -work work rc_servo_xy_ea.vhd


vcom -work work rc_servo_xy_tb.vhd
vcom -work work rc_servo_xy_tb.vhd


vsim work.rc_servo_xy_tb


add wave -r *

run 6 sec