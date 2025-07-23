library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder32 is
    port (
        A, B : in  STD_LOGIC_VECTOR(31 downto 0); 
        Sum  : out STD_LOGIC_VECTOR(31 downto 0)  
    );
end entity Adder32;

architecture Behavioral of Adder32 is
begin
    Sum <= std_logic_vector(unsigned(A) + unsigned(B));
end Behavioral;