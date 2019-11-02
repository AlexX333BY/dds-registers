LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CircuitTests IS
END CircuitTests;
 
ARCHITECTURE behavior OF CircuitTests IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT TestCircuit
    PORT(
         CLK : IN  std_logic;
         O : OUT  std_logic_vector(0 to 6)
        );
    END COMPONENT;
    
   --Inputs
   signal CLK : std_logic := '0';

 	--Outputs
   signal O : std_logic_vector(0 to 6);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: TestCircuit PORT MAP (
          CLK => CLK,
          O => O
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
END;
