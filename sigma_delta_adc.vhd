-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See licence.txt for details

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sigma_delta_adc is
   port ( 
		clk 				: in STD_LOGIC;
		reset				: in STD_LOGIC;
		din				: in STD_LOGIC;
		dout				: out STD_LOGIC;
		feedback			: out STD_LOGIC
		);
			  
end sigma_delta_adc;

architecture RTL of sigma_delta_adc is

signal clk_i 			: STD_LOGIC;
signal dout_i 			: STD_LOGIC;
signal feedback_i		: STD_LOGIC;


begin 
	 
	--Sample the output of the LVDS comparator
	adc_sampler: process(reset, clk, din, dout_i)
   begin
	  if reset = '1' then
			dout <= '0';
	  elsif rising_edge(clk) then
			dout <= din;
			dout_i <= din;
	  end if;
   end process adc_sampler;
		
	--Sample the output of the one_bit ADC for input feedback loop
	dac_output: process(reset, clk, dout_i)
   begin
	  if reset = '1' then
		 feedback <= '0';
	  elsif rising_edge(clk) then
		 feedback <= dout_i;
	  end if;
   end process dac_output;

end RTL;