library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity TestCircuit is
    Port ( CLK : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR(0 to 6));
end TestCircuit;

architecture Behavioral of TestCircuit is
   constant N : integer := 7;

   component MIGenerator
      Port ( CLK : in  STD_LOGIC;
             RST : in  STD_LOGIC;
             Pout : out  STD_LOGIC_VECTOR (0 to N-1));
   end component;
   
   component Circuit
      Port ( I : in  STD_LOGIC_VECTOR (0 to N-1);
             O : out  STD_LOGIC);
   end component;
   
   component SignatureAnalyzer
      Port ( CLK : in  STD_LOGIC;
             RST : in  STD_LOGIC;
             Sin : in  STD_LOGIC;
             Pout : out  STD_LOGIC_VECTOR (0 to N-1));
   end component;
   
   signal generated : STD_LOGIC_VECTOR (0 to N-1);
   signal returned : STD_LOGIC;
begin
   TC1: MIGenerator port map (CLK => CLK, RST => '0', Pout => generated);
   TC2: Circuit port map (I => generated, O => returned);
   TC3: SignatureAnalyzer port map (CLK => CLK, RST => '0', Sin => returned, Pout => O);
end Behavioral;
