-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See LICENCE.txt for details
-- 
-- core module of project; most functionality is under this module 
-- in the hierarchy; only signal conversion and debounce is 
-- handled seperately in io_pads - both are under the top module

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity core is
	port (
		din : in STD_LOGIC;
		dout : out STD_LOGIC;
		clkin : in STD_LOGIC;
		reset : in STD_LOGIC;
		test : inout STD_LOGIC_VECTOR (7 downto 0)
	);
end core;

architecture RTL of core is

	component clock is
		port (
			clk_in : in STD_LOGIC;
			reset : in STD_LOGIC;
			clk_6mhz : out STD_LOGIC
		);
	end component clock;

	component sigma_delta_adc is
		port (
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			comp : out STD_LOGIC;
			one_bit_adc : out STD_LOGIC;
			one_bit_dac : out STD_LOGIC
		); 
	end component sigma_delta_adc;

	component sinc3_filter is
		port (
			reset : in STD_LOGIC;
			one_bit_adc_in : in STD_LOGIC;
			clk : in STD_LOGIC;
			decimation_clk : in STD_LOGIC;
			output : out STD_LOGIC_VECTOR (24 downto 0)
		); 
	end component sinc3_filter;

	component fir_filter_wrapper is
		port (
			din : in STD_LOGIC_VECTOR(23 downto 0);
			dout : out STD_LOGIC(9 downto 0);
			reset : in STD_LOGIC;
			clk : in STD_LOGIC
		);
	end component fir_filter_wrapper;

	component sigma_delta_dac is
		port (
			din : in STD_LOGIC_VECTOR(9 downto 0);
			dout : out STD_LOGIC;
			reset : in STD_LOGIC;
			clk : in STD_LOGIC
		);
	end component sigma_delta_dac;

	signal one_bit_adc_i : STD_LOGIC;
	signal decimation_clock_i : STD_LOGIC;
	signal sinc3_filter_output : STD_LOGIC_VECTOR(24 downto 0);

begin
	adc_clock : clock
	port map(
		clk_in => clk_in, 
		reset => reset, 
		clk_6mhz => clk_6mhz
	);
 
	sigma_delta_adc1 : sigma_delta_adc
	port map(
		clk => ADC_CLK, 
		reset => RESET, 
		comp => comp_out, 
		one_bit_adcc => one_bit_adc_i, 
		one_bit_dac => ADC_SD_DAC_OUT
	);

	sinc3_filter1 : sinc3_filter
	port map(
		reset => RESET, 
		one_bit_adc_in => one_bit_adc_i, 
		clk => ADC_CLK, 
		decimation_clk => decimation_clock_i, 
		output => sinc3_filter_output
	); 

	adc_fir_lowpass : fir_filter_wrapper
	port map(
		din => sinc3_filter_output, 
		dout => open, 
		reset => RESET, 
		clk => decimation_clock_i
	);

	sigma_delta_dac1 : sigma_delta_dac
	port map(
		din => open, 
		dout => open, 
		reset => RESET, 
		clk => clk
	);

end RTL;
