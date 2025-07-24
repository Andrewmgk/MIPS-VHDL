library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX32to1_tb is
end entity MUX32to1_tb;

architecture Behavioral of MUX32to1_tb is
    signal S       : STD_LOGIC;
    signal Input0  : STD_LOGIC_VECTOR(31 downto 0);
    signal Input1  : STD_LOGIC_VECTOR(31 downto 0);
    signal Output  : STD_LOGIC_VECTOR(31 downto 0);

    component MUX32to1
        port (
            S       : in  STD_LOGIC;
            Input0  : in  STD_LOGIC_VECTOR(31 downto 0);
            Input1  : in  STD_LOGIC_VECTOR(31 downto 0);
            Output  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    uut: MUX32to1 port map (
        S       => S,
        Input0  => Input0,
        Input1  => Input1,
        Output  => Output
    );

    process
    begin
        Input0 <= X"CCCCCCCC";  
        Input1 <= X"BBBBBBBB";  
        S      <= '1';
        wait for 10 ns;
        assert Output = X"BBBBBBBB" 
            report "Error: Incorrect output when S=1!" severity error;

        S      <= '0';
        wait for 10 ns;
        assert Output = X"CCCCCCCC" 
            report "Error: Incorrect output when S=0!" severity error;

        wait;
    end process;
end Behavioral;
