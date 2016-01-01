-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See licence.txt for details

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_clock IS
END tb_clock;
 
ARCHITECTURE behavior OF tb_clock IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock
    PORT(
         clk_in : IN  std_logic;
         reset : IN  std_logic;
         clk_6mhz : OUT  std_logic;
         decimation_clk : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_in : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal clk_6mhz : std_logic;
   signal decimation_clk : std_logic;

   -- Clock period definitions
   constant clk_in_period : time := 31.25 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock PORT MAP (
          clk_in => clk_in,
          reset => reset,
          clk_6mhz => clk_6mhz,
          decimation_clk => decimation_clk
        );

   -- Clock process definitions
   clk_in_process :process
   begin
		clk_in <= '0';
		wait for clk_in_period/2;
		clk_in <= '1';
		wait for clk_in_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for multiple of clk_in_period.
      reset <= '1';
      wait for 1000ns;

      -- insert stimulus here 
		reset <= '0';
		wait for clk_in_period*(100000);
      wait;
   end process;

END;
