LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SREGnTests IS
END SREGnTests;
 
ARCHITECTURE behavior OF SREGnTests IS 
    -- Component Declaration for the Unit Under Test (UUT)
    constant N : integer := 8;
    
    COMPONENT SREGn
    PORT(
         Sin : IN  std_logic;
         SE : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         Pout : OUT  std_logic_vector(0 to N-1)
        );
    END COMPONENT;
    
   --Inputs
   signal Sin : std_logic := '0';
   signal SE : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Pout_s, Pout_b : std_logic_vector(0 to N-1);
   signal error : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant SE_multiplier : integer := 2 ** 0;
   constant Sin_multiplier : integer := SE_multiplier;
   
   constant Sin_sequence : std_logic_vector(0 to N-1) := "10000000";
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   SREGn_s: entity work.SREGn(Structural) PORT MAP (
          Sin => Sin,
          SE => SE,
          CLK => CLK,
          RST => RST,
          Pout => Pout_s
        );

   SREGn_b: entity work.SREGn(Behavioral) PORT MAP (
          Sin => Sin,
          SE => SE,
          CLK => CLK,
          RST => RST,
          Pout => Pout_b
        );

   RST <= '0';
   error <= '0' when Pout_s = Pout_b else '1';

   -- Clock process definitions
   CLK_process :process
   begin
      CLK <= '0';
      wait for CLK_period/2;
      CLK <= '1';
      wait for CLK_period/2;
   end process;

   SE_process :process
   begin
      SE <= '0';
      wait for CLK_period*SE_multiplier/2;
      SE <= '1';
      wait for CLK_period*SE_multiplier/2;
   end process;
   
   Sin_process :process
   begin
      for i in 0 to N-1 loop
         Sin <= Sin_sequence(i);
         wait for CLK_period*Sin_multiplier;
      end loop;
   end process;
END;
