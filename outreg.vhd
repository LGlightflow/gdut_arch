library ieee;
use ieee.std_logic_1164.all;
ENTITY outreg IS
    PORT(pcIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
  enable,clk : IN STD_LOGIC;
     pcOut    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY outreg;
ARCHITECTURE outreg_behav OF outreg IS
BEGIN
    name : PROCESS(clk) IS
    VARIABLE regValue : STD_LOGIC_VECTOR(15 DOWNTO 0);
	 BEGIN
     IF(clk='1' AND CLK'EVENT) THEN
        IF(enable='1') THEN   regValue := pcIn;
        END IF;
       pcOut <= regValue;
     END IF;
   END PROCESS name;
END ARCHITECTURE outreg_behav; 
