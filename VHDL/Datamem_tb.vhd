library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datamem_tb is
end entity Datamem_tb;

architecture Behavioral of Datamem_tb is
    signal Address   : STD_LOGIC_VECTOR(31 downto 0);
    signal WriteData : STD_LOGIC_VECTOR(31 downto 0);
    signal MemWrite  : STD_LOGIC;
    signal MemRead   : STD_LOGIC;
    signal Clock     : STD_LOGIC := '0';
    signal ReadData  : STD_LOGIC_VECTOR(31 downto 0);

    component Datamem
        port (
            Address   : in  STD_LOGIC_VECTOR(31 downto 0);
            WriteData : in  STD_LOGIC_VECTOR(31 downto 0);
            MemWrite  : in  STD_LOGIC;
            MemRead   : in  STD_LOGIC;
            Clock     : in  STD_LOGIC;
            ReadData  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    uut: Datamem port map (
        Address   => Address,
        WriteData => WriteData,
        MemWrite  => MemWrite,
        MemRead   => MemRead,
        Clock     => Clock,
        ReadData  => ReadData
    );

    stimulus: process
    begin
        -- Write 9 in memory 2
        Address   <= x"00000008";
        WriteData <= x"00000009";  
        MemWrite  <= '1';       
        MemRead   <= '0';       
        Clock     <= '1';       
        wait for 10 ns;
        Clock     <= '0';
        wait for 10 ns;

        -- Write 4 in memory 3
        Address   <= x"0000000C"; 
        WriteData <= x"00000004";
        MemWrite  <= '1';
        MemRead   <= '0';
        Clock     <= '1';
        wait for 10 ns;
        Clock     <= '0';
        wait for 10 ns;

        -- Read memory 2
        Address   <= x"00000008";  
        MemWrite  <= '0';  
        MemRead   <= '1';  
        Clock     <= '1';  
        wait for 10 ns;
        Clock     <= '0';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;