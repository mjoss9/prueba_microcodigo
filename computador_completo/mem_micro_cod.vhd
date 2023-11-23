-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(7 downto 0);
        data : out std_logic_vector(18 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 255) of std_logic_vector(18 downto 0);
    signal mem : mem_type := (
		0  => "0000000011000000001",  --- Instrucion de comienzo
        1  => "0000000000000010001",
        2  => "0100000000000000011",

        16 => "0000000000000010001",  --- Direccionamiento Inherente
        17 => "0100000000000000001",
        18 => "0000000101000000111",

        32 => "0000000000000010001",  --- Direccionamiento Inmediato
        33 => "0100000000000000001",
        34 => "0000000101000000001",
        35 => "0000000000000010001",
        36 => "0000000101000000111",

        48 => "0000000000000010001",  --- Direccioamiento Directo
        49 => "0100000000000000001",
        50 => "0000000101000000001",
        51 => "0000000000000010001",
        52 => "0000100000000000001",
        53 => "0000000101000000001",
        54 => "0000000000000010001",
        55 => "0000010000000100001",
        56 => "0000000000000110001",
        57 => "0000000101000001111",

        64 => "0000000000000010001",  --- Direccioamiento Indexado
        65 => "0100000000000000001",
        66 => "0000000101000000001",

        -- Finalizando a memoria com zeros
        others => "0000000000000000001"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;