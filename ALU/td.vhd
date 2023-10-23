--Modulo del tambor de desplazamiento
library ieee;
use ieee.std_logic_1164.all;

entity td is
port(in_0 : in std_logic_vector(7 downto 0); 	-- Entrada de datos del tambor
	  s : in std_logic_vector(2 downto 0); 		-- Palabra de control para seleccionar tipo de desp.
	  c_in : in std_logic;								-- Acarreo de entrada del tambor
	  td_out : out std_logic_vector(7 downto 0);	-- Salida del tambor
	  c_out: out std_logic);                  	-- Acarreo de salida del tambor
end td;

architecture arch of td is	
signal R : std_logic_vector(8 downto 0); 			--Variable auxiliar
begin
with s select
		R   <= (c_in&in_0(7 downto 0))				when "111", -- Ninguna operacion
				 (in_0(0)&in_0(7)&in_0(7 downto 1)) when "100",	-- Desplazamiento aritmetico a la derecha
				 (in_0(0)&'0'&in_0(7 downto 1))  	when "101",	-- Desplazamiento logico a la derecha
				 (in_0(7 downto 0)&'0') 				when "110",	-- Desplazamiento aritmetico a la izquierda
				 (c_in&in_0(0)&in_0(7 downto 1)) 	when "000",	-- Rotacion a la derecha
				 (in_0(0)&c_in&in_0(7 downto 1)) 	when "001",	-- Rotacion con carreo a la derecha
				 (c_in&in_0(6 downto 0)&in_0(7)) 	when "010",	-- Rotacion a la izquierda
				 (in_0(7 downto 0)&c_in) 				when "011";	-- Rotacion con carreo a la izquierda
td_out <= R(7 downto 0);   --Transferencia del resultado a la salida
c_out <= R(8);

end arch;