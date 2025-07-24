library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_tb is
end entity ALU_tb;

architecture Behavioral of ALU_tb is
    signal A, B  : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUop : STD_LOGIC_VECTOR(3 downto 0);
    signal Result : STD_LOGIC_VECTOR(31 downto 0);
    signal Zero   : STD_LOGIC;

    component ALU
        port (
            A         : in  STD_LOGIC_VECTOR(31 downto 0);
            B         : in  STD_LOGIC_VECTOR(31 downto 0);
            ALUop: in  STD_LOGIC_VECTOR(3 downto 0);
            Result    : out STD_LOGIC_VECTOR(31 downto 0);
            Zero      : out STD_LOGIC
        );
    end component;

begin
    uut: ALU port map (A => A, B => B, ALUop => ALUop, Result => Result, Zero => Zero);

    process
    begin
        for i in 0 to 3 loop
            case i is
                when 0 => A <= X"00000007"; B <= X"FFFFFFFD"; ALUop <= "0010"; 
				-- 7 + (-3) ADD
                when 1 => A <= X"00000006"; B <= X"FFFFFFFA"; ALUop <= "0010"; 
				-- 6 + (-6) ADD
                when 2 => A <= X"00000005"; B <= X"00000008"; ALUop <= "0110";
				-- 5 - 8	SUB
				when 3 => A <= X"00000000"; B <= X"00000000"; ALUop <= "0010";
            end case;
            wait for 10 ns;
        end loop;
        wait;
    end process;
end Behavioral;

