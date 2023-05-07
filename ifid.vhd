library ieee;
use ieee.std_logic_1164.all;
ENTITY ifid IS
    PORT(pcIn, insIn                 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         clk,id_flush,ifid_enable       : IN STD_LOGIC;
         pcOut, insOut               : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY ifid;
ARCHITECTURE ifid_behav OF ifid IS
BEGIN
    name : PROCESS(clk) IS
        VARIABLE regValue : STD_LOGIC_VECTOR(31 DOWNTO 0);
    BEGIN
     IF(clk='1') THEN
      IF(ifid_enable='1') THEN
        IF(id_flush='1') THEN
         regValue(31 DOWNTO 0) := regValue(31 DOWNTO 16) & "0000000000000000";
         ELSE regValue(31 DOWNTO 0) := pcIn(15 DOWNTO 0) & insIn(15 DOWNTO 0);
                END IF;
            END IF;
        END IF;
       pcOut <= regValue(31 DOWNTO 16);    insOut <= regValue(15 DOWNTO 0);
    END PROCESS name;
END ARCHITECTURE ifid_behav; 
