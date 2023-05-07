library ieee;
use ieee.std_logic_1164.all;
ENTITY exmem IS
    PORT(exmempcIn, result, read    : STD_LOGIC_VECTOR(15 DOWNTO 0);
       clk  : IN STD_LOGIC;
       wb   : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
       exmempc, resultOut, readOut  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
       wbOut   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ENTITY exmem;
ARCHITECTURE exmem_behav OF exmem IS
BEGIN
    name : PROCESS(clk) IS
    VARIABLE regValue : STD_LOGIC_VECTOR(50 DOWNTO 0);
    BEGIN
      IF(clk='1') THEN  regValue(50 DOWNTO 0) := exmempcIn(15 DOWNTO 0) & 
        result(15 DOWNTO 0) & read(15 DOWNTO 0) & wb(2 DOWNTO 0); END IF;
        exmempc <= regValue(50 DOWNTO 35);    -- EX段的PC值
        resultOut <= regValue(34 DOWNTO 19);  --来自ALU的运算结果
        readOut <= regValue(18 DOWNTO 3);      --从ALU读出的数据
        wbOut <= regValue(2 DOWNTO 0);          --回写的寄存器
    END PROCESS name;
END ARCHITECTURE exmem_behav; 
