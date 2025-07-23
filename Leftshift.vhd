library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Leftshift is
    port (
        Input32  : in  STD_LOGIC_VECTOR(31 downto 0); 
        Output32 : out STD_LOGIC_VECTOR(31 downto 0)  -- μετατόπιση αριστερά κατά 2
    );
end entity Leftshift;

architecture Behavioral of Leftshift is
begin
    Output32 <= std_logic_vector(shift_left(unsigned(Input32), 2));
end Behavioral;

