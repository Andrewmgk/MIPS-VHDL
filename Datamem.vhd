library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datamem is
    port (
        Address   : in  STD_LOGIC_VECTOR(31 downto 0);  
        WriteData : in  STD_LOGIC_VECTOR(31 downto 0); 
        MemWrite  : in  STD_LOGIC;                     
        MemRead   : in  STD_LOGIC;                   
        Clock     : in  STD_LOGIC;                     
        ReadData  : out STD_LOGIC_VECTOR(31 downto 0)  
    );
end entity Datamem;

architecture Behavioral of Datamem is
    type mem_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal memory : mem_array := (others => (others => '0'));

begin
    -- Read only when MemRead = '1'
    process (Clock)
    begin
        if rising_edge(Clock) then
            if MemRead = '1' then
                ReadData <= memory(to_integer(unsigned(Address)));
            end if;
            if MemWrite = '1' then
                memory(to_integer(unsigned(Address))) <= WriteData;
            end if;
        end if;
    end process;
end Behavioral;
