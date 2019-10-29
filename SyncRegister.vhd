library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity SyncRegister is
    Generic ( N : integer := 8);
    Port ( Din : in  STD_LOGIC_VECTOR (N-1 downto 0);
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (N-1 downto 0));
end SyncRegister;

architecture Structural of SyncRegister is
begin
   L: for i in 0 to N-1 generate
      LGEN: FDE port map ( D => Din(i), CE => EN, C => CLK, Q => Dout(i));
   end generate;
end Structural;

architecture Behavioral of SyncRegister is
signal reg : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
begin
   Main : process ( Din, EN, CLK )
   begin
      if rising_edge(CLK) then
         if EN = '1' then
            reg <= Din;
         end if;
      end if;
   end process;
   
   Dout <= reg;
end Behavioral;
