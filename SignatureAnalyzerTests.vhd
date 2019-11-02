LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SignatureAnalyzerTests IS
END SignatureAnalyzerTests;
 
ARCHITECTURE behavior OF SignatureAnalyzerTests IS 
    -- Component Declaration for the Unit Under Test (UUT)
    constant N : integer := 7;
    COMPONENT SignatureAnalyzer
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         Sin : IN  std_logic;
         Pout : OUT  std_logic_vector(0 to N-1)
        );
    END COMPONENT;
    
   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal Sin : std_logic := '0';

 	--Outputs
   signal Pout : std_logic_vector(0 to N-1);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant seq : STD_LOGIC_VECTOR := "11000011";
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: SignatureAnalyzer PORT MAP (
          CLK => CLK,
          RST => RST,
          Sin => Sin,
          Pout => Pout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

   seq_process :process
   begin
      for i in seq'high downto 0 loop
         Sin <= seq(i);
         wait for CLK_period;
      end loop;
   end process;
END;
