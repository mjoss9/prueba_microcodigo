--ALU
library ieee;
use ieee.std_logic_1164.all;
--Describiendo la entidad de la ALU
entity ALU is
port( in_0,in_1	:	in std_logic_vector(7 downto 0);  --Entradas a la ALU
		c_in	: in std_logic;
		s		:	in std_logic_vector(11 downto 0); --Entradas de seleccion
		alu_out		:	out std_logic_vector(7 downto 0); --Salida de la ALU
		C,V,H,N,Z,P		:	out std_logic); 			 --Banderas	
end ALU;

	architecture cuerpoALU of ALU is
--Componentes de la ALU:
--Compuerta AND de 8 bits
		component and8b is
		port (in_0	: in std_logic_vector(7 downto 0); --Entrada x de 8 bits
		in_1	: in std_logic_vector(7 downto 0); --Entrada y de 8 bits
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
		end component;
--Compuerta OR de 8 bits
		component or8b is
		port (in_0	: in std_logic_vector(7 downto 0); --Entrada x de 8 bits
		in_1	: in std_logic_vector(7 downto 0); --Entrada y de 8 bits
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
		end component;
--Compuerta XOR de 8 bits
		component xor8b is
		port (in_0	: in std_logic_vector(7 downto 0); --Entrada x de 8 bits
		in_1	: in std_logic_vector(7 downto 0); --Entrada y de 8 bits
		y	: out std_logic_vector(7 downto 0)); --Salida de 8 bits
		end component;
--Componenete Unidad Basica de Calculo completa
		component UBC is
		port (	in_0	: in std_logic_vector(7 downto 0); 	--Entrada x
		in_1	: in std_logic_vector(7 downto 0);  --Entrada y
		s	: in std_logic_vector(5 downto 0);	--Entradas de control
		c_in	:	in std_logic;	--Entrada de acarreo de registro C
		ubc_out	: out std_logic_vector(7 downto 0); --Salida
		c,h	:	out std_logic);						--Bandera C y H
		end component;
--Tambor de desplazamiento
		component td is
		port(in_0 : in std_logic_vector(7 downto 0); 	-- Entrada de datos del tambor
		s : in std_logic_vector(2 downto 0); 		-- Palabra de control para seleccionar tipo de desp.
		c_in : in std_logic;								-- Acarreo de entrada del tambor
		td_out : out std_logic_vector(7 downto 0);	-- Salida del tambor
		c_out: out std_logic);                  	-- Acarreo de salida del tambor
		end component;
--Generador de banderas
		component cb is
		port (	c_ubc	: in std_logic; 	-- Acarreo de la UBC
		h_ubc	: in std_logic;  --	Acarreo intermedio de la UBC
		a_7		: in std_logic;							-- Bit mas significativo entrada A
		b_7		: in std_logic;  -- 
		ubc_out		: in std_logic_vector(7 downto 0);	-- Resultado de la UBC
		c_td	: in std_logic;							-- Acarreo tambor de desplazamiento
		s		: in std_logic_vector(11 downto 0);	-- Control de la ALU
		r7_alu	: in std_logic;
		V,N,Z,P,C,H	:	out std_logic); --Banderas
		end component;
--Componente MUX 8 a 1 para 8 bits
		component mux8a1 is
		port(	in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7	:	in std_logic_vector(7 downto 0);
		s						:	in std_logic_vector(2 downto 0);
		y						:	out std_logic_vector(7 downto 0));
		end component;
--Declarando Signales auxiliares
		signal	sgn_0	:	std_logic_vector(7 downto 0);
		signal	sgn_1	:	std_logic_vector(7 downto 0);
		signal	sgn_2	:	std_logic_vector(7 downto 0);
		signal	sgn_3	:	std_logic_vector(7 downto 0);
		signal	sgn_4	:	std_logic_vector(7 downto 0);
		signal	aux	:	std_logic_vector(7 downto 0);
		signal	s_ubc :  std_logic_vector(5 downto 0);
		signal	s_td :  std_logic_vector(2 downto 0);
		signal	s_mux :  std_logic_vector(2 downto 0);
		signal	c_ubc, h_ubc, c_td : std_logic;
		signal	r_1	:	std_logic_vector(7 downto 0);
begin	
		aux <= "00000000";
-- Signal de control para UBC:
		s_ubc <= s(5)&s(4)&s(3)&s(2)&s(1)&s(0);
-- Signal de control para TD:
		s_td <= s(8)&s(7)&s(6);
--Signal de control para MUX:
		s_mux <= s(11)&s(10)&s(9);	
--Operacion de AND:
		and_8b_0:	and8b port map(in_0,in_1,sgn_0);
--Operacion de OR:
		or_8b_0:	or8b port map(in_0,in_1,sgn_1);
--Operacion de XOR:		
		xor_8b_0	:	xor8b port map(in_0,in_1,sgn_2);
--Operacion de la UBC:		
		UBC_0	:	UBC port map(in_0,in_1,s_ubc,c_in,sgn_3,c_ubc,h_ubc);
--Operacion de TD:
		tambor_0	:	td port map(sgn_3,s_td,c_in,sgn_4,c_td);
--Operacion del MUX 8 a 1:
		mux_0 : mux8a1 port map(sgn_0,sgn_1,sgn_2,sgn_3,sgn_4,aux,aux,aux,s_mux,r_1);
--Operacion de calculo de banderas:
		CB_0 :	cb port map(c_ubc,h_ubc,in_0(7),in_1(7),r_1,c_td,s,r_1(7),V,N,Z,P,C,H);
		alu_out <= r_1;
	
end cuerpoALU;