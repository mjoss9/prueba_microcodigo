-- Memoria de microcodigo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(10 downto 0);
        data : out std_logic_vector(11 downto 0)
    );
end mem_micro_cod;

architecture rtl of mem_micro_cod is
    type mem_type is array (0 to 2048) of std_logic_vector(11 downto 0);
    signal mem : mem_type := (
		0  => "000011000001",  --- Instrucion de comienzo
        1  => "000000010001",
        2  => "010000000011",

        32 => "100101000001",  --- Instruccion de NOT
        33 => "000000010001",
        34 => "010000000011",

        64 => "000000010001",  --- Instruccion de ADD mem
        65 => "010101000001",
        66 => "000000010001",
        67 => "001000000001",
        68 => "000000110001",
        69 => "100101000011",

        80 => "000101000001",  --- Instruccion de INC mem
        81 => "000000010001",
        82 => "001000000001",
        83 => "000000110001",
        84 => "100101000001",
        85 => "000000010001",
        86 => "010000000011",

        96 => "000101000001",  --- Instruccion LDA
        97 => "000000010001",
        98 => "001000000001",
        99 => "000000110001",
        100 => "100101000001",
        101 => "000000010001",
        102 => "010000000011",

        104 => "000101000001",  --- Instruccion de STA
        105 => "000000010001",
        106 => "001000000001",
        107 => "000000110001",
        108 => "000101001001",
        109 => "000000010001",
        110 => "010000000011",

        -- Finalizando a memoria com zeros
        others => "000000000000"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end rtl;