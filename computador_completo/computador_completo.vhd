library ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity computador_completo is
    port (
        clk : in std_logic;
        pi_in : in integer range 0 to 65535;
        data_in : in std_logic_vector(7 downto 0);
        A : inout std_logic_vector(7 downto 0);
        B : inout std_logic_vector(7 downto 0);
        C : inout std_logic_vector(7 downto 0);
        flags : buffer std_logic_vector(5 downto 0);
        RI : out std_LOGIC_VECTOR(7 downto 0);
        RI2 : out std_LOGIC_VECTOR(7 downto 0);
        PI : out integer range 0 to 65535;
        Micro_secuencia : out std_logic_vector(3 downto 0);
        signal_control : out std_LOGIC_VECTOR(18 downto 0);
        cod_ope : out std_LOGIC_VECTOR(7 downto 0);
        data_buss : out std_logic_vector(7 downto 0);
        addr_mem_micro : out std_logic_vector(7 downto 0);
        rd : out integer range 0 to 65535;
        descod1 : out std_logic_vector(66 downto 0)
    );
end computador_completo;

architecture rtl of computador_completo is
------------------ COMPONENTES PARA LA UNIDAD DE EJECUCION ----------------
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

------------------ COMPONENTES PARA LA UNIDAD DE DIRECCIONAMIENTO ----------------
-- Registro
component registro is
    port (
        in_0 : in std_logic_vector (7 downto 0); --Entrada
        clock : in std_logic;         --Entrada clock
		control : in std_logic := '0';
		Q : out std_logic_vector (7 downto 0));--Salida
end component registro;

-- Registro de datos
component rdat is
    port (
        dataH : in std_logic_vector (7 downto 0); --Entrada
        dataL : in std_logic_vector (7 downto 0); --Entrada
        clock : in std_logic;         --Entrada clock
        ctrl_dataH : in std_logic;
        ctrl_dataL : in std_logic;
        I : in std_logic; -- Incremento
		Q: out integer range 0 to 65535 := 0);--Salida
end component rdat;

-- Puntero de instrucciones
component PunteroI is
    port(PI_in,RDat_in : in integer range 0 to 65535 := 0;
	  LR,load_Hab,ID_ctrl,EN_ctrl,EN_descod,MUX_ctrl,clock : in std_logic;
	  PI_out : out integer range 0 to 65535 := 0
);
end component PunteroI;

-- Puntero de Datos
component PDatos is
    port(RDat: in integer range 0 to 65535;	--Dato
        RDatD: in integer range 0 to 255;
        s: in std_logic_vector(59 downto 54);
        PDat_EN: in std_logic;					--Habilitador del Puntero de Datos
        clock: in std_logic;  --Incremento/decremento, cargar, habilitar, clock
        IX,IY,PP,PDat: out integer range 0 to 65535);  --Puntero
end component PDatos;

-- Mux de 4 a 1 de 16 bits
component mux16b4a1 is
    port(	in_0			:	IN integer range 0 to 65535;--Entradas del multiplexor
		in_1			:	IN integer range 0 to 65535;--Entradas del multiplexor
		in_2			:	IN integer range 0 to 65535;--Entradas del multiplexor
		in_3			:	IN integer range 0 to 65535;--Entradas del multiplexor
		s				:	in std_logic_vector(1 downto 0);
		y				:	OUT integer range 0 to 65535);--Salida del multiplexor
end component mux16b4a1;

-- Registro de direcciones
component reg_direc is
    port (
        in_0 : in integer range 0 to 65535; --Entrada
        clock : in std_logic;         --Entrada clock
        control : in std_logic;
		  Q : out integer range 0 to 65535);--Salida
end component reg_direc;

-- Interaz de Memoria
component InterfazMemo is
    port( IX,IY,PP, PI: in integer range 0 to 65535;
		resALU: in std_logic_vector(7 downto 0);
		s22: in std_logic;
		s: in std_logic_vector(3 downto 0);		
		ALU_MEM: out std_logic_vector(7 downto 0)
		-- DatoMEM: inout std_logic_vector(7 downto 0)
);
end component InterfazMemo;

