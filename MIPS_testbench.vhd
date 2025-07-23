library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPS_tb is
end entity MIPS_tb;

architecture Behavioral of MIPS_tb is
	component MIPS
		port (
			Clock : in  STD_LOGIC;
			Reset : in  STD_LOGIC
		);
	end component;
	
    signal Clock   : STD_LOGIC := '0';
    signal Reset   : STD_LOGIC := '1';

begin
    uut: MIPS port map (
        Clock => Clock,
        Reset => Reset
    );

    process
	begin
		Reset <= '1';  
		wait for 4 ns;  
		Reset <= '0'; 
		wait;
	end process;

    process
    begin
        while true loop
            Clock <= '1';
            wait for 5 ns; 
            Clock <= '0';
            wait for 5 ns;
        end loop;
    end process;
end Behavioral;
