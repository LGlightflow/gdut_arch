library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
ENTITY alu_16 IS
    PORT(a, b   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         func    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         overflow  : OUT STD_LOGIC;
         c   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY alu_16;
ARCHITECTURE alu_behav OF alu_16 IS
BEGIN
    name : PROCESS(a, b, func) IS
    VARIABLE signedResult            : SIGNED(15 DOWNTO 0);
    VARIABLE unsignedResult          : UNSIGNED(16 DOWNTO 0);
    VARIABLE temp                  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    VARIABLE a1,b1                  : STD_LOGIC_VECTOR(16 DOWNTO 0);
BEGIN
        CASE func IS   
            WHEN "0000" =>  c <= a and b; overflow <= '0'; --AND_WORD
            WHEN "0001" => c <= a or b; overflow <= '0'; --OR
            WHEN "0010" => c <= a xor b; overflow <= '0'; --XOR
            WHEN "0011" => c <= a nor b; overflow <= '0'; --NOR
            WHEN "0100" => c <= not a; overflow <= '0'; --NOT
            WHEN "0101" => signedResult := conv_signed(conv_integer(signed(a))+conv_integer(signed(b)),16); --ADD
              temp := conv_std_logic_vector(signed(a) + signed(b), 16);
               c <= conv_std_logic_vector(signedResult,16);   overflow <= '0';
            WHEN "0110" =>  signedResult := signed(a) - signed(b); --SUB
                c <= conv_std_logic_vector(signedResult,16);  overflow <= '0';
            WHEN "0111" => unsignedResult := unsigned(a(15)&a) + unsigned(b(15)&b);--ADD
a1 := "0" & a ; b1 :="0" & b;
                unsignedResult := unsigned(a1) + unsigned(b1);
                c <= conv_std_logic_vector(unsignedResult,16);
              IF(conv_integer(unsignedResult) >= 65536) then  overflow <= '1';
               ELSE  overflow <= '0';  END IF;
            WHEN "1000" =>  a1 := "0" & a ; b1 :="0" & b; --SUBu
                unsignedResult := unsigned(a1) - unsigned(b1);
             c <=conv_std_logic_vector(unsignedResult,16);  overflow <= '0';
    WHEN "1001" => if(conv_integer(unsigned(a))<=conv_integer(unsigned(b)))
                Then  c <= "0000000000000000";
                else  c <= "0000000000000001";   end if;
                overflow <= '0';
   WHEN "1010" => if(conv_integer(signed(a))<=conv_integer(signed(b))) 
Then  c<="0000000000000000";
                else   c<="0000000000000001";  end if;
                overflow <= '0';
            WHEN others =>  c <= a;  overflow <= '0';
        END CASE;
    END PROCESS name;
END ARCHITECTURE alu_behav; 
