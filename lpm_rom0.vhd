LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
ENTITY lpm_rom0 IS
	PORT (address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
Inclock : IN STD_LOGIC ; q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
END lpm_rom0;
ARCHITECTURE SYN OF lpm_rom0 IS
	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	COMPONENT altsyncram
	GENERIC ( address_aclr_a : STRING;
		init_file : STRING;
		intended_device_family		: STRING;
		lpm_hint		: STRING; 
                            lpm_type		: STRING;
		numwords_a		: NATURAL;
		operation_mode		: STRING;
		outdata_aclr_a		: STRING;
		outdata_reg_a		: STRING;
		widthad_a		: NATURAL;  
		width_a		: NATURAL;
		width_byteena_a		: NATURAL  ); 
	PORT ( clock0	: IN STD_LOGIC ;
		address_a	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			q_a	: OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
	END COMPONENT;
BEGIN
	q    <= sub_wire0(15 DOWNTO 0);
	altsyncram_component : altsyncram
	GENERIC MAP ( address_aclr_a => "NONE",  init_file => "rom_2.mif",
		intended_device_family => "Cyclone",
		lpm_hint => "ENABLE_RUNTIME_MOD=YES, INSTANCE_NAME=rom3",
		lpm_type => "altsyncram",  numwords_a => 64,
		operation_mode => "ROM",  outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",  widthad_a => 6,
		width_a => 16,  width_byteena_a => 1  )
	PORT MAP ( clock0 => inclock,address_a => address,q_a => sub_wire0 	);
END SYN; 
