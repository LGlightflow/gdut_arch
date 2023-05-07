LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY su_3 IS
	PORT (
		data     : IN  std_logic_vector(15 downto 0);
		op          : IN  std_logic_vector(1 downto 0);
		amountIn   : IN  std_logic_vector(15 downto 0);
		dataOut    : OUT std_logic_vector(15 downto 0)
	);
END ENTITY;

ARCHITECTURE su_3 OF su_3 IS
BEGIN
	process (data, op, amountIn)
		VARIABLE amount : INTEGER range -15 to 15;
	BEGIN
		amount := to_integer(signed(amountIn));
		
		CASE op IS
			WHEN "00" => -- right shift
				IF amount >= 0 THEN
					dataOut <= std_logic_vector(shift_right(unsigned(data), amount));
				ELSE
					dataOut <= std_logic_vector(shift_left(unsigned(data), abs(amount)));
				END IF;
				
			WHEN "01" => -- left shift
				IF amount >= 0 THEN
					dataOut <= std_logic_vector(shift_left(unsigned(data), amount));
				ELSE
					dataOut <= std_logic_vector(shift_right(unsigned(data), abs(amount)));
				END IF;
				
			WHEN "10" => -- logical right shift
				dataOut <= std_logic_vector(shift_right(unsigned(data), amount));
				
			WHEN "11" => -- logical left shift
				dataOut <= std_logic_vector(shift_left(unsigned(data), amount));
				
			WHEN OTHERS => -- no operation
				dataOut <= data;
		END CASE;
	END process;
END ARCHITECTURE su_3;
