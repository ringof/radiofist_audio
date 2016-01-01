-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See licence.txt for details

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_adc_fir_lowpass IS
END tb_adc_fir_lowpass;
 
ARCHITECTURE behavior OF tb_adc_fir_lowpass IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fir_filter
    PORT(
         sclr : IN  std_logic;
         clk : IN  std_logic;
         nd : IN  std_logic;
         rfd : OUT  std_logic;
         rdy : OUT  std_logic;
         data_valid : OUT  std_logic;
         din : IN  std_logic_vector(24 downto 0);
         dout : OUT  std_logic_vector(40 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sclr : std_logic := '0';
   signal clk : std_logic := '0';
   signal nd : std_logic := '0';
   signal din : std_logic_vector(24 downto 0) := (others => '0');

 	--Outputs
   signal rfd : std_logic;
   signal rdy : std_logic;
   signal data_valid : std_logic;
   signal dout : std_logic_vector(40 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fir_filter PORT MAP (
          sclr => sclr,
          clk => clk,
          nd => nd,
          rfd => rfd,
          rdy => rdy,
          data_valid => data_valid,
          din => din,
          dout => dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		sclr <= '1';
		nd <= '1';
      wait for clk_period*10;
		sclr <= '0';

      -- insert stimulus here 
		wait for clk_period*10;
		din <= (others => '0');
      wait for clk_period*10;
		din <= (others => '1');
		wait;
   end process;

END;
