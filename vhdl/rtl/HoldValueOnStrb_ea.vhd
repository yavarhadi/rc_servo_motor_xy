library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;

entity holdValueOnStrb is 
    port(
        clk_i			: in std_ulogic;
	reset_i			: in std_ulogic;
	adc_valid_strb_i      : in std_ulogic;     -- 1-cycle "new sample valid" strobe
        adc_value_i           : in unsigned(LENGTH-1 downto 0);    -- data to capture on strobe

        holdValue_o           : out unsigned(LENGTH-1 downto 0)    -- registered output

    );
end entity holdValueOnStrb;

architecture rtl_holdValueOnStrb of holdValueOnStrb is
	 -- Registered storage and its next value
	signal holdValue		: unsigned(LENGTH-1 downto 0) := (others => '0');
	signal next_holdValue	: unsigned(LENGTH-1 downto 0) := (others => '0');
	
	begin
	  -- Register process: asynchronous reset, otherwise load next state on rising clock.	
	reg_process: process(clk_i, reset_i) is
		begin
			if reset_i = '1' then
				holdValue <= (others => '0');
			elsif rising_edge(clk_i) then
				holdValue <= next_holdValue;
			end if;
		end process;
	 -- Next-state and output logic:
         -- Default is "hold"; on a valid strobe, capture the incoming value.
	hold_process: process(adc_valid_strb_i, adc_value_i, holdValue) is
	 begin
				next_holdValue <= holdValue;
				
                if adc_valid_strb_i = '1' then
					next_holdValue <= adc_value_i; -- load it into the register on next clock
				end if;
				holdValue_o <= holdValue;
            end process;
			
	end architecture;
