library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Circuit is
    Port ( I : in  STD_LOGIC_VECTOR (0 to 6);
           O : out  STD_LOGIC);
end Circuit;

architecture Behavioral of Circuit is
begin
   O <= not I(0) and not I(2) and not I(4) and not I(6)
      and ((I(1) and not I(3) and not I(5)) 
         or (not I(1) and I(3) and not I(5)) 
         or (not I(1) and not I(3) and I(5)));
end Behavioral;
