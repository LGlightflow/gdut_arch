library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
ENTITY pcselector IS
    PORT(nextpc, branchpc, retpc, retipc   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         sel                          : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         newpc                       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY pcselector;

ARCHITECTURE sel_behav OF pcselector IS
	BEGIN
	name:PROCESS(sel) IS 
		BEGIN
			CASE sel IS
				WHEN "0000" =>  newpc <= nextpc;
				WHEN "0001" =>  newpc <= branchpc;
				WHEN "0010" =>  newpc <= retpc;
				WHEN "0011" =>  newpc <= retipc;
				WHEN "0100" =>  newpc <= "1111111111111111";
				WHEN "0101" =>  newpc <= "1111111111110000";
				WHEN "0110" =>  newpc <= "0000000000001000";
				WHEN "0111" =>  newpc <= "0000000000001100";
				WHEN "1000" =>  newpc <= "0000000000001100";
				WHEN "1001" =>  newpc <= "0000000000001110";
				WHEN "1010" =>  newpc <= "0000000000010000";
				WHEN OTHERS =>  newpc <= "0000000000010010";
			END CASE;
		END PROCESS name;
END ARCHITECTURE sel_behav; 
