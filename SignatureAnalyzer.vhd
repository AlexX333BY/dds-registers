library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignatureAnalyzer is
    Generic ( conf : STD_LOGIC_VECTOR := "11000001");
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Sin : in  STD_LOGIC;
           Pout : out  STD_LOGIC_VECTOR (0 to conf'high-1));
end SignatureAnalyzer;

architecture Behavioral of SignatureAnalyzer is
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

   DataProcess : process (reg, Sin)
      constant zeros : STD_LOGIC_VECTOR (0 to conf'high-1) := (others => '0');
   begin
      data(0) <= Sin xor reg(conf'high-1);
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
