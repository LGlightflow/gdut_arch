-- Copyright (C) 2023  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 22.1std.1 Build 917 02/14/2023 SC Lite Edition"
-- CREATED		"Thu Apr 20 20:25:25 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY stage2 IS 
	PORT
	(
		WriteEnable :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		bsel :  IN  STD_LOGIC;
		Bu_reg :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		instruction :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		pc :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		regselect :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		WriteData :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		WriteReg :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		BU_PC :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		idexpc :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		immed16Out :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		immed8Out :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		readRegisters :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		regOneOut :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		regTwoOut :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		resultOne :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		resultTwo :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		shiftImmOut :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		writebackOut :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END stage2;

ARCHITECTURE bdf_type OF stage2 IS 

COMPONENT branch
	PORT(bsel : IN STD_LOGIC;
		 displacement : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 reg : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 newPC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT bus_mux_3
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT regfile
	PORT(WriteEnable : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 RegOne : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 RegTwo : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 WriteData : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 WriteReg : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 ReadOne : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 ReadTwo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT signext
	PORT(immed6In : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 immed8In : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 immed5Out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 immed6Out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 immed8Out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT idex
	PORT(clk : IN STD_LOGIC;
		 idexpcIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 immed16In : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 immed8In : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 readOneIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 readTwoIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 regOne : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 regTwo : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 shiftImm : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 writeback : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 idexpc : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 immed16Out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 immed8Out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 readRegisters : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 regOneOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 regTwoOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 shiftImmOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 writebackOut : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 
resultOne <= SYNTHESIZED_WIRE_9;
resultTwo <= SYNTHESIZED_WIRE_10;



b2v_inst : branch
PORT MAP(bsel => bsel,
		 displacement => SYNTHESIZED_WIRE_0,
		 pc => pc,
		 reg => Bu_reg,
		 newPC => BU_PC);


b2v_inst1 : bus_mux_3
PORT MAP(sel => regselect(0),
		 data0x => instruction(8 DOWNTO 6),
		 data1x => instruction(11 DOWNTO 9),
		 result => SYNTHESIZED_WIRE_9);


b2v_inst2 : bus_mux_3
PORT MAP(sel => regselect(1),
		 data0x => instruction(8 DOWNTO 6),
		 data1x => instruction(5 DOWNTO 3),
		 result => SYNTHESIZED_WIRE_10);


b2v_inst3 : regfile
PORT MAP(WriteEnable => WriteEnable,
		 clk => clk,
		 RegOne => SYNTHESIZED_WIRE_9,
		 RegTwo => SYNTHESIZED_WIRE_10,
		 WriteData => WriteData,
		 WriteReg => WriteReg,
		 ReadOne => SYNTHESIZED_WIRE_6,
		 ReadTwo => SYNTHESIZED_WIRE_7);


b2v_inst4 : signext
PORT MAP(immed6In => instruction(5 DOWNTO 0),
		 immed8In => instruction(8 DOWNTO 1),
		 immed5Out => SYNTHESIZED_WIRE_8,
		 immed6Out => SYNTHESIZED_WIRE_3,
		 immed8Out => SYNTHESIZED_WIRE_0);


b2v_inst5 : idex
PORT MAP(clk => clk,
		 idexpcIn => pc,
		 immed16In => SYNTHESIZED_WIRE_3,
		 immed8In => instruction(8 DOWNTO 1),
		 readOneIn => SYNTHESIZED_WIRE_9,
		 readTwoIn => SYNTHESIZED_WIRE_10,
		 regOne => SYNTHESIZED_WIRE_6,
		 regTwo => SYNTHESIZED_WIRE_7,
		 shiftImm => SYNTHESIZED_WIRE_8,
		 writeback => instruction(8 DOWNTO 6),
		 idexpc => idexpc,
		 immed16Out => immed16Out,
		 immed8Out => immed8Out,
		 readRegisters => readRegisters,
		 regOneOut => regOneOut,
		 regTwoOut => regTwoOut,
		 shiftImmOut => shiftImmOut,
		 writebackOut => writebackOut);


END bdf_type;