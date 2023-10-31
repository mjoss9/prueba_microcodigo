library ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp_mem_shared is
    port (
        clk : in std_logic;
        pi_in : in integer range 0 to 65535;
        data_in : in std_logic_vector(7 downto 0);
        A : inout std_logic_vector(7 downto 0);
        B : inout std_logic_vector(7 downto 0);
        C : inout std_logic_vector(7 downto 0);
        flags : buffer std_logic_vector(5 downto 0);
        RI : out std_LOGIC_VECTOR(7 downto 0);
        PI : out integer range 0 to 65535;
        Micro_secuencia : out std_logic_vector(3 downto 0);
        signal_control : out std_LOGIC_VECTOR(12 downto 0);
        cod_ope : out std_LOGIC_VECTOR(7 downto 0);
        data_buss : out std_logic_vector(7 downto 0);
        addr_mem_micro : out std_logic_vector(11 downto 0);
        rd : out std_logic_vector(15 downto 0);
        RA : out std_logic_vector(15 downto 0);
        descod1 : out std_logic_vector(30 downto 0)
    );
end comp_mem_shared;

architecture rtl of comp_mem_shared is
-- Listamos los componentes que vamos a usar
-- ALU
component ALU_mux is
    port(
        in_a_0, in_a_1, in_a_2 : in std_logic_vector(7 downto 0);
        in_b_0, in_b_1, in_b_2, in_b_3, in_b_4 : in std_logic_vector(7 downto 0);
        sel_a : in std_logic_vector(1 downto 0);
        sel_b : in std_logic_vector(2 downto 0);
        sel_alu : in std_logic_vector(11 downto 0);
        c_in : in std_logic;
        alu_out : out std_logic_vector(7 downto 0);
        alu_C, alu_V, alu_H, alu_N, alu_Z, alu_P :	out std_logic
    );
end component ALU_mux;
-- Acumulador
component AcumuladorEN is
    port(inAc: in std_logic_vector(7 downto 0);		-- Entrada del acumulador
	  outAc: out std_logic_vector(7 downto 0);	-- Salida del acumulador
	  enAc: in std_logic;					-- Habilitador del acumulador
	  ctrlAc:	in std_logic;					-- Control para el descodificador
	  clk: in std_logic						-- Reloj de disparo
);
end component AcumuladorEN;

-- Registro de banderas
component reg_flags is
    port (
        C_in, V_in, H_in, N_in, Z_in, P_in : in std_logic;
        s : in std_logic_vector(7 downto 0); --Palabra de control
        ctrl_C, ctrl_V, ctrl_H, ctrl_N, ctrl_Z, ctrl_P : in std_logic;
        C_out, V_out, H_out, N_out, Z_out, P_out : buffer std_logic
    );
end component reg_flags;

-- Interfaz ALU bus de datos
component interfazTxZ is
    port(inInterfaz: in std_logic_vector(7 downto 0);		-- Entrada
	  outInterfaz: out std_logic_vector(7 downto 0);	-- Salida
	  enPass: in std_logic		-- Habilitador de paso. Si enPass = '1' deja pasar. Si enPass = '0' estado de alta impedancia.
    );
end component interfazTxZ;

------------------ COMPONENTES PARA LA UNIDAD DE DIRECCIONAMIENTO ----------------
-- Registro
component registro is
    port (
        in_0 : in std_logic_vector (7 downto 0); --Entrada
        clock : in std_logic;         --Entrada clock
		control : in std_logic := '0';
		Q : out std_logic_vector (7 downto 0));--Salida
end component registro;

-- Decodificador de instrucciones
component descodUSCE is
    port(
        in_s: in std_logic_vector(7 downto 0);
        out_s: out std_logic_vector(30 downto 0)
    );
end component descodUSCE;

-- Puntero de instrucciones
component puntero is
    port(dat: in integer range 0 to 65535;	--Dato
		I_D,load,enable,clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
		pointer: out integer range 0 to 65535);  --Puntero
end component puntero;

