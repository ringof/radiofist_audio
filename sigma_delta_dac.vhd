-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See LICENCE.txt for details
--
-- an implementation of a 2nd order sigma-delta DAC
-- see Texas Instruments App Note  

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity sigma_delta_dac is
	generic (
		MSBI : integer := 7
	); --Most significant bit of DAC input
	port (
		din : in STD_LOGIC_VECTOR (MSBI downto 0);
		dout : out STD_LOGIC;
		clk : in STD_LOGIC;
		reset : in STD_LOGIC
	);
end sigma_delta_dac;

architecture RTL of sigma_delta_dac is

	signal delta_adder : STD_LOGIC_VECTOR ((MSBI + 2) downto 0);
	signal sigma_adder : STD_LOGIC_VECTOR ((MSBI + 2) downto 0);
	signal sigma_latch : STD_LOGIC_VECTOR ((MSBI + 2) downto 0);
	signal delta_B : STD_LOGIC_VECTOR ((MSBI + 2) downto 0);

begin
	-- process to move data through the sigma-delta loop and output
	dac : process (reset, clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				sigma_latch <= '1' & (others => '0');
				dout <= '0';
			else
				sigma_latch <= sigma_adder;
				dout <= sigma_latch(MSBI + 2);
			end if;
		end if;
	end process;
 
	-- Sigma-Delta DAC feedback functions
	delta_adder <= din + delta_B;
	sigma_adder <= delta_adder + sigma_latch;
	delta_B <= sigma_adder(MSBI + 2) & sigma_adder(MSBI + 2) & (others => '0');

end RTL;
