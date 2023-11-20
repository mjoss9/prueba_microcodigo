-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(6 downto 0);
        data : out std_logic_vector(12 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 127) of std_logic_vector(12 downto 0);
    signal mem : mem_type := (
		0  => "0000110000000",  --- Instrucion de comienzo
        1  => "0000000100000",
        2  => "1000000000001",

        16 => "0000000100000",  --- Direccionamiento Inherente
        17 => "1000000000000",
        18 => "0001010000011",

        32 => "0000000100000",  --- Direccionamiento Inmediato
        33 => "1000000000000",
        34 => "0001010000000",
        35 => "0000000100000",
        36 => "0001010000011",

        48 => "0000000100000",  --- Direccioamiento Directo
        49 => "1000000000000",
        50 => "0001010000000",
        51 => "0000000100000",
        52 => "0100000000000",
        53 => "0001010000000",
        54 => "0000000100000",
        55 => "0010001000000",
        56 => "0000001100000",
        57 => "0001010010011",

        64 => "0000000100000",  --- Direccioamiento Indexado
        65 => "1000000000000",
        66 => "0001010000011",

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