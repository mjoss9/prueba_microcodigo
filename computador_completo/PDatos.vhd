-- puntero de datos
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PDatos is
port(RDat: in integer range 0 to 65535;	--Dato
		RDatD: in integer range -128 to 127;
		s: in std_logic_vector(60 downto 55);
		PIndx_EN: in std_logic;					--Habilitador del Punteros Indexados
		PP_EN: in std_logic;					--Habilitador del Puntero de Pila
		clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		IX,IY,PP,PDat: out integer range 0 to 65535 :=0);  --Puntero
end PDatos;

architecture arch of PDatos is
--Componente de puntero
	component Puntero is
		port(dat: in integer range 0 to 65535;	--Dato
		I_D,load,load2,enable,clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		pointer: out integer range 0 to 65535);  --Puntero
	end component;
	signal pointer_IX,pointer_IY,pointer_PP : integer range 0 to 65535;
	signal IXD,IYD : integer range 0 to 65535;
	--signal RdatDH : integer range 0 to 255 := 0;
begin
	Puntero_IX: Puntero port map (RDat,s(58),s(59),s(59),s(55) and PIndx_EN,clock,pointer_IX);
	Puntero_IY: Puntero port map (RDat,s(58),s(59),s(59),s(56) and PIndx_EN,clock,pointer_IY);
	Puntero_PP: Puntero port map (RDat,s(58),not (s(59) and s(58)) and s(59),not (s(59) and s(58)) and s(59),s(57) and PP_EN,clock,pointer_PP);
	process(s(60),PIndx_EN, PP_EN, pointer_IX, pointer_IY, pointer_PP, IXD, IYD)
	begin
	if(PIndx_EN = '1') then
		IX <= pointer_IX;
		IY <= pointer_IY;
	end if;

	if(PP_EN = '1') then
		PP <= pointer_PP;
	end if;

	if(s(60) = '0') then
		PDat <= IXD;
	elsif(s(60) = '1') then
		PDat <= IYD;
	end if;
	end process;

	IXD <= pointer_IX + RDatD;		--IX con desplazamiento
	IYD <= pointer_IY + RDatD;		--IY con desplazamiento

end arch;