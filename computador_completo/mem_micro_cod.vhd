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
        18 => "00000001010100000000111",

        32 => "00000000000000100000001",  --- Direccionamiento Inmediato
        33 => "01000000000000000000001",
        34 => "00000001010000000000001",
        35 => "00000000000000100000001",
        36 => "00000001010000000000111",

        48 => "00000000000000100000001",  --- Direccionamiento Directo
        49 => "01000000000000000000001",
        50 => "00000001010000000000001",
        51 => "00000000000000100000001",
        52 => "00001000000000000000001",
        53 => "00000001010000000000001",
        54 => "00000000000000100000001",
        55 => "00000100000001000000001",
        56 => "00000000000001100000001",
        57 => "00000001010000011000111",

        64 => "00000000000000100000001",  --- Direccionamiento Indexado
        65 => "01000000000000000000001",
        66 => "00000001010000000000001",

        80 => "00000000000000100000001",  --- Instruccion de Salto
        81 => "01000000000000000000001",
        82 => "00000001010000000000001",
        83 => "00000000000000100000001",
        84 => "00000001010000000000111",
        
        96 => "00000000000000100000001",  --- Instruccion de Subrutina
        97 => "01000000000000000000001",
        98 => "00000001010000000000001",
        99 => "00000000000000100000001",
        100 => "00000001010000000000111",
        101 => "00000000000000100000001",
        102 => "00000001010000000000001",
        103 => "00000000000000100000001",
        104 => "00000001010000000000111",
        105 => "00000000000000100000001",
        106 => "00000001010000000000001",
        107 => "00000000000000100000001",
        108 => "00000001010000000000111",
        109 => "00000000000000100000001",
        110 => "00000001010000000000001",
        111 => "00000000000000100000001",

        112 => "00000000000000100000001",  --- Instruccion de Retorno de Subrutina
        113 => "01000000000000000000001",
        114 => "00000001010000000000001",
        115 => "00000000000000100000001",
        116 => "00000001010000000000111",
        117 => "00000000000000100000001",
        118 => "00000001010000000000001",
        119 => "00000000000000100000001",
        120 => "00000001010000000000111",

        128 => "00000000000000100000001",  --- Instruccion de Guardado de punteros
        129 => "01000000000000000000001",
        130 => "00000001010000000000001",
        131 => "00000000000000100000001",
        132 => "00000001010000000000111",
        133 => "00000000000000100000001",
        134 => "00000001010000000000001",
        135 => "00000000000000100000001",
        136 => "00000001010000000000111",
        137 => "00000000000000100000001",
        138 => "00000001010000000000001",
        139 => "00000000000000100000001",
        140 => "00000001010000000000111",
        141 => "00000000000000100000001",

        144 => "00000000000000100000001",  --- Instruccion de Carga de punteros Inmediata
        145 => "01000000000000000000001",
        146 => "00000001010000000000001",
        147 => "00000000000000100000001",
        148 => "00001000000000000000001",
        149 => "00000001010000000000001",
        150 => "00000000000000100000001",
        151 => "00000100000000000000001",
        152 => "00000001010100000000011",

        160 => "00000000000000100000001",  --- Instruccion de Carga de punteros Directa
        161 => "01000000000000000000001",
        162 => "00000001010000000000001",
        163 => "00000000000000100000001",
        164 => "00001000000000000000001",
        165 => "00000001010000000000001",
        166 => "00000000000000100000001",
        167 => "00000100000000000000001",
        168 => "00000000000001100000001",
        169 => "00001000000000000000001",
        170 => "00000010000000000000001",
        171 => "00000100000000000000001",
        172 => "00000001010100000000011",

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