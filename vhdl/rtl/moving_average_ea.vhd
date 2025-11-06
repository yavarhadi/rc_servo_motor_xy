library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;
-- N-point moving average filter.(N=4 here)
-- - Samples are accepted only when strb_data_valid_i='1'.
-- - A tapped delay line (N x filter_shift_register) holds the last N samples.
-- - Sum the N samples into a widened accumulator.
-- - Output the average by shifting right by ceil(log2(N)).
--   NOTE: exact only when N is a power of two. Otherwise it's a scaled approximation.
entity moving_average is
    port(
        clk_i               : in  std_ulogic;
        reset_i             : in  std_ulogic;
        strb_data_valid_i   : in  std_ulogic;
        data_i              : in  unsigned(LENGTH-1 downto 0);

        strb_data_valid_o   : out std_ulogic;
        data_o              : out unsigned(LENGTH-1 downto 0)
    );
end entity moving_average;

architecture moving_average_rtl of moving_average is
    -- helper: ceil(log2(N))
    function clog2(x : natural) return natural is
        variable v : natural := 0;
    begin
        if x <= 1 then
            return 0;
        end if;
        while 2**v < x loop
            v := v + 1;
        end loop;
        return v;
    end function;

    constant SUM_EXTRA_BITS 		: natural := clog2(N);
	--constant SUM_EXTRA_BITS			: natural := 4;
    constant SUM_WIDTH 				: natural := LENGTH + SUM_EXTRA_BITS;

    subtype sum_t is unsigned(SUM_WIDTH-1 downto 0);

    type moving_average_array is array (0 to N-1) of unsigned(LENGTH-1 downto 0);

    -- Die shift-register-Instanzen, die die letzten N Werte halten:
    signal moving_average_value : moving_average_array := (others => (others => '0'));

    -- Ausgänge und Hilfssignale (register)
    signal data_o_reg            : unsigned(LENGTH-1 downto 0) := (others => '0');
    signal strb_data_valid_o_reg : std_ulogic := '0';

begin
  -----------------------------------------------------------------------------
  -- Tapped delay line (N registers), each loads on strb_data_valid_i
  -----------------------------------------------------------------------------
    -- Erzeuge N Schieberegister-Instanzen wie in deinem ursprünglichen Code.
    -- (Ich nehme an, existiert entity filter_shift_register mit passenden Ports)
	-- angenommen: N >= 1
	-- Erster Eintrag (i = 0)
	gen_reg_0: if N >= 1 generate
		register_i0: entity filter_shift_register(rtl_filter_shift)
			port map(
				clk_i => clk_i,
				reset_i => reset_i,
				strb_data_valid_i => strb_data_valid_i,
				data_i => data_i,
				data_o => moving_average_value(0)
			);
	end generate gen_reg_0;
	-- Rest (i = 1 .. N-1)
	gen_reg_rest: if N > 1 generate
		gen_regs: for i in 1 to N-1 generate
			register_i: entity filter_shift_register(rtl_filter_shift)
				port map(
					clk_i => clk_i,
					reset_i => reset_i,
					strb_data_valid_i => strb_data_valid_i,
					data_i => moving_average_value(i-1),
					data_o => moving_average_value(i)
				);
		end generate gen_regs;
	end generate gen_reg_rest;
  -----------------------------------------------------------------------------
  -- Synchronous accumulation and averaging
  --  - Registered outputs
  --  - Only compute new average when a new sample is accepted
  -----------------------------------------------------------------------------
    -- Berechnung der Summe & Durchschnitt synchron (sicher & synthesizable)
    proc_avg: process(clk_i)
        variable acc_int : sum_t;
        variable avg_int : integer;
    begin
        if rising_edge(clk_i) then
            if reset_i = '1' then
                data_o_reg            <= (others => '0');
                strb_data_valid_o_reg <= '0';
            else
                -- Default: durchreichen des Valid-Strobes (oder registered version)
                strb_data_valid_o_reg <= strb_data_valid_i;

                if strb_data_valid_i = '1' then
                    -- Akkumulieren mit Variablen (keine Signalzuweisungs-Problem)
                    acc_int := (others => '0');
                    for i in 0 to N-1 loop
                        -- resize jedes Sample auf SUM_WIDTH bevor Addition
                        acc_int := acc_int + resize(moving_average_value(i), SUM_WIDTH);
                    end loop;

                    -- sicherstellen, dass der Wert in LENGTH Bits passt (ggf. saturieren)
                    --data_o_reg <= resize( shift_right(acc_int, SUM_EXTRA_BITS), LENGTH );
					data_o_reg <= resize(shift_right(acc_int, SUM_EXTRA_BITS), LENGTH);
                end if;
            end if;
        end if;
    end process;

    -- Ausgänge
    data_o <= data_o_reg;
    strb_data_valid_o <= strb_data_valid_o_reg;
end architecture moving_average_rtl;


