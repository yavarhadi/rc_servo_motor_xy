library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use std_definitions.all;
-- Dual-channel delta-modulation front end:
--  - sync async comparator inputs (X/Y)
--  - per-axis DeltaADC: 8-bit integrator + 8-bit PWM (period=250)
--  - per-axis moving average on the code
--  - expose PWM (to off-chip RC+comparator) and filtered code+strobe (to slow path)
entity Delta_ADC_XY is
entity Delta_ADC_XY is
    port(
        clk_i                   : in std_ulogic;
        reset_i                 : in std_ulogic;
        comp_async_x_i          : in std_ulogic;   -- async comparator X
	comp_async_y_i          : in std_ulogic;   -- async comparator Y

	pwm_x_o			: out std_ulogic;  -- fast PWM to RC/comparator(X)
	pwm_y_o         	: out std_ulogic;  -- fast PWM to RC/comparator(Y)
	adc_valid_strb_x_o	: out std_ulogic;  -- strobe for filtered code (X)
	adc_valid_strb_y_o	: out std_ulogic;  -- strobe for filtered code (Y)
        adc_value_x_o		: out unsigned(Length-1 downto 0);  -- filtered 8-bit code (X)
        adc_value_y_o		: out unsigned(Length-1 downto 0)  -- filtered 8-bit code (Y)			
    );
end entity Delta_ADC_XY;

architecture rtl_Delta_ADC_XY of Delta_ADC_XY is  -- Shared strobe that paces the delta integrators
    signal strb_signal			: std_ulogic;
    signal comp_synch_x         : std_ulogic;     -- Synchronized comparator bits 
    signal comp_synch_y         : std_ulogic;
    signal adc_valid_strb_x		: std_ulogic;  -- Per-axis raw outputs from DeltaADC
    signal adc_valid_strb_y		: std_ulogic;	
    signal adc_value_x			: unsigned(LENGTH-1 downto 0);
    signal adc_value_y			: unsigned(LENGTH-1 downto 0);
	
    begin
	--  Strobe generator: defines the update rate for the delta integrators
		strb_generator_port: entity strb_generator(strb_generator_behav)
		port map(
				clk_i => clk_i,
				reset_i => reset_i,
				strb_o => strb_signal
		);
        -- Synchronize the async comparator inputs (CDC)
        synchronizer_port_X: entity synchronizer(rtl_synchronizer)
		generic map(STAGES => 1)
        port map(
                    clk_i => clk_i,
                    reset_i => reset_i,
                    async_i => comp_async_x_i,
                    sync_o => comp_synch_x
        );
		
		synchronizer_port_Y: entity synchronizer(rtl_synchronizer)
		generic map(STAGES => 1)
        port map(
                    clk_i => clk_i,
                    reset_i => reset_i,
                    async_i => comp_async_y_i,
                    sync_o => comp_synch_y
        );
        --Per-axis DeltaADC: ±1 LSB (0x00..0xFA) step each strobe, 8-bit PWM
        delta_adc_port_X: entity DeltaADC(DeltaADC_rtl)
        port map(
                   clk_i => clk_i,
                   reset_i => reset_i,
                   comparator_i => comp_synch_x,
				   strb_signal_i => strb_signal,
                   adc_valid_strb_o => adc_valid_strb_x,
				   pwm_o => pwm_x_o,
                   adc_value_o => adc_value_x
        );
		
        delta_adc_port_Y: entity DeltaADC(DeltaADC_rtl)
        port map(
                   clk_i => clk_i,
                   reset_i => reset_i,
                   comparator_i => comp_synch_y,
				   strb_signal_i => strb_signal,
                   adc_valid_strb_o => adc_valid_strb_y,
				   pwm_o => pwm_y_o,
                   adc_value_o => adc_value_y
        );
	--  Per-axis moving average (4-tap boxcar): smooths raw code
        --    Outputs a filtered code and a valid strobe aligned to it.	
		moving_average_x_port: entity moving_average(moving_average_rtl)
		port map(
		
					clk_i => clk_i,
					reset_i => reset_i,		
					strb_data_valid_i => adc_valid_strb_x,
					data_i => adc_value_x,
					strb_data_valid_o => adc_valid_strb_x_o,
					data_o => adc_value_x_o
				);
				
		moving_average_y_port: entity moving_average(moving_average_rtl)
		port map(
		
					reset_i => reset_i,		
					clk_i => clk_i,
					strb_data_valid_i => adc_valid_strb_y,
					data_i => adc_value_y,
					strb_data_valid_o => adc_valid_strb_y_o,
					data_o => adc_value_y_o
				);
    end architecture rtl_Delta_ADC_XY;
