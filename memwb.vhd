library ieee;
use ieee.std_logic_1164.all;
ENTITY memwb IS
    PORT(read, result, input  : STD_LOGIC_VECTOR(15 DOWNTO 0);
         clk  : IN STD_LOGIC;
         wb   : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         readOut, resultOut,inputOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
         wbOut  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ENTITY memwb;

ARCHITECTURE memwb_behav OF memwb IS
BEGIN
    name : PROCESS(clk) IS
    VARIABLE regValue : STD_LOGIC_VECTOR(50 DOWNTO 0);
    BEGIN
        IF(clk='1') THEN
         regValue(50 DOWNTO 0) := result(15 DOWNTO 0) & read(15 DOWNTO 0) & 
         input(15 DOWNTO 0) & wb(2 DOWNTO 0);  END IF;
      resultOut <= regValue(50 DOWNTO 35);  readOut <= regValue(34 DOWNTO 19);
      inputOut <= regValue(18 DOWNTO 3) ;    wbOut <= regValue(2 DOWNTO 0);
		END PROCESS name;
END ARCHITECTURE memwb_behav; 
