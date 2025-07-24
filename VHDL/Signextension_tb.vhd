library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtension_tb is
end entity SignExtension_tb;

architecture Behavioral of SignExtension_tb is
    signal Input16  : STD_LOGIC_VECTOR(15 downto 0);
    signal Output32 : STD_LOGIC_VECTOR(31 downto 0);

    component SignExtension
        port (
            Input16  : in  STD_LOGIC_VECTOR(15 downto 0);
            Output32 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    uut: SignExtension port map (
        Input16  => Input16,
        Output32 => Output32
    );

    process
    begin
        Input16 <= X"FAAA";  
        wait for 10 ns;
        assert Output32 = X"FFFFFAAA" 
            report "Error: Incorrect output for Input16 = 0xFAAA!" severity error;

        Input16 <= X"AFFF";  
        wait for 10 ns;
        assert Output32 = X"FFFFAFFF" 
            report "Error: Incorrect output for Input16 = 0xAFFF!" severity error;
        Input16 <= X"5444";  
        wait for 10 ns;
        assert Output32 = X"00005444" 
            report "Error: Incorrect output for Input16 = 0x5444!" severity error;

        wait;
    end process;
end Behavioral;
