library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;
use std_definitions.all;
entity tilt is
    port(
	clk_i					 : in std_ulogic;
	reset_i					 : in std_ulogic;
        hold_value_i             : in unsigned(LENGTH-1 downto 0);

        ON_counter_val_o        : out unsigned(MAX_COUNT_2ms_length-1 downto 0)
	--ON_counter_val_o         : out unsigned(31 downto 0)
    );
end entity tilt;
architecture rtl_tilt of tilt is
	signal on_value		: unsigned(MAX_COUNT_2ms_length-1 downto 0) := (others => '0');
	signal next_on_value	: unsigned(MAX_COUNT_2ms_length-1 downto 0) := (others => '0');  
    begin
	reg_process: process(clk_i, reset_i) is
		begin
			if reset_i = '1' then
				on_value <= (others => '0');
			elsif rising_edge(clk_i) then
				on_value <= next_on_value;
			end if;
		end process;
	  -- Combinational mapping: hold_value_i  →  next_on_value
  -- Piecewise behavior:
  --  * below MIN_COUNT_12V : clamp to 1.0 ms
  --  * above MAX_COUNT_18V : clamp to 2.0 ms
  --  * exact mid code 125  : force 1.5 ms
  --  * otherwise           : linear map from code to ON-time
	hold_value_process: process(hold_value_i, on_value) is
		begin
			next_on_value <= on_value;
    -- Low clamp: command below lower threshold → 1.0 ms pulse
            if hold_value_i < to_unsigned(MIN_COUNT_12V, hold_value_i'length) then
                next_on_value <= to_unsigned(MAX_COUNT_1ms, on_value'length);
    -- High clamp: command above upper threshold → 2.0 ms pulse
            elsif hold_value_i >= to_unsigned(MAX_COUNT_18V, hold_value_i'length) then
                next_on_value <= to_unsigned(MAX_COUNT_2ms, on_value'length);
    -- Optional exact center: code 125 → 1.5 ms pulse (75_000 @ 50 MHz)
			elsif hold_value_i = to_unsigned(125, hold_value_i'length) then
				next_on_value <= to_unsigned(75000, on_value'length);		
            else
        -- resizes keep arithmetic widths safe; constants are clock-dependent.
                next_on_value <= to_unsigned(50000, on_value'length) + resize((resize(hold_value_i,12) - to_unsigned(MIN_COUNT_12V,12))*to_unsigned(1087,12),on_value'length); --convert from Volt to sec
            end if;
			ON_counter_val_o <= on_value;
        end process;
 end architecture rtl_tilt;
