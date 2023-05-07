library ieee;
use ieee.std_logic_1164.all;
entity hazard is
		port(opcode :   in std_logic_vector(3 downto 0);
func, readone, readtwo, idexwrite :  in std_logic_vector(2 downto 0);
idexMemWE, idexwe :  in std_logic;
exmemwrite :        in std_logic_vector(2 downto 0);
memstage :          in std_logic;
pcenable, ifidenable,idexflush :     out std_logic);
end entity hazard;

architecture hazard_behav of hazard is
begin
name : process(opcode, func, readone, readtwo, idexwrite, idexMemWE, memstage, exmemwrite) is
begin  --若写允许(we=1)有效，MEM/IO段的数据处理如下.
	if(idexMemWE='1') then
		if(idexwrite=readone or idexwrite=readtwo) then
			pcenable <= '0'; ifidenable <= '0'; idexflush <= '1';
		else  
		pcenable <= '1'; ifidenable <= '1'; idexflush <= '0';
		end if;
	--若写允许的同时遇到分支转移指令，并且要写入的寄存器就是转移指令要读出的寄存器，
	--则无论是MEM/IO段还是EX执行段都必须stall暂停执行
	elsif((opcode="0010" and func="010") or (opcode="0010" and func="011") or opcode="0101") then --要写入的是EX执行段寄存器吗？
		if(idexwe='1') then
			if(idexwrite = readone or idexwrite=readtwo) then
			pcenable <= '0'; ifidenable <= '0'; idexflush <= '1';
			else 
			pcenable <= '1'; ifidenable <= '1'; idexflush <= '0';
			end if; 
		end if;
	elsif (memstage='1') then  --要写入的是MEM存储段寄存器吗?
		if(exmemwrite = readone or exmemwrite = readtwo) then
		pcenable <= '0'; ifidenable <= '0'; idexflush <= '1';
		else
		pcenable <= '1'; ifidenable <= '1'; idexflush <= '0';
		end if;
	--若两者都不是，则按正常操作
	else 
		pcEnable <='1'; ifidenable <= '1'; idexflush <= '0';
	end if;
end process name;
end architecture hazard_behav; 
