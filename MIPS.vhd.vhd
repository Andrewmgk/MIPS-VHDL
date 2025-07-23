library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPS is
    port (
        Clock : in  STD_LOGIC;
        Reset : in  STD_LOGIC
    );
end entity MIPS;

architecture Behavioral of MIPS is

    -- Components
    component PC
        port (
            Clock   : in  STD_LOGIC;                     
            Reset   : in  STD_LOGIC;                     
            PC_in   : in  STD_LOGIC_VECTOR(31 downto 0); 
            PC_out  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component Imem
        port (
            Address     : in  STD_LOGIC_VECTOR(3 downto 0);
            Instruction : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component MUX32to1
        port (
            Input0 : in  STD_LOGIC_VECTOR(31 downto 0);
            Input1 : in  STD_LOGIC_VECTOR(31 downto 0);
            S      : in  STD_LOGIC;
            Output : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component MUX2to1
        port (
            Input0 : in  STD_LOGIC_VECTOR(4 downto 0);
            Input1 : in  STD_LOGIC_VECTOR(4 downto 0);
            S      : in  STD_LOGIC;
            Output : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
    
    component ControlUnit
        port (
            Opcode   : in  STD_LOGIC_VECTOR(5 downto 0);
            ALUop    : out STD_LOGIC_VECTOR(1 downto 0);
            Clock    : in  STD_LOGIC;
            RegDst   : out STD_LOGIC;
            ALUSrc   : out STD_LOGIC;
            MemtoReg : out STD_LOGIC;
            RegWrite : out STD_LOGIC;
            MemRead  : out STD_LOGIC;
            MemWrite : out STD_LOGIC;
            Branch   : out STD_LOGIC
        );
    end component;
    
    component RegisterFile
        port (
            Clock      : in  STD_LOGIC;
            RegWrite   : in  STD_LOGIC;
            ReadReg1   : in  STD_LOGIC_VECTOR(4 downto 0);
            ReadReg2   : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteReg   : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteData  : in  STD_LOGIC_VECTOR(31 downto 0);
            ReadData1  : out STD_LOGIC_VECTOR(31 downto 0);
            ReadData2  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component Datamem
        port (
        Address   : in  STD_LOGIC_VECTOR(31 downto 0);  
        WriteData : in  STD_LOGIC_VECTOR(31 downto 0); 
        MemWrite  : in  STD_LOGIC;                     
        MemRead   : in  STD_LOGIC;                   
        Clock     : in  STD_LOGIC;                     
        ReadData  : out STD_LOGIC_VECTOR(31 downto 0)  
    );
    end component;
    
    component ALU
        port (
            A          : in  STD_LOGIC_VECTOR(31 downto 0);
            B          : in  STD_LOGIC_VECTOR(31 downto 0);
            ALUop	   : in  STD_LOGIC_VECTOR(3 downto 0);
            Result     : out STD_LOGIC_VECTOR(31 downto 0);
            Zero       : out STD_LOGIC
        );
    end component;
    
    component ALUControl
        port (
            Funct       : in  STD_LOGIC_VECTOR(5 downto 0);
            ALUOp      : in  STD_LOGIC_VECTOR(1 downto 0);
            ALUControl : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component SignExtension
        port (
            Input16  : in  STD_LOGIC_VECTOR(15 downto 0);
            Output32 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component LeftShift
        port (
            Input32  : in  STD_LOGIC_VECTOR(31 downto 0);
            Output32 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component Adder32
        port (
            A   : in  STD_LOGIC_VECTOR(31 downto 0);
            B   : in  STD_LOGIC_VECTOR(31 downto 0);
            Sum : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	    	
	-- Increase by 1
	signal one : std_logic_vector(31 downto 0) := (others => '0');
	
    -- PC signals
    signal PC_in, PC_out : STD_LOGIC_VECTOR(31 downto 0);
    signal PCNext      : STD_LOGIC_VECTOR(31 downto 0);

    -- Instruction Memory
    signal Instruction : STD_LOGIC_VECTOR(31 downto 0);

    -- Control Unit
    signal Opcode : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUop  : STD_LOGIC_VECTOR(1 downto 0);
    signal RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch : STD_LOGIC;

    -- Mux 5-bit (RegDst selection)
    signal MuxRegDstOut : STD_LOGIC_VECTOR(4 downto 0);

    -- Register File signals
    signal RegRead1, RegRead2 : STD_LOGIC_VECTOR(31 downto 0);

    -- Mux 32-bit for ALU second operand selection
    signal muxaluOut : STD_LOGIC_VECTOR(31 downto 0);

    -- Sign Extension
    signal SignImm : STD_LOGIC_VECTOR(31 downto 0);

    -- ALU Control signals
    signal Func           : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUControl_out : STD_LOGIC_VECTOR(3 downto 0);

    -- ALU signals
    signal ALUResult : STD_LOGIC_VECTOR(31 downto 0);
    signal ZeroFlag  : STD_LOGIC;

    -- Data Memory output
    signal DataMemOut : STD_LOGIC_VECTOR(31 downto 0);

    -- Mux 32-bit for selecting writeback data (MemtoReg selection)
    signal MuxMemtoRegOut : STD_LOGIC_VECTOR(31 downto 0);

    -- LeftShift 
    signal ShiftImm : STD_LOGIC_VECTOR(31 downto 0);
	
begin
    
    -- Program Counter
    PC_Inst: PC
       port map (
           Clock   => Clock,
           Reset   => Reset,
           PC_in   => PCNext,
           PC_out  => PC_out
       );

    -- Instruction Memory
    Imem_Inst: Imem
       port map (
           Address     => PC_out(3 downto 0),
           Instruction => Instruction
       );

   -- Register File
    RegFileInst: RegisterFile
       port map (
           Clock      => Clock,
           RegWrite   => RegWrite,
           ReadReg1   => Instruction(25 downto 21),
           ReadReg2   => Instruction(20 downto 16),
           WriteReg   => MuxRegDstOut,
           WriteData  => MuxMemtoRegOut,
           ReadData1  => RegRead1,
           ReadData2  => RegRead2
       );

    -- Control Unit
    ControlInst: ControlUnit
       port map (
           Opcode => Instruction(31 downto 26),
           ALUop     => ALUop,
           Clock     => Clock,
           RegDst    => RegDst,
           ALUSrc    => ALUSrc,
           MemtoReg  => MemtoReg,
           RegWrite  => RegWrite,
           MemRead   => MemRead,
           MemWrite  => MemWrite,
           Branch    => Branch
       );

    -- ALU Control
    ALUControlInst: ALUControl
       port map (
           Funct       => Instruction(5 downto 0),
           ALUOp      => ALUop,
           ALUControl => ALUControl_out
       );

    -- ALU
    ALUInst: ALU
       port map (
           A          => RegRead1,
           B          => muxaluOut,
           ALUop => ALUControl_out,
           Result     => ALUResult,
           Zero       => ZeroFlag
       );

   
	-- Mux2to1_5bit for selecting the write register
    Mux5Inst: MUX2to1
       port map (
           Input0 => Instruction(20 downto 16),
           Input1 => Instruction(15 downto 11),
           S      => RegDst,
           Output => MuxRegDstOut
       );
	   
    -- Mux2to1_32bit for selecting the second operand of ALU
    Mux32Inst: MUX32to1
       port map (
           Input0 => RegRead2,
           Input1 => SignImm,
           S      => ALUSrc,
           Output => muxaluOut
       );
	   
    -- Mux2to1_32bit for selecting the data that will be written back at Register File (ALU ή Datamem)
    MuxMemtoRegInst: MUX32to1
       port map (
           Input0 => ALUResult,
           Input1 => DataMemOut,
           S      => MemtoReg,
           Output => MuxMemtoRegOut
       );
	   
    -- Data Memory
    DataMemInst: Datamem
       port map (
           Address   => ALUResult,
           WriteData => RegRead2, 
           MemWrite  => MemWrite,
           MemRead   => MemRead,
		   Clock   => Clock,
           ReadData  => DataMemOut
       );
    -- LeftShift calculate instruction's offset (we dont use it with the default Instruction memory)
    LeftShiftInst: Leftshift
       port map (
           Input32  => SignImm,
           Output32 => ShiftImm
       );

    -- Sign Extension
    SignExtInst: SignExtension
       port map (
           Input16  => Instruction(15 downto 0),
           Output32 => SignImm
       );
	   
    -- Adder32 update PC by 1.
    Adder32Inst: Adder32
       port map (
           A   => PC_out,
           B   => x"00000001",
           Sum => PCNext
       );

end Behavioral;