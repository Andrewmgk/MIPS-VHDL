library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Imem is
    port (
        Address    : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit για 16 θέσεις
        Instruction : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity Imem;

architecture Behavioral of Imem is
    type mem_array is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
    signal memory : mem_array := (
        0 => x"20000000",  -- addi $0, $0, 0
        1 => x"20040000",  -- addi $4, $0, 0
        2 => x"20030001",  -- addi $3, $0, 1
        3 => x"20050003",  -- addi $5, $0, 3
        4 => x"AC830000",  -- L1: sw $3, 0($4)
        5 => x"20630001",  -- addi $3, $3, 1
        6 => x"20840001",  -- addi $4, $4, 1
        7 => x"20A5FFFF",  -- addi $5, $5, -1
        8 => x"14A0FFFC",  -- bne $5, $0, L1 (πηγαίνει στη διεύθυνση 4)
        others => (others => '0')
    );
begin
    Instruction <= memory(to_integer(unsigned(Address)));
end Behavioral;
