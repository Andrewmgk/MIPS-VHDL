library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder32_tb is
end entity Adder32_tb;

architecture Behavioral of Adder32_tb is
    signal A, B : STD_LOGIC_VECTOR(31 downto 0);
    signal Sum  : STD_LOGIC_VECTOR(31 downto 0);

    component Adder32
        port (
            A, B : in  STD_LOGIC_VECTOR(31 downto 0);
            Sum  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    uut: Adder32 port map (
        A   => A,
        B   => B,
        Sum => Sum
    );

    process
    begin
        A <= X"CCCCCCCC";  
        B <= X"BBBBBBBB";  
        wait for 10 ns;
		assert Sum = X"88888887" report "Error: The output is incorrect when adding 0xCCCCCCCC and 0xBBBBBBBB!" severity error;

        A <= X"BBBBBBBB";  
        B <= X"55555556";  
        wait for 10 ns;
        assert Sum = X"111111111" report "Error: The output is incorrect when adding 0xBBBBBBBB and 0x55555556!" severity error;
        wait;
    end process;
end Behavioral;