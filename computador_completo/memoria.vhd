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
		0 => "00001000",
		1 => "00000101",
		2 => "11001010",
		3 => "00000000",
		4 => "00001001",
		5 => "00000101",
		6 => "00000101",
		7 => "00000101",
		8 => "00000101",
		9 => "00000101",
		10 => "00000101",
		11 => "00000101",
		12 => "00000101",
		13 => "00000101",
		14 => "00000101",
		15 => "00000101",
		16 => "00000101",
		17 => "00000101",
		18 => "00000101",
		19 => "00000101",
		20 => "00000101",
		21 => "00000101",
		22 => "00000101",
		23 => "00000101",
		24 => "00000101",

		30 => x"8f", -- lda x,#0x0000
		31 => x"00", -- 0x00
		32 => x"00", -- 0x00
		33 => x"cf", -- lda y,#0010
		34 => x"00", -- 0x00
		35 => x"10", -- 0x10
		36 => x"c1", -- lda c,#0x08
		37 => x"08", -- 0x08
		38 => x"20", -- clc
		39 => x"80", -- lda a,ix
		40 => x"01", -- ix
		41 => x"00", -- 0x00
		42 => x"80", -- adc a,ix+0x08
		43 => x"0a", -- ix
		44 => x"08", -- 0x08
		45 => x"80", -- sta a,iy
		46 => x"82", -- iy
		47 => x"00", -- 0x00
		48 => x"83", -- inc x
		49 => x"93", -- inc y
		50 => x"64", -- dec c
		51 => x"28", -- bnz 0x0027
		52 => x"00", -- 0x00
		53 => x"27", -- 0x27	
		54 => x"10", -- hlt

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