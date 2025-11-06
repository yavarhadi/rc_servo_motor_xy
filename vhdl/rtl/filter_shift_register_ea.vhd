library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;

-- Strobe-gated 1-sample storage element (used as a tap in the FIR/moving-average).
-- On each rising edge of clk_i:
--   - If reset_i='1'  -> output clears to 0.
--   - Else if strb_data_valid_i='1' -> load new sample data_i.
--   - Else               -> hold previous value.
entity filter_shift_register is
	port(
		clk_i			: in std_ulogic;    -- system clock
		reset_i			: in std_ulogic;    -- active-HIGH reset
		strb_data_valid_i	: in std_ulogic;    --sample advance strobe
		data_i			: in unsigned(Length-1 downto 0);  -- new sample
			
		data_o			: out unsigned(Length-1 downto 0) -- registered/held sample
	);
end entity filter_shift_register;

architecture rtl_filter_shift of filter_shift_register is
-- Registered state and next-state of the sample
	signal data, next_data		: unsigned(Length-1 downto 0);
	
	begin
  ---------------------------------------------------------------------------
  -- State register: synchronous load/hold, synchronous clear via reset_i
  ---------------------------------------------------------------------------		
		reg_process: process(clk_i, reset_i) is
			begin
				if reset_i = '1' then
					data <= (others => '0');
				elsif rising_edge(clk_i) then
					data <= next_data;
				end if;
			end process;
  ---------------------------------------------------------------------------
  -- Next-state logic:
  --   default: hold current 'data'
  --   when strb_data_valid_i='1': load new sample 'data_i'
  ---------------------------------------------------------------------------			
		filter_process: process(strb_data_valid_i, data_i, data) is
			begin
				next_data <= data;
				
				if(strb_data_valid_i = '1') then
					next_data <= data_i;
				else
					next_data <= data;
				end if;
			end process;
  -- Drive output with the registered value
			data_o <= data;
			
end architecture rtl_filter_shift;
