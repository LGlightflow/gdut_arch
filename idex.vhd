library ieee;
use ieee.std_logic_1164.all;
ENTITY idex IS
  PORT(idexpcIn,regOne, regTwo, immed16In : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         shiftImm  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         immed8In  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         clk    : IN STD_LOGIC;
         writeback  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         readOneIn, readTwoIn       : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         idexpc,regOneOut, regTwoOut  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
         immed16Out, shiftImmOut     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
         immed8Out                      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
writebackOut                  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
         readRegisters                 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0));
END ENTITY idex;
ARCHITECTURE idex_behav OF idex IS
BEGIN
    name : PROCESS(clk) IS
        VARIABLE regValue : STD_LOGIC_VECTOR(96 DOWNTO 0);
    BEGIN        
     IF(clk='1') THEN regValue(96 DOWNTO 0) := idexpcIn(15 DOWNTO 0) & 
      readOneIn(2 DOWNTO 0) & readTwoIn(2 DOWNTO 0) &
      shiftImm(15 DOWNTO 0) & regOne(15 DOWNTO 0) & regTwo(15 DOWNTO 0) & 
      immed16In(15 DOWNTO 0) & immed8In(7 DOWNTO 0) & writeback(2 DOWNTO 0);
      END IF;
      idexpc<=regValue(96 DOWNTO 81); readRegisters<=regValue(80 DOWNTO 75);
        shiftImmOut <= regValue(74 DOWNTO 59);
     regOneOut<=regValue(58 DOWNTO 43); regTwoOut<=regValue(42 DOWNTO 27);
    immed16Out<=regValue(26 DOWNTO 11); immed8Out<=regValue(10 DOWNTO 3);
        writebackOut <= regValue(2 DOWNTO 0);
    END PROCESS name;
END ARCHITECTURE idex_behav; 
