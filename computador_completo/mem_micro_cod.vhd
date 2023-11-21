-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(7 downto 0);
        data : out std_logic_vector(26 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 255) of std_logic_vector(26 downto 0);
    signal mem : mem_type := (
		0  => "000000001100000000000100000",  --- Instrucion de comienzo
        1  => "000000000000000010000100000",
        2  => "010000000000000000001100000",

        16 => "000000000000000010000100000",  --- Direccionamiento Inherente
        17 => "010000000000000000000100000",
        18 => "010000000000000000000100000",

        32 => "000000000000000010000100000",  --- Direccionamiento Inmediato
        33 => "010000000000000000000100000",
        34 => "000000010100000000000100000",
        35 => "000000000000000010000100000",
        36 => "000000010100000000011100000",

        48 => "000000000000000010000100000",  --- Direccioamiento Directo
        49 => "010000000000000000000100000",
        50 => "000000010100000000000100000",
        51 => "000000000000000010000100000",
        52 => "000010000000000000000100000",
        53 => "000000010100000000000100000",
        54 => "000000000000000010000100000",
        55 => "000001000000000100000100000",
        56 => "000000000000000110000100000",
        57 => "000000010100000001011100000",

        64 => "000000000000000010000100000",  --- Direccioamiento Indexado
        65 => "010000000000000000000100000",
        66 => "000000010100000000000100000",

        -- Finalizando a memoria com zeros
        others => "000000000000000000000000000"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;