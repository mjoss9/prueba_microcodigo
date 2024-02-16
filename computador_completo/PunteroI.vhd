--Puntero de instrucciones completo
library ieee;
use ieee.std_logic_1164.all;

entity PunteroI is
port(PI_in,RDat_in : in integer range 0 to 65535 := 0;
	  LR,load_Hab,ID_ctrl,EN_ctrl,EN_descod,MUX_ctrl,clock : in std_logic;
	  PI_out : out integer range 0 to 65535 := 0
);
end PunteroI;

architecture arch of PunteroI is
component Puntero is
port(dat: in integer range 0 to 65535;	--Dato
		I_D,load,load2,enable,clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		pointer: out integer range 0 to 65535);  --Puntero
end component Puntero;
signal Dat_PI : integer range 0 to 65535 := 0;
signal load_PI,load2_PI,EN : std_logic;
begin
PI_bloque: Puntero port map (Dat_PI,ID_ctrl,load_PI,load2_PI,EN,clock,PI_out);
load_PI <= LR and load_Hab;
EN <= EN_ctrl and EN_descod;
load2_PI <= load_Hab and not MUX_ctrl;
process(MUX_ctrl,Dat_PI, RDat_in, PI_in)
begin
	if(MUX_ctrl = '1') then
		Dat_PI <= RDat_in;
	else
		Dat_PI <= PI_in;
	end if;
end process;
end arch;