-- Memoria compartida
component memoria is
    port(
		control: in std_logic; --signal de control
		clock: in std_logic; --signal de reloj
		s_22: in std_logic := '1'; --s_21=1 ESCRITURA,s_21=0 LECTURA
		address: in natural range 0 to 65535; --16 direcciones codificadas por 5 bits
		data_in: in std_logic_vector (7 downto 0); --Ancho de palabra de 8 bits
		data_out: out std_logic_vector (7 downto 0)); --Salida de datos
end component memoria;

---- COMPONENTES PARA LA UNIDAD DE CONTROL ----
-- Logica de Ramificacion LR
component LR is
    port(
        C, V, N, Z : in std_logic;  -- Banderas de Condicion
        s : in std_logic_vector(18 downto 0); -- Signals of control
        h_c : out std_logic --Habilitacion de carga
    );
end component LR;

-- LCT para banderas
component LCT_banderas is
    port(N_in,Z_in,P_in,H_in,C_in,V_in : in std_logic; --Banderas de entrada
        s : in std_logic_vector(7 downto 0); --Palabra de control
        clock : in std_logic;	    					--Reloj
        N_out,Z_out,P_out,H_out,C_out,V_out : out std_logic);  --Banderas de salida
end component LCT_banderas;

-- Mux de 2 a 1 con salida de 8 bits
component mux8b2a1 is
  port(in_0, in_1			:	IN STD_LOGIC_VECTOR (7 DOWNTO 0);--Entradas del multiplexor
      s				:	in std_logic;
      y				:	OUT STD_LOGIC_VECTOR (7 DOWNTO 0));--Salida del multiplexor
end component mux8b2a1;

-- Decodificador de instrucciones
component descodCC is
    port(
      in_s: in std_logic_vector(7 downto 0);
      ctrl_index: in std_logic;
      out_s: out std_logic_vector(66 downto 0)
  );
end component descodCC;

-- Mux de 4 bits 2 a 1
component mux4b2a1 is
    port(in_0,in_1 :	in std_logic_vector(3 downto 0);
		s :	in std_logic;
		y :	out std_logic_vector(3 downto 0));
end component mux4b2a1;

-- Memoria de microcodigo
component mem_micro_cod is
    port (
        clk : in std_logic;
        addr : in std_logic_vector(7 downto 0);
        data : out std_logic_vector(18 downto 0)
    );
end component mem_micro_cod;

-- Generador de microsecuencia
component generador_microsec is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable : in std_logic;
        q: out std_logic_vector(3 downto 0)
    );
end component generador_microsec;

------------------ Signal internas
------------------------------------------------
signal data_bus : std_logic_vector(7 downto 0);
signal out_interfaz_mem : std_logic_vector(7 downto 0);
signal out_alu : std_logic_vector(7 downto 0);
signal out_flags_alu : std_logic_vector(5 downto 0);
signal out_flags_LCT : std_logic_vector(5 downto 0);
signal reg_flags_out : std_logic_vector(5 downto 0);
signal cod_op : std_logic_vector(7 downto 0) := "00000000";
signal cod_op2 : std_logic_vector(7 downto 0) := "00000000";
signal cod_operacion : std_logic_vector(7 downto 0) := "00000000";
signal desplazamiento : std_logic_vector(7 downto 0) := "00000000";
signal out_reg_dat : integer range 0 to 65535;
signal out_lr : std_logic;
signal pointer : integer range 0 to 65535;
signal IX_out : integer range 0 to 65535;
signal IY_out : integer range 0 to 65535;
signal PP_out : integer range 0 to 65535;
signal PDat_out : integer range 0 to 65535;
signal mux_reg_direc : integer range 0 to 65535;
signal reg_direcciones : integer range 0 to 65535;

signal descod_signals : std_logic_vector(66 downto 0);
signal out_mux_micro : std_logic_vector(3 downto 0);
signal microsec : std_logic_vector(3 downto 0);
signal control_signals : std_logic_vector(18 downto 0);

