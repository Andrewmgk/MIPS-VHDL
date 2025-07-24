library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX32to1 is
    port (
        S       : in  STD_LOGIC;                      
        Input0  : in  STD_LOGIC_VECTOR(31 downto 0);
        Input1  : in  STD_LOGIC_VECTOR(31 downto 0);
        Output  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity MUX32to1;

architecture Behavioral of MUX32to1 is
begin
    Output <= Input0 when S = '0' else Input1;
end Behavioral;
