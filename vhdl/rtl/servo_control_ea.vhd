library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;

entity servo_control is
	port(
			clk_i					: in std_ulogic;
			reset_i					: in std_ulogic;
			Period_counter_val_i	: in unsigned(PWM_COUNTER_LEN-1 downto 0);
			ON_counter_val_i		: in unsigned(MAX_COUNT_2ms_length-1 downto 0);
			
			pwm_pin_o				: out std_ulogic
	);
end entity servo_control;

architecture rtl_servo_control of servo_control is
	
	signal clk_cnt 				: unsigned(PWM_COUNTER_LEN-1 downto 0) := (others => '0');
	signal next_clk_cnt 		: unsigned(PWM_COUNTER_LEN-1 downto 0) := (others => '0');
	
begin	
	reg_proc : process(reset_i, clk_i) is
	begin	
		if (reset_i = '1') then
			clk_cnt <= (others => '0');			
		elsif rising_edge(clk_i) then
			clk_cnt <= next_clk_cnt;
		end if;
	end process;
			
	calc_proc : process(Period_counter_val_i, ON_counter_val_i, clk_cnt) is
		
	begin
		next_clk_cnt <= clk_cnt;

				if clk_cnt < ON_counter_val_i then
					PWM_pin_o <= '1';
				else
					PWM_pin_o <= '0';
				end if;
				
				if clk_cnt < Period_counter_val_i-1 then
					next_clk_cnt <= clk_cnt + 1;
				else
					next_clk_cnt <= (others => '0');
				end if;
	end process;
end architecture rtl_servo_control;