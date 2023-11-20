-- Comparacion de punteros de 16 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity CompPunteros is
    port(
        IX, IY : in std_logic_vector(15 downto 0);
        RDat : in std_logic_vector(15 downto 0);
        S : in std_logic;
        C, N, Z, V : out std_logic
    );
end CompPunteros;

architecture arch of CompPunteros is
--Componente full adders para 16 bits
component fullAdd16b is
    port(
        in_0, in_1: in std_logic_vector(15 downto 0);
        c_in: in std_logic;
        y: out std_logic_vector(15 downto 0);
        c_out: out std_logic
    );
end component;
-- Multiplexor entre IX e IY
    signal Mux : std_logic_vector(15 downto 0);
    signal Resta : std_logic_vector(15 downto 0);
    signal RDat_neg: std_logic_vector(15 downto 0);
    signal v_0, v_1 : std_logic;
	 
begin
	RDat_neg <= not RDat;
	process(IX, IY, S)
		begin
			 if (S = '1') then
				  Mux <= IY;
			 else
				  Mux <= IX;
			 end if;
	end process;
-- Comparador Mux y RDat para modificar las banderas, resta entre Mux y RDat
	process(Mux, RDat, Resta, RDat_neg, v_0, v_1)
		 begin
            Resta <= Mux - RDat;
            v_0 <= not (Mux(15)) and RDat_neg(15) and Resta(15);
            v_1 <= Mux(15) and not (RDat_neg(15)) and not (Resta(15));
            V <= v_0 or v_1;
            N <= Resta(15);
				if (Mux > RDat) then
					C <= '1';
				else 
					C <= '0';
				end if;
				if (Mux = RDat) then
					Z <= '1';
				else 
					Z <= '0';
				end if;
	end process;

end arch ; -- arch