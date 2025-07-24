library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX2to1_tb is
end entity MUX2to1_tb;

architecture Behavioral of MUX2to1_tb is
    signal S       : STD_LOGIC;
    signal Input0  : STD_LOGIC_VECTOR(4 downto 0);
    signal Input1  : STD_LOGIC_VECTOR(4 downto 0);
    signal Output  : STD_LOGIC_VECTOR(4 downto 0);

    component MUX2to1
        port (
            S       : in  STD_LOGIC;
            Input0  : in  STD_LOGIC_VECTOR(4 downto 0);
            Input1  : in  STD_LOGIC_VECTOR(4 downto 0);
            Output  : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

begin
    uut: MUX2to1 port map (
        S       => S,
        Input0  => Input0,
        Input1  => Input1,
        Output  => Output
    );

    process
    begin
        --S = 1 Output = Input1
        Input0 <= "11100";  -- 0x1C
        Input1 <= "01010";  -- 0x0A
        S      <= '1';
        wait for 10 ns;

        --S = 0 Output = Input0
        Input0 <= "11100";  -- 0x1C
        Input1 <= "01011";  -- 0x0B
        S      <= '0';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;