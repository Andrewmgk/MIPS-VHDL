library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Control_tb is
end entity Control_tb;

architecture Behavioral of Control_tb is
    signal Opcode   : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUop    : STD_LOGIC_VECTOR(1 downto 0);
    signal Clock    : STD_LOGIC := '0';
    signal RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch : STD_LOGIC;

    component Control
        port (
            Opcode    : in  STD_LOGIC_VECTOR(5 downto 0);
            ALUop     : out STD_LOGIC_VECTOR(1 downto 0);
            Clock     : in STD_LOGIC;
            RegDst,ALUSrc,MemtoReg,RegWrite	: out STD_LOGIC;
			MemRead,MemWrite,Branch			: out STD_LOGIC
        );
    end component;

begin
    uut: Control port map (
        Opcode   => Opcode,
        ALUop    => ALUop,
        Clock    => Clock,
        RegDst   => RegDst,
        ALUSrc   => ALUSrc,
        MemtoReg => MemtoReg,
        RegWrite => RegWrite,
        MemRead  => MemRead,
        MemWrite => MemWrite,
        Branch   => Branch
    );

    process
    begin
        Opcode <= "001000";  -- addi $1, $0, 4 Opcode = 001000
        Clock <= '1'; wait for 10 ns; Clock <= '0'; wait for 10 ns;
        assert (ALUop = "11" and RegDst = '0' and ALUSrc = '1' and RegWrite = '1' and MemRead = '0' and MemWrite = '0' and Branch = '0')
            report "Error: Wrong inqut for ADDI!" severity error;

        Opcode <= "101011";  -- sw $6, 0($4) Opcode = 101011
        Clock <= '1'; wait for 10 ns; Clock <= '0'; wait for 10 ns;
        assert (ALUop = "00" and ALUSrc = '1' and RegWrite = '0' and MemRead = '0' and MemWrite = '1' and Branch = '0')
            report "Error: Wrong inqut for  SW!" severity error;

        Opcode <= "000101"; -- bne $5, $0, L1 Opcode = 000101
        Clock <= '1'; wait for 10 ns; Clock <= '0'; wait for 10 ns;
        assert (ALUop = "01" and ALUSrc = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch = '1')
            report "Error: Wrong inqut for  BNE!" severity error;

        wait;
    end process;
end Behavioral;