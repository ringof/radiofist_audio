-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See LICENCE.txt for details

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port ( 
        clk                 : in    STD_LOGIC;
        lvds_p 				: in    STD_LOGIC;
        lvds_n 				: in    STD_LOGIC;
        reset               : in    STD_LOGIC;
        adc_fb				: out   STD_LOGIC;
        dac_out				: out   STD_LOGIC;				
		test                : inout STD_LOGIC_VECTOR(7 downto 0)
	    );
end top;

architecture RTL of top is

component core is 
    port (
        adc_in              : in    STD_LOGIC;
        adc_fb              : out   STD_LOGIC;
        dac_out             : out   STD_LOGIC;
        clk                 : in    STD_LOGIC;
        reset               : in    STD_LOGIC;
        test                : inout STD_LOGIC_VECTOR (7 downto 0)
		);
end component clock;

component io_pads is
    port (
        clk                 : in    STD_LOGIC;
        clk_i               : out   STD_LOGIC;
        lvds_p              : in    STD_LOGIC;
        lvds_n              : in    STD_LOGIC;
        comp_i              : out   STD_LOGIC;
        reset               : in    STD_LOGIC;
        reset_i             : out   STD_LOGIC;
        adc_fb              : out   STD_LOGIC;
        adc_fb_i            : in    STD_LOGIC;
        dac_out             : out   STD_LOGIC;
        dac_out_i           : in    STD_LOGIC;
        test                : inout STD_LOGIC_VECTOR(7 downto 0)
		);		
end component io_pads;

begin

core : core
    port map (
        din     => open,
		dout    => open,
		clkin   => CLK_IN,
		reset   => RESET,
		test    => open
		);

io_pads : io_pads
    port map (
        fpga_clk        => CLK_IN,
        reset           => RESET,
        lvds_p          => LVDS_P,
        lvds_n          => LVDS_N,
        adc_fdac_out    => ADC_SD_DAC_OUT,
        test_comp_out   => COMP_OUT,
        test_adc_clk    => ADC_CLK,
        comp_out        => COMP_OUT
	    );
		
end RTL;
