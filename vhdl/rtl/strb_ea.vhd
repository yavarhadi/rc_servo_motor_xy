library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.all;
use std_definitions.all;

entity strb_generator is
	port(
		clk_i		: in std_ulogic;
		reset_i		: in std_ulogic;
		strb_o		: out std_ulogic
	);

end entity strb_generator;

architecture strb_generator_behav of strb_generator is
	
	signal strb_cnt				: unsigned(STRB_COUNTER_LEN-1 downto 0) := (others => '0');
	signal next_strb_cnt		: unsigned(STRB_COUNTER_LEN-1 downto 0) := (others => '0');
	signal strb_cnt_out			: std_ulogic;
	
	begin
			
		reg_proc: process(clk_i, reset_i) is
		begin
			if reset_i = '1' then
				strb_cnt <= (others => '0');
			elsif rising_edge(clk_i) then
				strb_cnt <= next_strb_cnt;
			end if;
		end process;
		
		strb_gen: process(strb_cnt) is
		begin
			next_strb_cnt <= strb_cnt;
			
			if strb_cnt < MAX_COUNTER_50HZ-1 then
				strb_cnt_out <= '0';
				next_strb_cnt <= strb_cnt + 1;
			else
				strb_cnt_out <= '1';
				next_strb_cnt <= (others => '0');
			end if;
		strb_o <= strb_cnt_out;
		end process;
end architecture strb_generator_behav;
				
			
				
	

