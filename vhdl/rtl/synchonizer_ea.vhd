library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;

entity synchronizer is
  generic ( STAGES : positive);
  port(
    clk_i   : in  std_ulogic;
    reset_i : in  std_ulogic;  -- active-low, synchronous
    async_i : in  std_ulogic;
    sync_o  : out std_ulogic
  );
end entity synchronizer;

architecture rtl_synchronizer of synchronizer is

	signal sync_reg : std_ulogic_vector(STAGES-1 downto 0) := (others => '0');
	begin
		process(clk_i)
		begin
			if reset_i = '1' then
				sync_reg <= (others => '0');
			elsif rising_edge(clk_i) then
				sync_reg(0) <= async_i;
				for i in 1 to STAGES-1 loop
					sync_reg(i) <= sync_reg(i-1);
				end loop;
			end if;
	end process;

	sync_o <= sync_reg(STAGES-1);
end architecture rtl_synchronizer;