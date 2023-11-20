library ieee;
use ieee.std_logic_1164.all;

entity AcumuladorEN is
port(inAc: in std_logic_vector(7 downto 0);		-- Entrada del acumulador
	  outAc: out std_logic_vector(7 downto 0);	-- Salida del acumulador
	  enAc: in std_logic;					-- Habilitador del acumulador
	  ctrlAc:	in std_logic;					-- Control para el descodificador
	  clk: in std_logic						-- Reloj de disparo
);
end AcumuladorEN;

architecture arch of AcumuladorEN is
begin
	process(enAC,clk,inAc,ctrlAc)
	begin
	if(enAc = '1') then
		if(clk'event and clk = '0') then
			if(ctrlAc = '1') then
				outAc <= inAc;
			end if;
		end if;
	end if;
	end process;
end arch;