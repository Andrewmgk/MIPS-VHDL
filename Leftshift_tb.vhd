library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Leftshift_tb is
end entity Leftshift_tb;

architecture Behavioral of Leftshift_tb is
    signal Input32  : STD_LOGIC_VECTOR(31 downto 0);
    signal Output32 : STD_LOGIC_VECTOR(31 downto 0);

    component Leftshift
        port (
            Input32  : in  STD_LOGIC_VECTOR(31 downto 0);
            Output32 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
begin
    uut: Leftshift port map (
        Input32  => Input32,
        Output32 => Output32
    );
	
    process
    begin
        Input32 <= X"0FFFFFFF";
		assert Output32 = X"3FFFFFFC" report "Error: The output is incorrect!" severity error;
        wait for 10 ns;
        wait;
    end process;
end Behavioral;