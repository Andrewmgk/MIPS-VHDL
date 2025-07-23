library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Control is
    port (
        Opcode	: in  STD_LOGIC_VECTOR(5 downto 0); -- Κωδικός λειτουργίας εντολής
		ALUop	: out STD_LOGIC_VECTOR(1 downto 0);
		Clock	: in STD_LOGIC;
        RegDst,ALUSrc,MemtoReg,RegWrite	: out STD_LOGIC;
        MemRead,MemWrite,Branch			: out STD_LOGIC

    );
end entity Control;

architecture Behavioral of Control is
begin
    WITH Opcode select ALUop <= 
        "11" after 4 ps when "001000", -- `addi`
        "00" after 4 ps when "101011", -- `sw`
        "01" after 4 ps when "000101", -- `bne`
        "XX" when others;

    WITH Opcode select MemRead <= 
        '0' when others;

    WITH Opcode select MemWrite <= 
        '1' after 20 ps when "101011", -- `sw`
        '0' when others;

    WITH Opcode select RegWrite <= 
        ('1' and clock) when "001000", -- `addi`
        '0' when others;

    WITH Opcode select ALUSrc <= 
        '1' after 4 ps when "001000", -- `addi`
        '1' after 4 ps when "101011", -- `sw`
        '0' when others;

    WITH Opcode select Branch <= 
        '1' when "000101", -- `bne`
        '0' when others;

    WITH Opcode select MemtoReg <= 
        '0' when others;

    WITH Opcode select RegDst <= 
        '0' when "001000", -- `addi`
        '1' when others;  
end Behavioral;