library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
ENTITY rselector IS
    PORT(a,b,d  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         sel     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
         c       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY rselector;

ARCHITECTURE rsel_behav OF rselector IS
BEGIN
    name : PROCESS(a,b,sel) IS
		BEGIN
        CASE sel IS
			
            WHEN "00" =>    c<=a;
            WHEN "01" =>    c<=b;
            WHEN OTHERS =>  c<=d;
        END CASE;
    END PROCESS name;
END ARCHITECTURE rsel_behav; 