-- Mux 2 a 1 con salida de 16 bits
component mux16b2a1 is
    port(	in_0			:	IN integer range 0 to 65535;--Entradas del multiplexor
		in_1			:	IN STD_LOGIC_VECTOR (15 DOWNTO 0);--Entradas del multiplexor
		s				:	in std_logic;
		y				:	OUT STD_LOGIC_VECTOR (15 DOWNTO 0));--Salida del multiplexor
end component mux16b2a1;

-- Registro de direcciones
component reg_direc is
    port (
        in_0 : in std_logic_vector (15 downto 0); --Entrada
        clock : in std_logic;         --Entrada clock
        control : in std_logic;
		  Q : out std_logic_vector (15 downto 0));--Salida
end component reg_direc;

-- Memoria compartida
component memoria is
    port(
		control: in std_logic; --signal de control
		clock: in std_logic; --signal de reloj
		s_22: in std_logic := '1'; --s_21=1 ESCRITURA,s_21=0 LECTURA
		address: in natural range 0 to 63; --16 direcciones codificadas por 5 bits
		data_in: in std_logic_vector (7 downto 0); --Ancho de palabra de 8 bits
		data_out: out std_logic_vector (7 downto 0)); --Salida de datos
end component memoria;

---- COMPONENTES PARA LA UNIDAD DE CONTROL ----

-- LCT para banderas
component LCT_banderas is
    port(N_in,Z_in,P_in,H_in,C_in,V_in : in std_logic; --Banderas de entrada
        s : in std_logic_vector(7 downto 0); --Palabra de control
        clock : in std_logic;	    					--Reloj
        N_out,Z_out,P_out,H_out,C_out,V_out : out std_logic);  --Banderas de salida
end component LCT_banderas;

-- Memoria de microcodigo
component mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(11 downto 0);
        data : out std_logic_vector(12 downto 0)
    );
end component mem_micro_cod;

-- Generador de microsecuencia
component generador_microsec is
    port(
        clk: in std_logic;
        reset: in std_logic;
        q: out std_logic_vector(3 downto 0)
    );
end component generador_microsec;

------------------ Signal internas
------------------------------------------------
signal data_bus : std_logic_vector(7 downto 0);
signal out_alu : std_logic_vector(7 downto 0);
signal out_flags_alu : std_logic_vector(5 downto 0);
signal cod_op : std_logic_vector(7 downto 0) := "00000000";
signal cod_argu : std_logic_vector(15 downto 0);
signal cod_argu_L : std_logic_vector(15 downto 0);
signal cod_argu_H : std_logic_vector(7 downto 0);
signal pointer : integer range 0 to 65535;
signal in_reg_direc : std_logic_vector(15 downto 0);
signal out_reg_direc : std_logic_vector(15 downto 0);
signal out_interfaz_A : std_logic_vector(7 downto 0);

signal descod_signals : std_logic_vector(30 downto 0);

signal microsec : std_logic_vector(3 downto 0);
signal control_signals : std_logic_vector(12 downto 0);

begin

----------------- Conexiones para la Unidad de ejecucion ---------------------
-------------------------------------------------------------------------------
-- Conecciones entre ALU, acumuladores y registro de banderas
ALU_1 : ALU_mux port map(
    in_a_0 => A,
    in_a_1 => B,
    in_a_2 => C,
    in_b_0 => data_in,
    in_b_1 => data_bus,
    in_b_2 => A,
    in_b_3 => B,
    in_b_4 => C,
    sel_a => descod_signals(1 downto 0),  --DESCODIFICADOR
    sel_b => descod_signals(3 downto 1),  --DESCODIFICADOR
    sel_alu => descod_signals(11 downto 0),  --DESCODIFICADOR
    c_in => out_flags_alu(0),
    alu_out => out_alu,
    alu_C => out_flags_alu(0),
    alu_V => out_flags_alu(1),
    alu_H => out_flags_alu(2),
    alu_N => out_flags_alu(3),
    alu_Z => out_flags_alu(4),
    alu_P => out_flags_alu(5)
);

ACUMULADOR_A_0 : AcumuladorEN port map(
    inAc => out_alu,
    outAc => A,
    enAc => control_signals(1),  
	 ctrlAc => descod_signals(10),	--DESCODIFICADOR
    clk => clk
);

