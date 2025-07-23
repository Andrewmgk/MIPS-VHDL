library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_tb is
end entity RegisterFile_tb;

architecture Behavioral of RegisterFile_tb is
    signal ReadReg1, ReadReg2, WriteReg : STD_LOGIC_VECTOR(4 downto 0);
    signal WriteData, ReadData1, ReadData2 : STD_LOGIC_VECTOR(31 downto 0);
    signal RegWrite, Clock : STD_LOGIC;

    component RegisterFile
        port (
            ReadReg1  : in  STD_LOGIC_VECTOR(4 downto 0);
            ReadReg2  : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteReg  : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteData : in  STD_LOGIC_VECTOR(31 downto 0);
            RegWrite  : in  STD_LOGIC;
            Clock     : in  STD_LOGIC;
            ReadData1 : out STD_LOGIC_VECTOR(31 downto 0);
            ReadData2 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    uut: RegisterFile port map (
        ReadReg1  => ReadReg1,
        ReadReg2  => ReadReg2,
        WriteReg  => WriteReg,
        WriteData => WriteData,
        RegWrite  => RegWrite,
        Clock     => Clock,
        ReadData1 => ReadData1,
        ReadData2 => ReadData2
    );

    process
    begin
        Clock <= '0';
        wait for 5 ns;

        WriteReg  <= "00100"; -- $t4
        WriteData <= X"00000006"; -- 6
        RegWrite  <= '1';
        Clock <= '1';  
        wait for 5 ns;
        Clock <= '0';
        wait for 5 ns;

        WriteReg  <= "00101"; -- $t5
        WriteData <= X"00000009"; -- 9
        Clock <= '1';  
        wait for 5 ns;
        Clock <= '0';
        wait for 5 ns;

        WriteReg  <= "00110"; -- $t6 
        WriteData <= X"00000003"; -- 3  
        Clock <= '1';  
        wait for 5 ns;
        Clock <= '0';
        wait for 5 ns;

        RegWrite  <= '0';  -- Απενεργοποίηση εγγραφής
        ReadReg1  <= "00100"; -- $t4 
        ReadReg2  <= "00101"; -- $t5 
        wait for 10 ns;

        wait;
    end process;
end Behavioral;