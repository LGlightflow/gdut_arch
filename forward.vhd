library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
ENTITY forward IS
    PORT(exmRegWrite,memwbRegWrite  : in std_logic;
         exmWriteReg, memwbWriteReg  : in std_logic_vector(2 downto 0);
         idexReadOne,idexReadTwo      : in std_logic_vector(2 downto 0);
         aluSelA, aluSelB              : out std_logic_vector(1 downto 0));
END ENTITY forward;
ARCHITECTURE forward_behav OF forward IS
BEGIN
    name : PROCESS(exmRegWrite, exmWriteReg, idexReadOne, idexReadTwo) IS
    BEGIN
        IF(exmRegWrite='1') THEN  --若来自EX/MEM段的寄存器要被写入
            IF(memwbRegWrite='0') THEN   --若写寄存器=读寄存器one,则写入
                IF(exmWriteReg=idexReadOne) THEN  aluSelA <= "01";
                ELSE   aluSelA <= "00";  END IF;                    
                IF(exmWriteReg=idexReadTwo) THEN  aluSelB <= "01";
                ELSE   aluSelB <= "00";  END IF;
				ELSE
                IF(exmWriteReg=idexReadOne) THEN   aluSelA <= "01";
                ELSE IF(memwbWriteReg=idexReadOne) THEN aluSelA <= "10";
                ELSE  aluSelA <= "00"; END IF;
                END IF;
               IF(exmWriteReg=idexReadTwo) THEN  aluSelB <= "01";
--若EX段写寄存器=ID段读寄存器two,则写入
                ELSE IF(memwbWriteReg=idexReadTwo) THEN  aluSelB <= "10";
                ELSE  aluSelB <= "00";  END IF;
                END IF;
            END IF;
        ELSE IF(memwbRegWrite='1') THEN
                IF(memwbWriteReg=idexReadTwo) THEN  aluSelB <= "10";
                ELSE  aluSelB <= "00";  END IF;
                IF(memwbWriteReg=idexReadOne) THEN  aluSelA <= "10";
                ELSE aluSelA <= "00";  END IF;
            ELSE   aluSelA <= "00";  aluSelB <= "00"; END IF;
        END IF;
END PROCESS name;
END ARCHITECTURE forward_behav; 
