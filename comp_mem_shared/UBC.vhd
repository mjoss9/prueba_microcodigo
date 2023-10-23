--Unidad Basica de Calculo completa
library ieee;
use ieee.std_logic_1164.all;
-- Describimos la entidad de la UBC:
entity UBC is
port (	in_0	: in std_logic_vector(7 downto 0); 	--Entrada x
			in_1	: in std_logic_vector(7 downto 0);  --Entrada y
			s	: in std_logic_vector(5 downto 0);	--Entradas de control
			c_in	:	in std_logic;	--Entrada de acarreo de registro C
			ubc_out	: out std_logic_vector(7 downto 0); --Salida
			c,h	:	out std_logic);						--Bandera C y H
end UBC;

architecture aqr of UBC is
--Usamos como compenentes: 
--Sumadores completos de 8 bits:
component fullAdd8b
port (	in_0	: in std_logic_vector(7 downto 0); 	--Entrada in0
			in_1	: in std_logic_vector(7 downto 0);  --Entrada Y
			c_in:	in std_logic;							--Acarreo de entrada
			y	: out std_logic_vector(7 downto 0); --Suma
			c_out:	out std_logic);						--Acarreo de salida
end component;
--Control de paso de 8 bits
component paso8b
port (in_0	: in std_logic_vector(7 downto 0); --Entrada de 8 bits
		ctl_pass	:	in std_logic;             --Entrada de control
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
end component;
--Inversor de 8 bits
component inversor8b
port (in_0	: in std_logic_vector(7 downto 0); --Entrada de 8 bits
		ctl_inv	:	in std_logic;             --Entrada de control
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
end component;
--Multiplexor 2 a 1
component mux2a1
port(	in_0,in_1			:	in std_logic;
		s				:	in std_logic;
		y				:	out std_logic);
end component;

--Declaramos variables auxiliares de 8 bits.
		signal x_1,y_1,x_2,y_2, semi_r	: std_logic_vector (7 downto 0);
		signal c_aux, h_1	:	std_logic;

begin
--Realizamos parte de control de paso:
		paso0 : paso8b port map(in_0,s(4),x_1);
		paso1 : paso8b port map(in_1,s(3),y_1);
--Realizamos parte de control de inversion:
		inversor0 : inversor8b port map(x_1,s(2),x_2);
		inversor1 : inversor8b port map(y_1,s(1),y_2);
--Etapa de multiplexor para el acarreo
		mux0	:	mux2a1 port map(s(0),c_in, s(5), c_aux);
--Etapa del sumador de  bits:
		fulladd0 : fullAdd8b port map(x_2,y_2,c_aux,ubc_out,c);
		fulladd1 : fullAdd8b port map("0000"&x_2(3 downto 0),"0000"&y_2(3 downto 0),c_aux,semi_r,h_1);
--Rescatamos el semiacarreo:
		h <= semi_r(4);
end aqr;