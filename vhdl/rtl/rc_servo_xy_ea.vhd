library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;

-- Top-level: dual-axis RC-servo controller
-- Pipeline per axis:
--   comparator async -> Delta_ADC_XY (delta loop + smoothing)
--   -> holdValueOnStrb (strobe-gated latch)
--   -> tilt (8b code -> on-time counts)
--   -> servo_control (50 Hz PWM with 1–2 ms high)

entity rc_servo_xy is
	port(
		clk_i				: in std_ulogic;   -- system clock (e.g., 50 MHz)
		reset_i				: in std_ulogic;   -- top-level reset (active-LOW externally, see below)
		comp_async_x_i		: in std_ulogic;           -- async comparator X (from off-chip RC+comp)
		comp_async_y_i		: in std_ulogic;          -- async comparator Y (from off-chip RC+comp)
			
		pwm_x_o				: out std_ulogic;   --fast delta-PWM (X) ~200 kHz to off-chip RC
		pwm_y_o				: out std_ulogic;   -- fast delta-PWM (Y)
		pwm_pin_x_o			: out std_ulogic;   -- 50 Hz servo PWM (X), ~1–2 ms high
		pwm_pin_y_o			: out std_ulogic    -- 50 Hz servo PWM (Y), ~1–2 ms high
		
	);
end entity rc_servo_xy;

architecture rtl_rc_servo_xy of rc_servo_xy is
	-- Valid strobes (after smoothing) and 8-bit codes from the delta front-end
	signal adc_valid_strb_x		: std_ulogic;
	signal adc_valid_strb_y		: std_ulogic;
	signal adc_value_x			: unsigned(LENGTH-1 downto 0);
	signal adc_value_y			: unsigned(LENGTH-1 downto 0);
	
	--Hold Value   -- Held 8-bit values (update only on valid strobe)
	signal holdValue_x			: unsigned(LENGTH-1 downto 0);
	signal holdValue_y			: unsigned(LENGTH-1 downto 0);
	
	--Tilt ---- Mapped on-time counts for 50 Hz servo pulse
	signal ON_counter_val_x		: unsigned(MAX_COUNT_2ms_length-1 downto 0);
	signal ON_counter_val_y		: unsigned(MAX_COUNT_2ms_length-1 downto 0);
	
	--reset  -- Local reset: invert external (submodules expect active-HIGH reset)
	signal reset_n 				: std_ulogic;
	
	begin
		reset_n <= not reset_i; --low active reset
		
  ---------------------------------------------------------------------------
  -- Dual delta-mod front-end: sync comparator, delta-PWM, smoothing (X/Y)
  ---------------------------------------------------------------------------

		delta_adc_port: entity Delta_ADC_XY(rtl_Delta_ADC_XY)
		port map(
					clk_i => clk_i,
					reset_i => reset_n,
					comp_async_x_i => comp_async_x_i,
					comp_async_y_i => comp_async_y_i,
					pwm_x_o => pwm_x_o,
					pwm_y_o => pwm_y_o,
					adc_valid_strb_x_o => adc_valid_strb_x,
					adc_valid_strb_y_o => adc_valid_strb_y,
					adc_value_x_o => adc_value_x,
					adc_value_y_o => adc_value_y
				);
  ---------------------------------------------------------------------------
  -- Strobe-gated hold (captures code only when valid strobe asserts)
  ---------------------------------------------------------------------------
		holdValue_x_port: entity holdValueOnStrb(rtl_holdValueOnStrb)
		port map(
					clk_i => clk_i,
					reset_i => reset_n,
					adc_valid_strb_i => adc_valid_strb_x,
					adc_value_i => adc_value_x,
					holdValue_o => holdValue_x
				);
					
		holdValue_y_port: entity holdValueOnStrb(rtl_holdValueOnStrb)
		port map(
					clk_i => clk_i,
					reset_i => reset_n,
					adc_valid_strb_i => adc_valid_strb_y,
					adc_value_i => adc_value_y,
					holdValue_o => holdValue_y
				);
  ---------------------------------------------------------------------------
  -- Code -> on-time mapping (clamped 1.0–2.0 ms; optional midpoint)
  ---------------------------------------------------------------------------
		tilt_x_port: entity tilt(rtl_tilt)
		port map(
					clk_i => clk_i,
					reset_i => reset_n,
					hold_value_i => holdValue_x,
					ON_counter_val_o => ON_counter_val_x
				);
								
		tilt_y_port: entity tilt(rtl_tilt)
		port map(
					clk_i => clk_i,
					reset_i => reset_n,
					hold_value_i => holdValue_y,
					ON_counter_val_o => ON_counter_val_y
				);
  ---------------------------------------------------------------------------
  -- 50 Hz servo PWM generation (Period = MAX_COUNTER_50HZ cycles)
  ---------------------------------------------------------------------------
		servo_control_x_port: entity servo_control(rtl_servo_control)
		port map(
					clk_i => clk_i,
					reset_i => reset_n,
					Period_counter_val_i => to_unsigned(MAX_COUNTER_50HZ, PWM_COUNTER_LEN),
					ON_counter_val_i => ON_counter_val_x,
					pwm_pin_o => pwm_pin_x_o
				);
			
		servo_control_y_port: entity servo_control(rtl_servo_control)
		port map(
					clk_i => clk_i,
					reset_i => reset_n,
					Period_counter_val_i => to_unsigned(MAX_COUNTER_50HZ, PWM_COUNTER_LEN),
					ON_counter_val_i => ON_counter_val_y,
					pwm_pin_o => pwm_pin_y_o
				);
end architecture rtl_rc_servo_xy;
		
		
		
		
		
		
		
