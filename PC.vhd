library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    port (
        Clock   : in  STD_LOGIC;                     
        Reset   : in  STD_LOGIC;                     
        PC_in   : in  STD_LOGIC_VECTOR(31 downto 0); -- Νέα διεύθυνση
        PC_out  : out STD_LOGIC_VECTOR(31 downto 0)  -- Τρέχουσα διεύθυνση
    );
end entity PC;

architecture Behavioral of PC is
    signal PC_reg : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');  

begin
    process (Clock, Reset)
    begin
        if Reset = '1' then
            PC_reg <= (others => '0');
        elsif rising_edge(Clock) then
            PC_reg <= std_logic_vector(unsigned(PC_reg) + 1); 
			-- Αύξηση κατά 1 αντί για 4
        end if;
    end process;

    PC_out <= PC_reg;
end Behavioral;