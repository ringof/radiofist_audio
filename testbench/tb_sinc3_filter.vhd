-- Copyright (c) 2015 by David Goncalves <davegoncalves@gmail.com>
-- See licence.txt for details
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_sinc3_filter IS
END tb_sinc3_filter;
 
ARCHITECTURE behavior OF tb_sinc3_filter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sinc3_filter
    PORT(
         reset : IN  std_logic;
         din : IN  std_logic;
         in_clk : IN  std_logic;
         out_clk : IN  std_logic;
         dout : OUT  std_logic_vector(24 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal din : std_logic := '0';
   signal in_clk : std_logic := '0';
   signal out_clk : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(24 downto 0);

   -- Clock period definitions
   constant in_clk_period : time := 31.25 ns;
   constant out_clk_period : time := 1250 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sinc3_filter PORT MAP (
          reset => reset,
          din => din,
          in_clk => in_clk,
          out_clk => out_clk,
          dout => dout
        );

   -- Clock process definitions
   in_clk_process :process
   begin
		in_clk <= '0';
		wait for in_clk_period/2;
		in_clk <= '1';
		wait for in_clk_period/2;
   end process;
 
   out_clk_process :process
   begin
		out_clk <= '0';
		wait for out_clk_period/2;
		out_clk <= '1';
		wait for out_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset <= '1';
      wait for in_clk_period*10;
		reset <= '0';

      -- insert stimulus here 
		wait for out_clk_period;
		din <= '0';
      wait for out_clk_period;
		din <= '1';
		wait for out_clk_period;
		din <= '0';
		wait;
   end process;

END;
