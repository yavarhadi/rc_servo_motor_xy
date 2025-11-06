library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;
-- One delta-modulation channel:
-- - ADC_Value: ±1 LSB saturating accumulator, updates only on strb_signal_i
-- - dff:       re-times the strobe to a 1-cycle "valid" pulse
-- - PWM:       fast carrier; duty set by adc_value_signal
entity DeltaADC is
	port(
			clk_i			: in std_ulogic;
			reset_i			: in std_ulogic;
			comparator_i		: in std_ulogic;     -- decision: 1=inc, 0=dec
			strb_signal_i		: in std_ulogic;     -- update strobe (one cycle)
			
			adc_valid_strb_o	: out std_ulogic;    -- re-timed valid pulse
			pwm_o			: out std_ulogic;    -- fast PWM 
			adc_value_o		: out unsigned(LENGTH-1 downto 0)   -- raw N-bit code
	);

end entity DeltaADC;

architecture DeltaADC_rtl of DeltaADC is

	signal adc_value_signal			: unsigned(LENGTH-1 downto 0);
	
	begin
  ---------------------------------------------------------------------------
  -- +/-1 LSB saturating accumulator (updates only at strb)
  ---------------------------------------------------------------------------
		adc_value_port: entity ADC_Value(ADC_Value_behav)
		port map(
				clk_i => clk_i,
				reset_i => reset_i,
				comparator_i => comparator_i,
				strb_i => strb_signal_i,
				adc_value_o => adc_value_signal
		);
  ---------------------------------------------------------------------------
  -- Valid strobe: registered version of strb_signal_i (one cycle wide)
  ---------------------------------------------------------------------------	
		d_ff_port: entity dff(dff_rtl)
		port map(
				clk_i => clk_i,
				reset_i	=> reset_i,
				d_i => strb_signal_i,
				q_o	=> adc_valid_strb_o
		);
  ---------------------------------------------------------------------------
  -- Fast PWM: carrier period set for ~200 kHz at the system clock
  -- Duty is proportional to adc_value_signal.
  ---------------------------------------------------------------------------		
		pwm_port: entity PWM(pwm_behav)
		port map(
				clk_i => clk_i,
				reset_i => reset_i,
				Period_counter_val_i => to_unsigned(MAX_COUNTER_200kHZ, PERIOD_COUNTER_PWM_LEN),
				ON_counter_val_i => adc_value_signal,
				PWM_pin_o => pwm_o
		);
  -- Expose the current accumulator value
		adc_value_o <= adc_value_signal; 
end architecture DeltaADC_rtl;


