-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(11 downto 0);
        data : out std_logic_vector(12 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 4096) of std_logic_vector(12 downto 0);
    signal mem : mem_type := (
		0  => "0000110000000",  --- Instrucion de comienzo
        1  => "0000000100000",
        2  => "1000000000001",

        32 => "0100101000001",  --- Instruccion de NOT
        33 => "0000000010001",
        34 => "0010000000011",

        64 => "0000000010001",  --- Instruccion de ADD mem
        65 => "0010101000001",
        66 => "0000000010001",
        67 => "0001000000001",
        68 => "0000000110001",
        69 => "0100101000011",

        1840 => "0000000100000",  --- Instruccion de INC mem
        1841 => "1000000000000",
        1842 => "0001010000000",
        1843 => "0000000100000",
        1844 => "0100000000000",
        1845 => "0001010000000",
        1846 => "0000000100000",
        1847 => "0010001000000",
        1848 => "0000001100000",
        1849 => "0001010000011",

        1808 => "0000000100000",  --- Instruccion de STA
        1809 => "1000000000000",
        1810 => "0001010000000",
        1811 => "0000000100000",
        1812 => "0100000000000",
        1813 => "0001010000000",
        1814 => "0000000100000",
        1815 => "0010001000000",
        1816 => "0000001100000",
        1817 => "0001010000011",

        2848 => "0000000100000",  --- Instruccion de STA
        2849 => "1000000000000",
        2850 => "0001010000000",
        2851 => "0000000100000",
        2852 => "0100000000000",
        2853 => "0001010000000",
        2854 => "0000000100000",
        2855 => "0010001000000",
        2856 => "0000001100000",
        2857 => "0001010000011",

        -- Finalizando a memoria com zeros
        others => "0000000000000"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;