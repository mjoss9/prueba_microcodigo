-- puntero de datos
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PDatos is
port(RDat: in integer range 0 to 65535;	--Dato
		RDatD: in integer range 0 to 255;
		s: in std_logic_vector(60 downto 55);
		PDat_EN: in std_logic;					--Habilitador del Puntero de Datos
		clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		IX,IY,PP,PDat: out integer range 0 to 65535);  --Puntero
end PDatos;

architecture arch of PDatos is
--Componente de puntero
	component Puntero is
	port(dat: in integer range 0 to 65535;	--Dato
		I_D,load,enable,clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		pointer: out integer range 0 to 65535);  --Puntero
	end component;
	signal pointer_IX,pointer_IY,pointer_PP : integer range 0 to 65535;
	signal IXD,IYD : integer range 0 to 65535;
	--signal RdatDH : integer range 0 to 255 := 0;
begin
	Puntero_IX: Puntero port map (RDat,s(58),s(59),s(55),clock,pointer_IX);
	Puntero_IY: Puntero port map (RDat,s(58),s(59),s(56),clock,pointer_IY);
	Puntero_PP: Puntero port map (RDat,s(58),s(59),s(57),clock,pointer_PP);
	process(s(60),PDat_EN, pointer_IX, pointer_IY, pointer_PP, RDatD)
	begin
	if(PDat_EN = '1') then
		IX <= pointer_IX;
		IY <= pointer_IY;
		PP <= pointer_PP;
		
		IXD <= pointer_IX + RDatD;		--IX con desplazamiento
		IYD <= pointer_IY + RDatD;		--IY con desplazamiento
	
		if(s(60) = '0') then
			PDat <= IXD;
		elsif(s(60) = '1') then
			PDat <= IYD;
		end if;
	end if;
	end process;
end arch;