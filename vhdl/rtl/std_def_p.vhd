library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
-- ============================================================================
--  std_definitions: Centralized timing, sizes, and limits for the RC-servo SoC
-- ============================================================================
package std_definitions is
    --------------------------------------------------------------------------
    -- Global clock & base periods
    --------------------------------------------------------------------------
	constant CLK_FREQUENCY		: natural := 50e6;
	constant MAX_COUNTER_50HZ	: natural := 1000000;
	constant MAX_COUNTER_200kHZ	: natural := 250;
    --------------------------------------------------------------------------
    -- Strobe generator sizing
    --------------------------------------------------------------------------
    -- bit width to count up to 1_000_000-1 (≈20 bits). Used for strobe/50 Hz domains.
	--Strobe Generator
	constant CLK_COUNTER		: natural := natural(ceil(log2(real(MAX_COUNTER_50HZ))));
    --------------------------------------------------------------------------
    -- Delta-mod code range (matches fast PWM period for 1 LSB ≈ 0.4% duty)
    --------------------------------------------------------------------------	
	--ADC Value
	constant MAX_ADC_VALUE          : natural := 250;	
    constant MIN_ADC_VALUE          	: natural := 0;
	--Length     -- Data-path width for ADC/delta/filter chain (fits 0..250 → 8 bits)
	constant LENGTH			: natural := natural(ceil(log2(real(MAX_ADC_VALUE))));
    --------------------------------------------------------------------------
    -- PWM counter widths (carrier and 50 Hz frame)
    --------------------------------------------------------------------------
	-- width for fast PWM counter (0..249 → 8 bits)
	-- width for 50 Hz frame counter (0..999_999 → ~20 bits)
	constant PERIOD_COUNTER_PWM_LEN 	: natural := natural(ceil(log2(real(MAX_COUNTER_200kHZ))));
        constant PWM_COUNTER_LEN  		: natural := natural(ceil(log2(real(MAX_COUNTER_50HZ))));
    --------------------------------------------------------------------------
    -- DeltaADC / strobe domain width
    --------------------------------------------------------------------------
	 -- reuse the 50 Hz domain width for strobe pacing counters
	--deltaADC
	constant STRB_COUNTER_LEN 		: natural := CLK_COUNTER;
    --------------------------------------------------------------------------
    -- Moving-average filter configuration
    --------------------------------------------------------------------------	
	--filter shift register
	constant N			  	: natural := 4;
    --------------------------------------------------------------------------
    -- Tilt mapping thresholds (code→pulse width clamp/knees)
    -- Example comments: 3.3V ≈ 250, 1.95V ≈ 148, 1.35V ≈ 102
    --------------------------------------------------------------------------
	-- Tilt: 3.3V = 250, 1.95 = 148, 1.35 = 102
	constant MAX_COUNT_33V				: natural := 250;
	constant MAX_COUNT_18V				: natural := 148;
	constant MIN_COUNT_12V				: natural := 102;
		
	constant ADC_VALUE_LEN				: natural := natural(ceil(log2(real(MAX_COUNT_33V))));
	constant ON_counter_val_len 		: natural := natural(ceil(log2(real(MAX_COUNTER_50HZ))));

    --------------------------------------------------------------------------
    -- Servo timing targets (at 50 MHz clock)
    --------------------------------------------------------------------------	
	constant MAX_COUNT_1ms				: natural := 50000;   -- 1 ms = 50_000 ticks
    constant MAX_COUNT_2ms				: natural := 100000; -- 2 ms = 100_000 ticks
	
	constant MAX_COUNT_2ms_length		: natural := natural(ceil(log2(real(MAX_COUNT_2ms))));
end package std_definitions;
