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

		7 => x"C3", -- lda p
		8 => x"00", -- 
		9 => x"2C", -- 
		10 => x"A0", -- sev
		11 => x"30", -- clv
		12 => x"BF", -- lda a
		13 => x"00", -- 
		14 => x"03", -- 
		15 => x"83", -- inc x
		16 => x"42", -- gpi a
		17 => x"90", -- sec
		18 => x"B1", -- lda b,002B
		19 => x"00", -- 
		20 => x"2B", -- 
		21	 => x"10", -- hlt

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