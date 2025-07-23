library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Imem_tb is
end entity Imem_tb;

architecture Behavioral of Imem_tb is
    component Imem
        port (
            Address    : in  STD_LOGIC_VECTOR(3 downto 0);
            Instruction : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal Address    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Instruction : STD_LOGIC_VECTOR(31 downto 0);

begin
    uut: Imem port map (
        Address    => Address,
        Instruction => Instruction
    );

    process
    begin
        wait for 10 ns;
        Address <= "0100";
        wait for 10 ns;
        Address <= "0000";
        wait;
    end process;
end Behavioral;
