LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
 
ENTITY SyncRegisterTests IS
END SyncRegisterTests;
 
ARCHITECTURE behavior OF SyncRegisterTests IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT SyncRegister
    PORT(
         Din : IN  std_logic_vector(7 downto 0);
         EN : IN  std_logic;
         CLK : IN  std_logic;
         Dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal Din : std_logic_vector(7 downto 0) := (others => '0');
   signal EN : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Dout_s, Dout_b : std_logic_vector(7 downto 0);
   signal error : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant EN_multiplier : integer := 2 ** 1;
   constant data_multiplier : integer := 2 ** 2;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   SyncRegister_s: entity work.SyncRegister(Structural) PORT MAP (
          Din => Din,
          EN => EN,
          CLK => CLK,
          Dout => Dout_s
        );
   
   SyncRegister_b: entity work.SyncRegister(Behavioral) PORT MAP (
          Din => Din,
          EN => EN,
          CLK => CLK,
          Dout => Dout_b
        );

   -- Clock process definitions
   CLK_process :process
   begin
      CLK <= '0';
      wait for CLK_period/2;
      CLK <= '1';
      wait for CLK_period/2;
   end process;
 
   EN_process :process
   begin
      EN <= '0';
      wait for CLK_period*EN_multiplier/2;
      EN <= '1';
      wait for CLK_period*EN_multiplier/2;
   end process;
   
   data_process :process
   begin
      wait for CLK_period*data_multiplier/2;
      Din <= Din + "1";
   end process;
   
   error <= '0' when Dout_s = Dout_b else '1';
END;
