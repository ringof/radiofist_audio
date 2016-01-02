-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See LICENCE.txt for details
--
-- clock signals where syncronization and distribuion are needed
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clock is
	port (
		clk_in : in STD_LOGIC;
		reset : in STD_LOGIC;
		clk_6mhz : out STD_LOGIC;
		decimation_clk : out STD_LOGIC
	);
end clock;

architecture RTL of clock is

	component dcm_6
		port (
			CLK_IN1 : in STD_LOGIC;
			CLK_ADC : out STD_LOGIC;
			DEC_CLK : out STD_LOGIC;
			RESET : in STD_LOGIC
		);
	end component;

	signal dec_clk_i : STD_LOGIC;
	signal toggle : STD_LOGIC;
	signal counter : integer range 0 to 42 := 0;
 
begin
	sample_clock : dcm_6
	port map(
		CLK_IN1 => clk_in, 
		CLK_ADC => clk_6mhz, 
		DEC_CLK => dec_clk_i, 
		RESET => reset
	);

