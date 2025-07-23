library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtension is
    port (
        Input16  : in  STD_LOGIC_VECTOR(15 downto 0); 
        Output32 : out STD_LOGIC_VECTOR(31 downto 0)  
    );
end entity SignExtension;

architecture Behavioral of SignExtension is
begin
    Output32 <= "0000000000000000" & Input16 when Input16(15)='0' else
	"1111111111111111" & Input16 when Input16(15)='1';
end Behavioral;