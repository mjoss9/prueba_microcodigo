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
    type mem_type is array (0 to 2048) of std_logic_vector(12 downto 0);
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

        160 => "0000000100000",  --- Instruccion de INC mem
        161 => "1000000000000",
        162 => "0001010000000",
        163 => "0000000100000",
        164 => "0100000000000",
        165 => "0001010000000",
        166 => "0000000100000",
        167 => "0010001000000",
        168 => "0000001100000",
        169 => "0001010000011",

        96 => "0000101000001",  --- Instruccion LDA
        97 => "0000000010001",
        98 => "0001000000001",
        99 => "0000000110001",
        100 => "0100101000001",
        101 => "0000000010001",
        102 => "0010000000011",

        104 => "0000101000001",  --- Instruccion de STA
        105 => "0000000010001",
        106 => "0001000000001",
        107 => "0000000110001",
        108 => "0000101001001",
        109 => "0000000010001",
        110 => "0010000000011",

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