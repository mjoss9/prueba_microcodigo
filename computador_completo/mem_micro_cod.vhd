-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(7 downto 0);
        data : out std_logic_vector(22 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 255) of std_logic_vector(22 downto 0);
    signal mem : mem_type := (
		0  => "00000000110000000000001",  --- Instrucion de comienzo
        1  => "00000000000000100000001",
        2  => "01000000000000000000011",

        16 => "00000000000000100000001",  --- Direccionamiento Inherente
        17 => "01000000000000000000001",
        18 => "00000001010000000000111",

        32 => "00000000000000100000001",  --- Direccionamiento Inmediato
        33 => "01000000000000000000001",
        34 => "00000001010000000000001",
        35 => "00000000000000100000001",
        36 => "00000001010000000000111",

        48 => "00000000000000100000001",  --- Direccioamiento Directo
        49 => "01000000000000000000001",
        50 => "00000001010000000000001",
        51 => "00000000000000100000001",
        52 => "00001000000000000000001",
        53 => "00000001010000000000001",
        54 => "00000000000000100000001",
        55 => "00000100000001000000001",
        56 => "00000000000001100000001",
        57 => "00000001010000011000111",

        64 => "00000000000000100000001",  --- Direccioamiento Indexado
        65 => "01000000000000000000001",
        66 => "00000001010000000000001",

        -- Finalizando a memoria com zeros
        others => "00000000000000000000001"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;