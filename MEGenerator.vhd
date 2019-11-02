library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEGenerator is
    Generic ( conf : STD_LOGIC_VECTOR := "11000001");
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Pout : out  STD_LOGIC_VECTOR (0 to conf'high-1));
end MEGenerator;

architecture Behavioral of MEGenerator is
   signal reg, data : STD_LOGIC_VECTOR ( 0 to conf'high-1 ) := (others => '0');
begin
   Main : process (RST, CLK)
   begin
      if RST = '1' then
         reg <= (others => '0');
      elsif rising_edge(CLK) then
         reg <= data;
      end if;
   end process;

   DataProcess : process (reg)
      variable result : STD_LOGIC;
      constant zeros : STD_LOGIC_VECTOR (0 to conf'high-1) := (others => '0');
   begin
      if reg = zeros then
         result := '1';
      else
         result := conf(conf'high) and reg(conf'high-1);
         for i in conf'high-2 downto 0 loop
            if conf(i+1) = '1' then
               result := result xor reg(i);
            end if;
         end loop;
      end if;
      data <= result & reg(0 to conf'high-2);
   end process;
   
   Pout <= reg;
end Behavioral;
