library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity SREGn is
    Generic ( N : integer := 8);
    Port ( Sin : in  STD_LOGIC;
           SE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Pout : out  STD_LOGIC_VECTOR (N-1 downto 0));
end SREGn;

architecture Structural of SREGn is
   signal reg: STD_LOGIC_VECTOR ( N-1 downto 0) := (others => '0');
begin
   SR1: FDCE port map ( D => Sin, CE => SE, C => CLK, CLR => RST, Q => reg(0) );
   SR2: BUF port map ( I => reg(0), O => Pout(0) );
   L: for i in 1 to N-1 generate
      D: FDCE port map ( D => reg(i-1), CE => SE, C => CLK, CLR => RST, Q => reg(i) );
      O: BUF port map ( I => reg(i), O => Pout(i) );
   end generate;
end Structural;

architecture Behavioral of SREGn is
   signal reg: STD_LOGIC_VECTOR ( N-1 downto 0) := (others => '0');
begin
   Main : process ( Sin, SE, CLK, CLK, RST )
   begin
      if RST = '1' then
         reg <= ( others => '0' );
      else
         if rising_edge(CLK) then
            if SE = '1' then
               for i in 1 to N-1 loop
                  reg(i) <= reg(i-1);
               end loop;
               reg(0) <= Sin;
            end if;
         end if;
      end if;
   end process;
   Pout <= reg;
end Behavioral;
