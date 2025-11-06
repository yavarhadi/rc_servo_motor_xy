library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity dff is
	port(
		clk_i		: in std_ulogic;
		reset_i		: in std_ulogic;
		d_i			: in std_ulogic;
		q_o			: out std_ulogic
	);
end entity;

architecture dff_rtl of dff is

begin
	reg_proc: process(reset_i, clk_i) is
	begin
		if reset_i = '1' then
			q_o <= '0';
		elsif rising_edge(clk_i) then
			q_o <= d_i;
		end if;
	end process;
end architecture dff_rtl;