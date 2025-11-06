library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;
-- Generic PWM:
-- - Period length in clocks = Period_counter_val_i
-- - High-time in clocks     = ON_counter_val_i
-- Output is '1' while clk_cnt < ON_counter_val_i, else '0'.
entity PWM is
	port(
		clk_i			: in std_ulogic;
		reset_i			: in std_ulogic;
		Period_counter_val_i	: in unsigned(PERIOD_COUNTER_PWM_LEN-1 downto 0); -- frame length (clocks)
		ON_counter_val_i	: in unsigned(LENGTH-1 downto 0); --high-time (clocks)
			
		PWM_pin_o		: out std_ulogic   -- PWM output
	);
end entity PWM;

architecture pwm_behav of PWM is
  -- Counter and its next-state; initialize for simulation 
	signal clk_cnt, next_clk_cnt	: unsigned(PERIOD_COUNTER_PWM_LEN-1 downto 0) := (others => '0');
	signal pwm_output				: std_ulogic := '0';
	
  -- Cast ON_counter to counter width (avoids width-mismatch in compares)	
	begin
	-- Drive output
		PWM_pin_o <= pwm_output;
  ---------------------------------------------------------------------------
  -- Counter register: async reset, otherwise advance each rising clock
  ---------------------------------------------------------------------------	
		reg_proc: process(reset_i, clk_i) is
		begin
			if (reset_i = '1') then
				clk_cnt <= (others => '0');
			elsif rising_edge(clk_i) then
				clk_cnt <= next_clk_cnt;
			end if;
		end process;
  ---------------------------------------------------------------------------
  -- Next-state and output logic:
  --  - pwm_output = '1' while clk_cnt < ON_counter_val_i
  --  - clk_cnt wraps to 0 after reaching Period_counter_val_i-1
  ---------------------------------------------------------------------------
		calc_proc: process(Period_counter_val_i, ON_counter_val_i, clk_cnt) is
			begin
				next_clk_cnt <= clk_cnt;
				
				if clk_cnt < ON_counter_val_i then
					pwm_output <= '1';
				else
					pwm_output <= '0';
				end if;
				
				if clk_cnt < Period_counter_val_i-1 then
					next_clk_cnt <= clk_cnt + 1;
				else
					next_clk_cnt <= (others => '0');
				end if;
		end process;		
end architecture pwm_behav;
