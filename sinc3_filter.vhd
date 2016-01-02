-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See LICENCE.txt for details
--
-- Implementation is derived from p. 17 of Texas Instruments SBAA094

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity sinc3_filter is
	port (
		reset : in STD_LOGIC;
		din : in STD_LOGIC;
		in_clk : in STD_LOGIC;
		out_clk : in STD_LOGIC;
		dout : out STD_LOGIC_VECTOR (24 downto 0)
	);
end sinc3_filter;

architecture RTL of sinc3_filter is

	signal DN0, DN1, DN3, DN5 : STD_LOGIC_VECTOR(24 downto 0);
	signal CN1, CN2, CN3, CN4 : STD_LOGIC_VECTOR(24 downto 0);
	signal DELTA1 : STD_LOGIC_VECTOR(24 downto 0);

begin
	-- process to clock in the sigma-delta bit stream into the first
	-- integrator of filter
	-- Clocked at orignal sample frequency
	sd_stream_in : process(din, in_clk, reset)
	begin
		if reset = '1' then
			DELTA1 <= (others => '0');
		elsif rising_edge(in_clk) then
			if din = '1' then
				DELTA1 <= DELTA1 + 1;
			end if;
		end if;
	end process;
 
	-- process to move data and apply integration through
	-- the successive two integrators of filter
	-- Clocked at original sample frequency
	sd_integration : process(in_clk, reset)
	begin
		if reset = '1' then
			CN1 <= (others => '0');
			CN2 <= (others => '0');
		elsif rising_edge(in_clk) then
			CN1 <= CN1 + DELTA1;
			CN2 <= CN2 + CN1;
		end if;
	end process;
 
	-- process to decimate and move data through the three differentiators
	-- Clock at downsampling frequency
	sd_differentiation : process(reset, out_clk)
	begin
		if reset = '1' then
			DN0 <= (others => '0');
			DN1 <= (others => '0');
			DN3 <= (others => '0');
			DN5 <= (others => '0');
		elsif rising_edge(out_clk) then
			DN0 <= CN2;
			DN1 <= DN0;
			DN3 <= CN3;
			DN5 <= CN4;
		end if;
	end process;

	-- Differentiation functions for filter
	CN3 <= DN0 - DN1;
	CN4 <= CN3 - DN3;
	dout <= CN4 - DN5;

end RTL;
