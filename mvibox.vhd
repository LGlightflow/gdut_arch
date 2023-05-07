library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
entity mvibox is
    Port ( reg1 : in  std_logic_vector(7 downto 0);
           immed : in  std_logic_vector(7 downto 0);
           write : in  std_logic;
           result : out std_logic_vector(15 downto 0));
end mvibox;

architecture Behavioral of mvibox is

    signal reg : std_logic_vector(15 downto 0);

begin

    process(reg1, immed, write)
    begin
        if write = '1' then
            reg <= std_logic_vector(unsigned(immed(7)&immed(7)&immed(7)&immed(7)&immed(7)&immed(7)&immed(7)&immed(7)&immed) + unsigned(reg1(7)&reg1(7)&reg1(7)&reg1(7)&reg1(7)&reg1(7)&reg1(7)&reg1(7)&reg1));
        end if;
        result <= reg;
    end process;

end Behavioral;