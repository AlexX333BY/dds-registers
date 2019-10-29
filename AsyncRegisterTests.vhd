LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
 
ENTITY AsyncRegisterTests IS
END AsyncRegisterTests;
 
ARCHITECTURE behavior OF AsyncRegisterTests IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT AsyncRegister
    PORT(
         Din : IN  std_logic_vector(7 downto 0);
         EN : IN  std_logic;
         Dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal Din : std_logic_vector(7 downto 0) := (others => '0');
   signal EN : std_logic := '0';

 	--Outputs
   signal Dout_s, Dout_b : std_logic_vector(7 downto 0);
   signal error : std_logic;

   constant clock_period : time := 10 ns;
   constant enable_multiplier : integer := 2 ** 0;
   constant data_multiplier : integer := 2 ** 1;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   AsyncRegister_s: entity work.AsyncRegister(Structural) PORT MAP (
          Din => Din,
          EN => EN,
          Dout => Dout_s
        );

   AsyncRegister_b: entity work.AsyncRegister(Behavioral) PORT MAP (
          Din => Din,
          EN => EN,
          Dout => Dout_b
        );

   enable_process :process
   begin
      EN <= '0';
      wait for clock_period*enable_multiplier/2;
      EN <= '1';
      wait for clock_period*enable_multiplier/2;
   end process;

   data_process :process
   begin
      wait for clock_period*data_multiplier/2;
      Din <= Din + "1";
   end process;
   
   error <= '0' when (Dout_s = Dout_b) else '1';
END;
