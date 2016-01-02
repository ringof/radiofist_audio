-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See LICENCE.txt for details

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fir_filter_wrapper is
	port (
		din : in STD_LOGIC_VECTOR(23 downto 0);
		dout : out STD_LOGIC_VECTOR(9 downto 0);
		reset : in STD_LOGIC;
		clk : in STD_LOGIC
	);
end fir_filter_wrapper;

architecture RTL of fir_filter_wrapper is

	component fir_filter
		generic (
			MSBI : integer := 7; --Most significant bit of FIR input
			MSBO : integer := 9 --Most significant bit of FIR output
		);
		port (
			DIN : in STD_LOGIC_VECTOR(MSBI downto 0);
			DOUT : out STD_LOGIC_VECTOR(MBSO downto 0);
			CLK : in STD_LOGIC;
			SCLR : in STD_LOGIC;
			RFD : out STD_LOGIC;
			RDY : out STD_LOGIC
		);
	end component;

begin
	fir_filter1 : fir_filter
	port map(
		DIN => din, 
		DOUT => dout, 
		CLK => clk, 
		SCLR => reset, 
		RFD => open, 
		RDY => open
	);
 
end RTL;
