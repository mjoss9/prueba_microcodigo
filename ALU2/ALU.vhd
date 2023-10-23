LIBRARY ieee;
USE ieee.std_logic_1164.all;
	ENTITY ALU IS
		PORT(S : IN STD_LOGIC_VECTOR (11 DOWNTO 0);--Selector S
			X,Y: IN STD_LOGIC_VECTOR (7 DOWNTO 0);--Entradas de la ALU

			CC: IN STD_LOGIC; --Salida realimentada del registro de acarreo
			RR : IN STD_LOGIC_VECTOR (7 DOWNTO 0);--Salida realimentada del registro acumulador

			R : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);--Salida del registro acumulador
			N,Z,V,H,P,C : OUT STD_LOGIC); --Salida de los registros de las banderas
	END ALU;
	
ARCHITECTURE Micro_2 OF ALU IS
--Usamos el programa de la UBC
	component UBC IS
	port (	in_0	: in std_logic_vector(7 downto 0); 	--Entrada x
			in_1	: in std_logic_vector(7 downto 0);  --Entrada y
			s	: in std_logic_vector(5 downto 0);	--Entradas de control
			c_in	:	in std_logic;	--Entrada de acarreo de registro C
			ubc_out	: out std_logic_vector(7 downto 0); --Salida
			c,h	:	out std_logic);						--Bandera C y H
END component;
--Usamos un sumador de 4 bits
	component Nibble_adder IS
	PORT(J,K: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
	C0 : IN STD_LOGIC;
	L : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
	C4 : OUT STD_LOGIC);

END component;
--Usamos señales auxiliares
	signal AND1,OR1,XOR1,RUBC,R1: STD_LOGIC_VECTOR (7 DOWNTO 0);
	--signal L1: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal SR,CUBC: STD_LOGIC;
begin
	--Funcion AND
	AND1 <= ((X(7) AND Y(7))&(X(6) AND Y(6))&(X(5) AND Y(5))&(X(4) AND Y(4))&
	(X(3) AND Y(3))&(X(2) AND Y(2))&(X(1) AND Y(1))&(X(0) AND Y(0)));
	--Funcion OR
	OR1 <= ((X(7) OR Y(7))&(X(6) OR Y(6))&(X(5) OR Y(5))&(X(4) OR Y(4))&
	(X(3) OR Y(3))&(X(2) OR Y(2))&(X(1) OR Y(1))&(X(0) OR Y(0)));
	--Funcion XOR
	XOR1 <= ((X(7) XOR Y(7))&(X(6) XOR Y(6))&(X(5) XOR Y(5))&(X(4) XOR Y(4))&
	(X(3) XOR Y(3))&(X(2) XOR Y(2))&(X(1) XOR Y(1))&(X(0) XOR Y(0)));
	--Ejecutamos el programa de la UBC
	ALU_0 : UBC PORT MAP (X,Y,S(5 DOWNTO 0),CC,RUBC,CUBC,H);
	--Salida R
PROCESS (S, AND1, OR1, XOR1, RUBC, RR, CC, CUBC)
begin
if S(11 DOWNTO 9) = "000" THEN R1 <= AND1; --Operacion AND

ELSIF S(11 DOWNTO 9) = "001" THEN R1 <= OR1; --Operacion OR
ELSIF S(11 DOWNTO 9) = "010" THEN R1 <= XOR1;
--Operacion XOR
ELSIF S(11 DOWNTO 9) = "011" THEN R1 <= RUBC;
--Ejecutar la UBC
ELSIF S(11 DOWNTO 6) = "100000" THEN R1 <= (RR(0)&RR(7 DOWNTO 1)); --Ejecutar ROD
ELSIF S(11 DOWNTO 6) = "100010" THEN R1 <= (RR(6 DOWNTO 0)&RR(7)); --Ejecutar ROI
ELSIF S(11 DOWNTO 6) = "100001" THEN R1 <= (CC&RR(7 DOWNTO 1)); --Ejecutar RCD
ELSIF S(11 DOWNTO 6) = "100011" THEN R1 <= (RR(6 DOWNTO 0)&CC); --Ejecutar RCI
ELSIF S(11 DOWNTO 6) = "100100" THEN R1 <= (RR(7)&RR(7 DOWNTO 1)); --Ejecutar DAD
ELSIF S(11 DOWNTO 6) = "100110" THEN R1 <= (RR(6 DOWNTO 0)&'0'); --Ejecutar DAI
ELSIF S(11 DOWNTO 6) = "100101" THEN R1 <= ('0'&RR(7 DOWNTO 1)); --Ejecutar DLD

ELSE R1 <= RUBC;
END IF;
END PROCESS;
--Salida R de la ALU
R <= R1;
--BANDERAS
	--Bandera Z (Detector de cero)
	Z <= NOT(R1(7) OR R1(6) OR R1(5) OR R1(4) OR
	R1(3) OR R1(2) OR R1(1) OR R1(0));
	--Bandera N (Detector de Numero Negativo)
	N <= R1(7);
	--Bandera V (Detector de exceso o desborde (overflow))
	SR <= (S(4) AND S(3) AND S(0));
	V <= (NOT(SR) AND ((NOT(X(7)) AND NOT(Y(7)) AND R1(7)) OR
	(X(7) AND Y(7) AND NOT(R1(7))))) OR
	(SR AND ((NOT(X(7)) AND (Y(7)) AND R1(7)) OR
	(X(7) AND NOT(Y(7)) AND NOT(R1(7)))));
	--Bandera P (Detector de paridad IMPAR)
	P <= NOT((R1(7) XOR R1(6) XOR R1(5) XOR R1(4) XOR
	R1(3) XOR R1(2) XOR R1(1) XOR R1(0)));
	--Bandera H
	--ALU_1 : Nibble_adder PORT MAP (X(3 DOWNTO 0),Y(3 DOWNTO 0),'0',L1,H);
	--Bandera C
--Salida del acarreo del tambor de desplazamiento
PROCESS (S, RR, CUBC)
begin
IF S(11 DOWNTO 6) = "100000" THEN C <= RR(0); --Ejecutar ROD
ELSIF S(11 DOWNTO 6) = "100010" THEN C <= RR(7); --Ejecutar ROI
ELSIF S(11 DOWNTO 6) = "100001" THEN C <= RR(0); --Ejecutar RCD
ELSIF S(11 DOWNTO 6) = "100011" THEN C <= RR(7); --Ejecutar RCI
ELSIF S(11 DOWNTO 6) = "100100" THEN C <= RR(0); --Ejecutar DAD
ELSIF S(11 DOWNTO 6) = "100110" THEN C <= RR(7); --Ejecutar DAI
ELSIF S(11 DOWNTO 6) = "100101" THEN C <= RR(0); --Ejecutar DLD

ELSE C <= CUBC;
END IF;
END PROCESS;
end Micro_2;