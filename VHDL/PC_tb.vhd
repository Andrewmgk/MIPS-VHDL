library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_tb is
end entity PC_tb;

architecture Behavioral of PC_tb is
    signal Clock, Reset : STD_LOGIC;
    signal PC_in, PC_out : STD_LOGIC_VECTOR(31 downto 0);

    component ProgramCounter
        port (
            Clock   : in  STD_LOGIC;
            Reset   : in  STD_LOGIC;
            PC_in   : in  STD_LOGIC_VECTOR(31 downto 0);
            PC_out  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    uut: ProgramCounter port map (
        Clock   => Clock,
        Reset   => Reset,
        PC_in   => PC_in,
        PC_out  => PC_out
    );

    process
    begin
        Clock <= '0';
        Reset <= '1';  
        wait for 5 ns;

        Reset <= '0';  
        PC_in <= X"AAAA_CCCC"; 
        Clock <= '1';
        wait for 5 ns;
        Clock <= '0';
        wait for 5 ns;

        PC_in <= X"FFFF_BBBB";  
        Clock <= '1';  
        wait for 5 ns;
        Clock <= '0';
        wait for 5 ns;

        wait for 10 ns;

        wait;
    end process;
end Behavioral;
