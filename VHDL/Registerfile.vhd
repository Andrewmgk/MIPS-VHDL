library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity RegisterFile is
    port (
        ReadReg1  : in  STD_LOGIC_VECTOR(4 downto 0);  -- Διεύθυνση του πρώτου καταχωρητή προς ανάγνωση
        ReadReg2  : in  STD_LOGIC_VECTOR(4 downto 0);  -- Διεύθυνση του δεύτερου καταχωρητή προς ανάγνωση
        WriteReg  : in  STD_LOGIC_VECTOR(4 downto 0);  -- Διεύθυνση του καταχωρητή προς εγγραφή
        WriteData : in  STD_LOGIC_VECTOR(31 downto 0); -- Δεδομένα προς εγγραφή
        RegWrite  : in  STD_LOGIC;                     -- Σήμα ελέγχου εγγραφής
        Clock     : in  STD_LOGIC;                    
        ReadData1 : out STD_LOGIC_VECTOR(31 downto 0); -- Έξοδος πρώτου καταχωρητή
        ReadData2 : out STD_LOGIC_VECTOR(31 downto 0)  -- Έξοδος δεύτερου καταχωρητή
    );
end entity RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));  -- Αρχικοποίηση με μηδενικά

begin
    ReadData1 <= registers(to_integer(unsigned(ReadReg1)));
    ReadData2 <= registers(to_integer(unsigned(ReadReg2)));

    process (Clock)
    begin
        if rising_edge(Clock) then 
            if RegWrite = '1' then
                registers(to_integer(signed(WriteReg))) <= WriteData;
            end if;
        end if;
    end process;
end Behavioral;