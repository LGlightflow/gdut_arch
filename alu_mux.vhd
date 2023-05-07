library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_mux is
    port (
        alu    : in  std_logic_vector(15 downto 0);
        su     : in  std_logic_vector(15 downto 0);
        mvi    : in  std_logic_vector(15 downto 0);
        ovf    : in  std_logic;
        sel    : in  std_logic_vector(1 downto 0);
        result : out std_logic_vector(15 downto 0);
        overflow : out std_logic
    );
end entity alu_mux;

architecture rtl of alu_mux is
begin

    process (alu, su, mvi, ovf, sel)
    begin
        case sel is
            when "00" =>
                result   <= alu;
                overflow <= ovf;
            when "01" =>
                result   <= su;
                overflow <= '0';
            when "10" =>
                result   <= mvi;
                overflow <= '0';
            when others =>
                result   <= (others => '0');
                overflow <= '0';
        end case;
    end process;

end architecture rtl;