begin
----------------- Conexiones UNIDAD DE EJECUCION ---------------------
-------------------------------------------------------------------------------
-- Conexiones entre ALU, acumuladores y registro de banderas
ALU_1 : ALU_mux port map(
    in_a_0 => A,
    in_a_1 => B,
    in_a_2 => C,
    in_b_0 => data_in,
    in_b_1 => data_bus,
    in_b_2 => A,
    in_b_3 => B,
    in_b_4 => C,
    sel_a => descod_signals(24 downto 23),  --DESCODIFICADOR
    sel_b => descod_signals(27 downto 25),  --DESCODIFICADOR
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
-- Acumulador A
AcumuladorA : AcumuladorEN port map(
    inAc => out_alu,
    outAc => A,
    enAc => control_signals(16),  --CONTROL
    ctrlAc => descod_signals(28),  --DESCODIFICADOR
    clk => clk
);
-- Acumulador B
AcumuladorB : AcumuladorEN port map(
    inAc => data_bus,
    outAc => B,
    enAc => control_signals(16),  --CONTROL
    ctrlAc => descod_signals(29),  --DESCODIFICADOR
    clk => clk
);
-- Acumulador C
AcumuladorC : AcumuladorEN port map(
    inAc => data_bus,
    outAc => C,
    enAc => control_signals(16),  --CONTROL
    ctrlAc => descod_signals(30),  --DESCODIFICADOR
    clk => clk
);
-- Registro de banderas
Reg_banderas : reg_flags port map(
    C_in => out_flags_LCT(0),
    V_in => out_flags_LCT(1),
    H_in => out_flags_LCT(2),
    N_in => out_flags_LCT(3),
    Z_in => out_flags_LCT(4),
    P_in => out_flags_LCT(5),
    s => descod_signals(34 downto 27),  --DESCODIFICADOR
    ctrl_C => descod_signals(2),  --DESCODIFICADOR
    ctrl_V => descod_signals(3),  --DESCODIFICADOR
    ctrl_H => descod_signals(4),  --DESCODIFICADOR
    ctrl_N => descod_signals(5),  --DESCODIFICADOR
    ctrl_Z => descod_signals(6),  --DESCODIFICADOR
    ctrl_P => descod_signals(7),  --DESCODIFICADOR
    C_out => reg_flags_out(0),
    V_out => reg_flags_out(1),
    H_out => reg_flags_out(2),
    N_out => reg_flags_out(3),
    Z_out => reg_flags_out(4),
    P_out => reg_flags_out(5)
);
----------------- Conexiones UNIDAD DE DIRECCIONAMIENTO ---------------------
-------------------------------------------------------------------------------
-- Registro de Instruciones 1
Reg_I : registro port map(
    in_0 => data_bus,
    clock => clk,
    control => control_signals(0), --CONTROL
    Q => cod_op
);
-- Registro de Instruciones 2
Reg_I2 : registro port map(
    in_0 => data_bus,
    clock => clk,
    control => control_signals(1), --CONTROL
    Q => cod_op2
);
-- Mux de 2 a 1 con salida de 8 bits
Mux8b2a1_0 : mux8b2a1 port map(
    in_0 => cod_op,
    in_1 => cod_op2,
    s => control_signals(2), --DESCODIFICADOR
    y => cod_operacion
);
-- Registro de dezplazamiento de datos
Reg_DatD : registro port map(
    in_0 => data_bus,
    clock => clk,
    control => control_signals(3), --CONTROL
    Q => desplazamiento
);
-- Registro de datos
Reg_Dat : rdat port map(
    dataH => data_bus,
    dataL => data_bus,
    clock => clk,
    ctrl_dataH => control_signals(4), --CONTROL
    ctrl_dataL => control_signals(5), --CONTROL
    I => control_signals(6), --CONTROL
    Q => out_reg_dat
);
-- Puntero de instrucciones
PunteroI1 : PunteroI port map(
    PI_in => pi_in,
    RDat_in => out_reg_dat,
    LR => out_lr, --LOGICA DE RAMIFICACION
    load_Hab => control_signals(8), --CONTROL
    ID_ctrl => control_signals(7), --CONTROL
    EN_ctrl => control_signals(9), --CONTROL
    EN_descod => descod_signals(54), --CONTROL
    MUX_ctrl => control_signals(10), --CONTROL
    clock => clk,
    PI_out => pointer
);
-- Puntero de datos
PunteroD : PDatos port map(
    RDat => out_reg_dat,
    RDatD => to_integer(unsigned(desplazamiento)),
    s => descod_signals(60 downto 55), --DESCODIFICADOR
    PDat_EN => control_signals(11), --CONTROL
    clock => clk,
    IX => IX_out,
    IY => IY_out,
    PP => PP_out,
    PDat => PDat_out
);
-- Mux de 4 a 1 de 16 bits
Mux16b4a1_0 : mux16b4a1 port map(
    in_0 => pointer,
    in_1 => out_reg_dat,
    in_2 => PDat_out,
    in_3 => PP_out,
    s => control_signals(13 downto 12), --DESCODIFICADOR
    y => mux_reg_direc
);
-- Registro de direcciones
Reg_direc_0 : reg_direc port map(
    in_0 => mux_reg_direc,
    clock => clk,
    control => control_signals(14), --CONTROL
    Q => reg_direcciones
);
-- Interfaz de memoria
InterfazMem_0 : InterfazMemo port map(
    IX => IX_out,
    IY => IY_out,
    PP => PP_out,
    PI => pointer,
    resALU => out_alu,
    s22 => descod_signals(22), --DESCODIFICADOR
    s => descod_signals(66 downto 63), --DESCODIFICADOR
    ALU_MEM => out_interfaz_mem
    -- DatoMEM => out_mem
);
-- Conexiones para la memoria
MEMORIA_0 : memoria port map(
    control => control_signals(15), ---CONTROL
    clock => clk,
    s_22 => descod_signals(22), ---DESCODIFICADOR
    address => reg_direcciones,
    data_in => out_interfaz_mem,
    data_out => data_bus
);
----------------- Conexiones UNIDAD DE CONTROL ---------------------
-------------------------------------------------------------------------------
-- LCT para banderas
LCT_banderas_0 : LCT_banderas port map(
    N_in => out_flags_alu(3),
    Z_in => out_flags_alu(4),
    P_in => out_flags_alu(5),
    H_in => out_flags_alu(2),
    C_in => out_flags_alu(0),
    V_in => out_flags_alu(1),
    s => descod_signals(34 downto 27), --DESCODIFICADOR
    clock => clk,
    N_out => out_flags_LCT(3),
    Z_out => out_flags_LCT(4),
    P_out => out_flags_LCT(5),
    H_out => out_flags_LCT(2),
    C_out => out_flags_LCT(0),
    V_out => out_flags_LCT(1)
);
--Logica de Ramificacion LR
Logica_Ramificacion : LR port map(
    C => reg_flags_out(0),
    V => reg_flags_out(1),
    N => reg_flags_out(3),
    Z => reg_flags_out(4),
    s => descod_signals(53 downto 35), --DESCODIFICADOR
    h_c => out_lr
);
-- Decodificador de instrucciones
DescodCC_0 : descodCC port map(
    in_s => cod_operacion,
    ctrl_index => control_signals(2), --CONTROL
    out_s => descod_signals
);
-- Mux de 4 bits 2 a 1
Mux4b2a1_0 : mux4b2a1 port map(
    in_0 => descod_signals(34 downto 31), --DESCODIFICADOR
    in_1 => "0100", --DESCODIFICADOR
    s => not(not cod_op(7) and cod_op(6) and cod_op(5) and cod_op(4) and cod_op(3) and cod_op(2) and cod_op(1) and cod_op(0)), --Registro de Instrucciones
    y => out_mux_micro
);
-- Memoria de microcodigo
Mem_micro_cod_0 : mem_micro_cod port map(
    clk => clk,
    addr => out_mux_micro&microsec,
    data => control_signals
);
-- Generador de microsecuencia
Generador_microsec_0 : generador_microsec port map(
    clk => clk,
    reset => control_signals(17), --CONTROL
    enable => control_signals(18), --CONTROL
    q => microsec
);

RI <= cod_op;
RI2 <= cod_op2;
PI <= pointer;
Micro_secuencia <= microsec;
signal_control <= control_signals;
cod_ope <= cod_operacion;
data_buss <= data_bus;
addr_mem_micro <= out_mux_micro&microsec;
rd <= reg_direcciones;
descod1 <= descod_signals;
end rtl;

