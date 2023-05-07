library ieee;
use ieee.std_logic_1164.all;
ENTITY progc IS
   PORT(pcIn  : IN STD_LOGIC_VECTOR(15 DOWNTO 0); clk,enable : IN STD_LOGIC;
        pcOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY progc;

ARCHITECTURE progc_behav OF progc IS
BEGIN
    name : PROCESS(clk) IS
    VARIABLE regValue : STD_LOGIC_VECTOR(15 DOWNTO 0);
    BEGIN
        IF(clk='1') THEN
            IF(enable='1') THEN   regValue := pcin;  END IF;
        END IF;
        pcOut <= regValue; 
    END PROCESS name;
END ARCHITECTURE progc_behav; 
