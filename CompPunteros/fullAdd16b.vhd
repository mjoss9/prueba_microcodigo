library ieee;
use ieee.std_logic_1164.all;
--Describiendo la entidad del sumador completo de 16 bits
entity fullAdd16b is
    port(
        in_0, in_1: in std_logic_vector(15 downto 0);
        c_in: in std_logic;
        y: out std_logic_vector(15 downto 0);
        c_out: out std_logic
    );
end fullAdd16b;

architecture aqr of fullAdd16b is
component fullAdd1b
    port(
        in_0, in_1: in std_logic;
        c_in: in std_logic;
        y: out std_logic;
        c_out: out std_logic
    );
end component;
--Declaramos una variable auxiliar n de 16 bits, para alamacenar el acarreo de cada etapa.
signal n: std_logic_vector(15 downto 0);
--Realizamos la suma bit a bit de in_0 y in_1, y almacenamos el resultado en n.
begin
    fullAdd1b_0: fullAdd1b port map(in_0(0), in_1(0), c_in, y(0), n(0));
    fullAdd1b_1: fullAdd1b port map(in_0(1), in_1(1), n(0), y(1), n(1));
    fullAdd1b_2: fullAdd1b port map(in_0(2), in_1(2), n(1), y(2), n(2));
    fullAdd1b_3: fullAdd1b port map(in_0(3), in_1(3), n(2), y(3), n(3));
    fullAdd1b_4: fullAdd1b port map(in_0(4), in_1(4), n(3), y(4), n(4));
    fullAdd1b_5: fullAdd1b port map(in_0(5), in_1(5), n(4), y(5), n(5));
    fullAdd1b_6: fullAdd1b port map(in_0(6), in_1(6), n(5), y(6), n(6));
    fullAdd1b_7: fullAdd1b port map(in_0(7), in_1(7), n(6), y(7), n(7));
    fullAdd1b_8: fullAdd1b port map(in_0(8), in_1(8), n(7), y(8), n(8));
    fullAdd1b_9: fullAdd1b port map(in_0(9), in_1(9), n(8), y(9), n(9));
    fullAdd1b_10: fullAdd1b port map(in_0(10), in_1(10), n(9), y(10), n(10));
    fullAdd1b_11: fullAdd1b port map(in_0(11), in_1(11), n(10), y(11), n(11));
    fullAdd1b_12: fullAdd1b port map(in_0(12), in_1(12), n(11), y(12), n(12));
    fullAdd1b_13: fullAdd1b port map(in_0(13), in_1(13), n(12), y(13), n(13));
    fullAdd1b_14: fullAdd1b port map(in_0(14), in_1(14), n(13), y(14), n(14));
    fullAdd1b_15: fullAdd1b port map(in_0(15), in_1(15), n(14), y(15), n(15));
--El acarreo de salida es el acarreo de la última etapa.
    c_out <= n(15);
end aqr;