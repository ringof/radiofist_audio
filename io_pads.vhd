-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See LICENCE.txt for details
--
-- Signal conversion and debounce

library UNISIM;
library IEEE;
use UNISIM.VComponents.all;
use IEEE.STD_LOGIC_1164.ALL;

entity io_pads is
    port (
	    clk 				: in    STD_LOGIC;
		clk_i				: out   STD_LOGIC;
        lvds_p 				: in    STD_LOGIC;
        lvds_n 				: in    STD_LOGIC;
		comp_i				: out   STD_LOGIC;
        reset				: in    STD_LOGIC;
		reset_i				: out   STD_LOGIC;
		adc_fb				: out   STD_LOGIC;
		adc_fb_i			: in    STD_LOGIC;
		dac_out				: out   STD_LOGIC;
		dac_out_i			: in    STD_LOGIC;
		test				: inout STD_LOGIC_VECTOR(7 downto 0);
		test_i				: inout STD_LOGIC_VECTOR(7 downto 0)
		);		
end io_pads;

architecture RTL of io_pads is

component IBUFDS is 
    generic (IOSTANDARD : string); 
		port(	
			I : in STD_LOGIC; 
			IB: in STD_LOGIC; 
			O : out STD_LOGIC
			); 		
end component; 
	
begin

-- Converts difference between LVDS inputs into a STD_LOGIC signal
LVDS_buf : IBUFDS
    generic map (
	    DIFF_TERM       => TRUE,
        IBUF_LOW_PWR    => TRUE,
        IOSTANDARD      => "LVDS25"
		)
     port map (
        I   => lvds_p,
        IB  => lvds_n,
        O   => comp_i
		);

-- Signal pass-throughs

clk_i       <=  clk;
reset_i     <=  reset;
adc_fb_i    <=  adc_fb;
dac_out_i 	<=  dac_out;
test_i		<=  test;

end RTL;

