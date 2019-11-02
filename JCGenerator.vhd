library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JCGenerator is
    Generic ( N : integer := 8);
    Port ( CLK : in  STD_LOGIC;
           LS : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Pin : in  STD_LOGIC_VECTOR (0 to N-1);
           Pout : out  STD_LOGIC_VECTOR (0 to N-1));
end JCGenerator;

architecture Behavioral of JCGenerator is
   signal reg : STD_LOGIC_VECTOR (0 to N-1) := (others => '0');
begin
   Main : process (CLK, LS, RST, Pin)
   begin
      if RST = '1' then
         reg <= (others => '0');
      elsif rising_edge(CLK) then
         if LS = '0' then
            reg <= Pin;
         else
            reg <= not reg(N-1) & reg(0 to N-2);
         end if;
      end if;
   end process;

   Pout <= reg;
end Behavioral;

