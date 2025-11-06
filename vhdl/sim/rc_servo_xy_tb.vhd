library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;

entity rc_servo_xy_tb is
    end entity rc_servo_xy_tb;

architecture rtl_tb of rc_servo_xy_tb is

    signal clk_i                      	 : std_ulogic;
    signal reset_i                    	 : std_ulogic;
    signal comp_async_x_i              	 : std_ulogic;
	signal comp_async_y_i              	 : std_ulogic;
	signal pwm_x_o						 : std_ulogic;
	signal pwm_y_o						 : std_ulogic;
	
	signal pwm_servo_x_o				 : std_ulogic;
	signal pwm_servo_y_o				 : std_ulogic;
--clock period
constant clk_period : time := 1 sec/CLK_FREQUENCY; 		        -- 50 MHz -> 20 ns


begin
            Delta_ADC_port: entity rc_servo_xy(rtl_rc_servo_xy)
                        port map(
                                    clk_i => clk_i,
                                    reset_i => reset_i,
                                    comp_async_x_i => comp_async_x_i,
									comp_async_y_i => comp_async_y_i,
									pwm_x_o => pwm_x_o,
									pwm_y_o => pwm_y_o,
									pwm_pin_x_o => pwm_servo_x_o,
									pwm_pin_y_o => pwm_servo_y_o
									
                        );

                clk_process: process
                begin
                    clk_i <= '0';
                    wait for clk_period/2;
                    clk_i <= '1';
                    wait for clk_period/2;
                end process;
    
                reset_process: process
                begin
                    reset_i <= '0';
                    wait for 10 ns;
					reset_i <= '1';
					wait;
                end process;
				
				x_comp_async_process: process
				begin
					comp_async_x_i <= '1';
					wait for 3000 ms;
					comp_async_x_i <= '0';
					wait for 4000 ms;
				end process;
				
				y_comp_async_process: process
				begin
					comp_async_y_i <= '0';
					wait;
				end process;
				
end architecture rtl_tb;
