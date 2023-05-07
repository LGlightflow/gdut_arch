library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY regFile IS
    port(RegOne, RegTwo, WriteReg  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         WriteData    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         WriteEnable  : IN STD_LOGIC; 
         clk           : IN STD_LOGIC;
         ReadOne, ReadTwo  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY regFile;
ARCHITECTURE behav OF regFile IS
BEGIN
    reg : PROCESS (clk) IS
        TYPE regArray IS ARRAY (INTEGER RANGE 0 TO 7) OF 
                     STD_LOGIC_VECTOR(15 downto 0);
        VARIABLE register_file : regArray;
    BEGIN
      IF(clk='1') THEN
       IF (WriteEnable = '1') THEN
        register_file(CONV_INTEGER(UNSIGNED(WriteReg))) := WriteData;
           register_file(0) := "0000000000000000";  END IF;
END IF; 
     IF(WriteEnable='1') THEN
       IF(WriteReg = RegOne) THEN   ReadOne <= WriteData;
         ELSE  ReadOne <= register_file(CONV_INTEGER(UNSIGNED(RegOne)));
            END IF;
     IF(WriteReg = RegTwo) THEN  ReadTwo <= WriteData;
       ELSE  ReadTwo <= register_file(CONV_INTEGER(UNSIGNED(RegTwo)));
        END IF;
        ELSE  ReadOne <= register_file(CONV_INTEGER(UNSIGNED(RegOne)));
           ReadTwo <= register_file(CONV_INTEGER(UNSIGNED(RegTwo))); 
    END IF; 
  END PROCESS reg; 
END ARCHITECTURE behav; 
