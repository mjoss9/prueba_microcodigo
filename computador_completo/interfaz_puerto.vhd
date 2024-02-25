library ieee;
use ieee.std_logic_1164.all;

entity interfaz_puerto is
    Port (
        puerto  : inout STD_LOGIC_VECTOR(7 downto 0);
		ctrl_port, clock   : in STD_LOGIC;
		bus_ext_out : in STD_LOGIC_VECTOR(7 downto 0);
        bus_ext_in  : out STD_LOGIC_VECTOR(7 downto 0);
		U24         : in STD_LOGIC
    );
end interfaz_puerto;

architecture arch of interfaz_puerto is
    -- Señales auxiliares
    signal a_in : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal b_out : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
begin
    process(clock)
    begin
        if (rising_edge(clock)) then
			if (U24 = '1') then
				a_in <= bus_ext_out;
			end if;
				bus_ext_in <= b_out;
        end if;
    end process;

    process(ctrl_port, puerto)
    begin
        if (ctrl_port = '1') then
            puerto <= "ZZZZZZZZ";
			b_out <= puerto;
        else
            puerto <= a_in;
			b_out <= puerto;
        end if;
    end process;
end arch;
