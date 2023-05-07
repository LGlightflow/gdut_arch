library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY incpc IS
    PORT(pcIn  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         pcVal  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY incpc;
ARCHITECTURE pc_behav OF incpc IS
BEGIN
    name : PROCESS(pcIn) IS
    BEGIN
        pcVal <= pcIn +1;
    END PROCESS name;
END ARCHITECTURE pc_behav; 
