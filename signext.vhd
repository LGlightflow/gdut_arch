library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
ENTITY signext IS
    PORT(immed6In  : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
         immed8In   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         immed6Out, immed8Out,immed5Out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY signext;
ARCHITECTURE sign_behav OF signext IS
BEGIN
    name: PROCESS(immed6In, immed8In) IS
    VARIABLE tempInt : INTEGER;
    BEGIN
    IF(immed6In(5)='0') THEN immed6Out<="0000000000" & immed6In(5 DOWNTO 0);
        ELSE immed6Out <= "1111111111" & immed6In(5 DOWNTO 0); END IF; 
    IF(immed8In(7)='0') THEN immed8Out<="00000000" & immed8In(7 DOWNTO 0);
        ELSE   immed8Out <= "11111111" & immed8In(7 DOWNTO 0); END IF;
    IF(immed8In(4)='0') THEN immed5Out<="00000000000" & immed8In(5 DOWNTO 1);
        ELSE  immed5Out <= "11111111111" & immed8In(5 DOWNTO 1); END IF;
    END PROCESS name;
END ARCHITECTURE sign_behav; 
