library ieee;
use ieee.std_logic_1164.all;
-- Describimos la entidad del calculo de banderas:
entity cb is
port (	c_ubc	: in std_logic; 	-- Acarreo de la UBC
			h_ubc	: in std_logic;  --	Acarreo intermedio de la UBC
			a_7		: in std_logic;							-- Bit mas significativo entrada A
			b_7		: in std_logic;  -- 
			ubc_out		: in std_logic_vector(7 downto 0);	-- Resultado de la UBC
			c_td	: in std_logic;							-- Acarreo tambor de desplazamiento
			s		: in std_logic_vector(11 downto 0);	-- Control de la ALU
			r7_alu	: in std_logic;
			V,N,Z,P,C,H	:	out std_logic); --Banderas
end cb;

architecture aqr of cb is
signal	SR : std_logic;
begin
	SR <= s(4)and s(3)and s(0);
	process(s,c_ubc,h_ubc,a_7,b_7,ubc_out,c_td,r7_alu,SR)
	begin
		if ((s(9)='1') and (s(10)='1')) then
			-- Unidad Basica de calculo UBC
			C <= c_ubc;
			H <= h_ubc;
			V <= (((not a_7 and not b_7 and ubc_out(7)) or (a_7 and b_7 and not ubc_out(7))) and not SR) or (((not a_7 and b_7 and ubc_out(7))or(a_7 and not b_7 and not ubc_out(7))) and SR);
		elsif s(11) = '1' then
			-- Tambor de desplazamiento TD
			C <= c_td;
			H <= '0';
			V <= r7_alu xor c_td;
		else 
			-- Caso para AND OR XOR
			C <= '0';
			H <= '0';
			V <= '0';
		end if;
		N <= ubc_out(7);
		Z <= not(ubc_out(7)or ubc_out(6)or ubc_out(5)or ubc_out(4)or ubc_out(3)or ubc_out(2)or ubc_out(1)or ubc_out(0));
		P <= not(ubc_out(0) xor (ubc_out(1) xor (ubc_out(2) xor (ubc_out(3) xor (ubc_out(4) xor (ubc_out(5) xor (ubc_out(6) xor ubc_out(7))))))));	
	end process;
end aqr;
		
		
		
