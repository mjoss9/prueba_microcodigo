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
	type datos is array (63 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : datos := (
        0 => "00001000",
        1 => "00000100",
        2 => "00000000",
        3 => "00000000",
        4 => "00001001",
		5 => "00000101",

		7 => x"C3", -- lda p
		8 => x"00", -- 
		9 => x"2C", -- 
		10 => x"A0", -- sev
		11 => x"BF", -- lda x
		12 => x"00", -- 
		13 => x"03", -- 
		14 => x"36", -- bsr
		15 => x"00", -- 
		16 => x"19", -- 
		17 => x"C2", -- gpi x
		18 => x"83", -- 
		19 => x"90", -- sec
		20 => x"B1", -- lda b, number
		21 => x"00", -- 
		22 => x"05", -- 
		23 => x"C0", -- 
		24 => x"10", -- hlt
		25 => x"71", -- lda a, number
		26 => x"00", -- 
		27 => x"05", -- 
		28 => x"37", -- ret

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