library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIGenerator is
    Generic ( conf : STD_LOGIC_VECTOR := "11000001");
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Pout : out  STD_LOGIC_VECTOR (0 to conf'high-1));
end MIGenerator;

architecture Behavioral of MIGenerator is
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
      constant zeros : STD_LOGIC_VECTOR (0 to conf'high-1) := (others => '0');
   begin
      if reg = zeros then
         data(0) <= '1';
      else
         data(0) <= reg(conf'high-1);
      end if;
      for i in 1 to conf'high-1 loop
         if conf(i) = '1' then
            data(i) <= reg(i-1) xor reg(conf'high-1);
         else
            data(i) <= reg(i-1);
         end if;
      end loop;
   end process;
   
   Pout <= reg;
end Behavioral;