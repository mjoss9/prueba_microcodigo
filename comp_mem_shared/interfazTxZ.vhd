library ieee;
use ieee.std_logic_1164.all;

entity interfazTxZ is
port(inInterfaz: in std_logic_vector(7 downto 0);		-- Entrada
	  outInterfaz: out std_logic_vector(7 downto 0);	-- Salida
	  enPass: in std_logic		-- Habilitador de paso. Si enPass = '1' deja pasar. Si enPass = '0' estado de alta impedancia.
);
end interfazTxZ;

architecture arch of interfazTxZ is
begin
	outInterfaz <= inInterfaz when (enPass = '1') else "ZZZZZZZZ";
end arch;