ACUMULADOR_B_0 : AcumuladorEN port map(
    inAc => out_alu,
    outAc => B,
    enAc => control_signals(1),
	 ctrlAc => descod_signals(9),	--DESCODIFICADOR
    clk => clk
);

ACUMULADOR_C_0 : AcumuladorEN port map(
    inAc => out_alu,
    outAc => C,
    enAc => control_signals(1),
	 ctrlAc => descod_signals(8),	--DESCODIFICADOR
    clk => clk
);

INTERFAZ_A_0 : interfazTxZ port map(
    inInterfaz => out_alu,
    outInterfaz => out_interfaz_A,
    enPass => control_signals(2)  --CONTROL
);
-------------- Conexiones para la unidad de direccionamiento -----------------------
-------------------------------------------------------------------------------
-- Conexiones para el registro de instrucciones
    REG_INSTRUCCIONES_0 : registro port map(
        in_0 => data_bus,
        clock => clk,
		control => control_signals(12), ---CONTROL
        Q => cod_op
    );
-- Conxiones para el registro de argumento
    REG_ARGUMENTO_L : registro port map(
        in_0 => data_bus,
        clock => clk,
        control => control_signals(10), ---CONTROL
        Q => cod_argu(7 downto 0)
    );

    REG_ARGUMENTO_H : registro port map(
        in_0 => data_bus,
        clock => clk,
        control => control_signals(11), ---CONTROL
        Q => cod_argu(15 downto 8)
    );
	 
-- Conexiones del puntero de instrucciones
    PUNTERO_INSTRUCCIONES_0 : puntero port map(
        dat => pi_in,
        I_D => control_signals(9), ---CONTROL
        load => control_signals(8), ---CONTROL
        enable => control_signals(7), ---CONTROL
        clock => clk,
        pointer => pointer
    );

-- Mux para el registro de direcciones
    MUX_1 : mux16b2a1 port map(
        in_0 => pointer,
        in_1 => cod_argu,
        s => control_signals(6), ---CONTROL
        y => in_reg_direc
    );
    
-- -- Registro de direcciones
    REG_DIRECCIONES_0 : reg_direc port map(
        in_0 => in_reg_direc,
        clock => clk,
        control => control_signals(5), ---CONTROL
        Q => out_reg_direc
    );
-- -- Conexiones para la memoria
    MEMORIA_0 : memoria port map(
		control => control_signals(4), ---CONTROL
        clock => clk,
        s_22 => descod_signals(20), ---DESCODIFICADOR
        address => to_integer(unsigned(out_reg_direc)),
        data_in => out_alu,
        data_out => data_bus
    );

--------------------- Conexiones para la logica de control --------------------
-------------------------------------------------------------------------------
----
-- Descodificador
DESCODIFICADOR_0 : descodUSCE port map(
    in_s => cod_op,
    out_s => descod_signals
);

-- LCT de banderas
LCT_BANDERAS_0 : LCT_banderas port map(
    N_in => out_flags_alu(3),
    Z_in => out_flags_alu(4),
    P_in => out_flags_alu(5),
    H_in => out_flags_alu(2),
    C_in => out_flags_alu(0),
    V_in => out_flags_alu(1),
    s => descod_signals(19 downto 12),  -- DESCODIFICADOR
    clock => control_signals(8),
    N_out => flags(3),
    Z_out => flags(4),
    P_out => flags(5),
    H_out => flags(2),
    C_out => flags(0),
    V_out => flags(1)
);

-- Memoria para almacenar el microcodigo
    MEM_MICRO_COD_0 : mem_micro_cod port map(
        clk => clk,
        addr => cod_op&microsec,
        data => control_signals
    );

-- Generador de la microsecuencia
    GEN_MICROSEC_0 : generador_microsec port map(
        clk => clk,
        reset => control_signals(0), ---CONTROL
        q => microsec
    );
RI <= cod_op;
PI <= pointer;
Micro_secuencia <= microsec;
signal_control <= control_signals;
cod_ope <= cod_op;
data_buss <= data_bus;
addr_mem_micro <= cod_op&microsec;
rd <= out_reg_direc;
RA <= cod_argu;
descod1 <= descod_signals;

end rtl;

