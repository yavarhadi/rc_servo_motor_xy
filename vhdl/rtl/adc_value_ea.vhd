library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;    -- defines LENGTH, MIN_ADC_VALUE, MAX_ADC_VALUE, etc.


-- Saturating ±1 LSB accumulator updated only on strobe.
-- If comparator_i='1' at strb_i='1' -> +1 (up to MAX_ADC_VALUE).
-- If comparator_i='0' at strb_i='1' -> -1 (down to MIN_ADC_VALUE).
-- Else (no strobe) -> hold.
entity ADC_Value is
	
	port(
		clk_i		: in std_ulogic;
		reset_i		: in std_ulogic;    -- async, active-HIGH reset
		comparator_i	: in std_ulogic;    -- decision bit (1=increment, 0=decrement)
		strb_i		: in std_ulogic;    -- update strobe (one cycle)
		adc_value_o	: out unsigned(LENGTH-1 downto 0)    -- registered accumulator output
	);
end entity ADC_Value;

  -- Registered state and its next value
  -- (Initialized to all '1' for simulation; reset will set to 0 in hardware.)
architecture ADC_Value_behav of ADC_Value is
	
	signal adc_value_state 		: unsigned(LENGTH-1 downto 0) := (others => '1');
	signal next_adc_value		: unsigned(LENGTH-1 downto 0) := (others => '1');
		
	begin
  ---------------------------------------------------------------------------
  -- State register: async reset clears to 0; otherwise load next on rising edge
  ---------------------------------------------------------------------------
	reg_proc: process(reset_i, clk_i) is
	begin
		if reset_i = '1' then	
			adc_value_state <= (others => '0');
		elsif rising_edge(clk_i) then
			adc_value_state <= next_adc_value;
		end if;
	end process;
  ---------------------------------------------------------------------------
  -- Next-state & output:
  --  - default: hold current value
  --  - on strobe: +1 if comparator_i='1' (cap at MAX), else -1 (floor at MIN)
  ---------------------------------------------------------------------------
	adc_value_proc: process(comparator_i, strb_i, adc_value_state) is
	begin
	    -- by default, hold value between strobes	
		next_adc_value <= adc_value_state;
		
		if strb_i = '1' then
			if comparator_i = '1' then   -- increment with saturation at MAX
				if adc_value_state = MAX_ADC_VALUE then
					next_adc_value <= adc_value_state;
				else
					next_adc_value <= adc_value_state+1;
				end if;
			else          -- decrement with saturation at MIN
				if adc_value_state = MIN_ADC_VALUE then
					next_adc_value <= adc_value_state;
				else
					next_adc_value <= adc_value_state-1;
				end if;
			end if;
		else
			next_adc_value <= adc_value_state;
		end if;      -- drive registered output
		adc_value_o <= adc_value_state;
	end process;
end architecture ADC_Value_behav;
			
