LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY lpm;
USE lpm.lpm_components.all;
ENTITY bus_mux_3 IS
	PORT( data0x,data1x	: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		sel : IN STD_LOGIC ; result : OUT STD_LOGIC_VECTOR (2 DOWNTO 0) );
END bus_mux_3;
ARCHITECTURE SYN OF bus_mux_3 IS
	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC ;
	SIGNAL sub_wire2	: STD_LOGIC_VECTOR (0 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_2D (1 DOWNTO 0, 2 DOWNTO 0);
	SIGNAL sub_wire5	: STD_LOGIC_VECTOR (2 DOWNTO 0);
	COMPONENT lpm_mux
	GENERIC (lpm_size : NATURAL;
		lpm_type		: STRING;
		lpm_width		: NATURAL;
		lpm_widths		: NATURAL    	);
	PORT (		sel	: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
			data	: IN STD_LOGIC_2D (1 DOWNTO 0, 2 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR (2 DOWNTO 0)  	);
	END COMPONENT;
BEGIN
	sub_wire5 <= data0x(2 DOWNTO 0);       result <= sub_wire0(2 DOWNTO 0);
	sub_wire1 <= sel;                 	sub_wire2(0) <= sub_wire1;
	sub_wire3 <= data1x(2 DOWNTO 0);	sub_wire4(1, 0) <= sub_wire3(0);
	sub_wire4(1, 1) <= sub_wire3(1);	sub_wire4(1, 2) <= sub_wire3(2);
	sub_wire4(0, 0) <= sub_wire5(0);	sub_wire4(0, 1) <= sub_wire5(1);
	sub_wire4(0, 2) <= sub_wire5(2);
lpm_mux_component : lpm_mux
	GENERIC MAP ( lpm_size => 2, lpm_type => "LPM_MUX", lpm_width => 3,
lpm_widths => 1 )
	PORT MAP (	sel => sub_wire2, data => sub_wire4,result=>sub_wire0 );
END SYN; 
