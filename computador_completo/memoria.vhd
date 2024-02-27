library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoria is
	port(
		control: in std_logic;
		clock: in std_logic; --Señal de reloj
		s_22: in std_logic := '1'; --s_22=1 ESCRITURA,s_22=0 LECTURA
		address: in integer range 0 to 65535; --16 direcciones codificadas por 5 bits
		data_in: in std_logic_vector (7 downto 0); --Ancho de palabra de 8 bits
		data_out: out std_logic_vector (7 downto 0)); --Salida de datos
end memoria;

architecture rtl of memoria is
	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type datos is array (53759 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : datos := (
		0 => x"C3", -- lda p,#PILA_ini ; preparar pila
		1 => x"00",
		2 => x"CF",
		3 => x"8F", -- lda x,#Fibo0 ; apuntar a inicio de la serie
		4 => x"01",
		5 => x"00",
		6 => x"41", -- lda a,#SEMILLA0
		7 => x"00",
		8 => x"36", -- bsr plantar
		9 => x"00",
		10 => x"21",
		11 => x"41", -- lda a,#SEMILLA1
		12 => x"01",
		13 => x"36", -- bsr plantar
		14 => x"00",
		15 => x"21",
		16 => x"8F", -- lda x,#Fibo0
		17 => x"01",
		18 => x"00",
		19 => x"CF", -- lda y,#Fibo1
		20 => x"01",
		21 => x"01",
		22 => x"81", -- lda b,#N
		23 => x"05",
		24 => x"54", -- dec b
		25 => x"36", -- bsr gen_fibo
		26 => x"00",
		27 => x"2D",
		28 => x"54", -- dec b
		29 => x"28", -- bnz sgte_num
		30 => x"00",
		31 => x"19",
		32 => x"10", -- hlt
		33 => x"81", -- lda b,#DIM
		34 => x"01",
		35 => x"80", -- sta a,ix
		36 => x"02",
		37 => x"00",
		38 => x"01", -- clr a
		39 => x"83", -- inc x
		40 => x"54", -- dec b
		41 => x"28", -- bnz sgte1
		42 => x"00",
		43 => x"23",
		44 => x"37", -- ret
		45 => x"C1", -- lda c,#DIM
		46 => x"01",
		47 => x"20", -- clc
		48 => x"80", -- lda a,ix
		49 => x"01",
		50 => x"00",
		51 => x"80", -- adc a,ix+DIM
		52 => x"0A",
		53 => x"01",
		54 => x"80", -- sta a,iy+DIM
		55 => x"82",
		56 => x"01",
		57 => x"83", -- inc x
		58 => x"93", -- inc y
		59 => x"64", -- dec c
		60 => x"28", -- bnz sgte2
		61 => x"00",
		62 => x"30",
		63 => x"37", -- ret


        -- Finalizando a memoria com zeros
        others => "00000000"
    );
	
	--signal posicion:integer;
	-- Register to hold the address
	signal addr_reg : integer range 0 to 63;
begin
	--posicion<= to_integer(unsigned(address));
	process (clock)
	begin
		if(falling_edge(clock)) then
			if(s_22 = '1') then
				if(control = '1') then
					ram(address) <= data_in;
				end if;
			end if;
		end if;
	end process;
	
	data_out <= ram(address);
	
end rtl;