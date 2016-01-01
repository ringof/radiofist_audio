-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See licence.txt for details

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity papilio_io_pads is
    port ( 
		CLK_IN 				: in  	STD_LOGIC;
      LVDS_P 				: in  	STD_LOGIC;
      LVDS_N 				: in  	STD_LOGIC;
      RESET 				: in  	STD_LOGIC;
      COMP_OUT 			: out  	STD_LOGIC;
      ADC_OUT				: out  	STD_LOGIC;
      ADC_SD_DAC_OUT 	: out  	STD_LOGIC;
      CLK_ADC 				: out  	STD_LOGIC
	);
end top;


end papilio_io_pads;

architecture RTL of papilio_io_pads is

begin


end RTL;

