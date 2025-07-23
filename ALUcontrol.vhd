library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUControl is
    port (
        Funct      : in  STD_LOGIC_VECTOR(5 downto 0);
        ALUop      : in  STD_LOGIC_VECTOR(1 downto 0);
        ALUControl : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity ALUControl;

architecture Behavioral of ALUControl is
begin
    process (Funct, ALUop)
    begin
        case ALUop is
            when "10" =>  -- R-type
                case Funct is
                    when "100000" => ALUControl <= "0010"; -- ADD
                    when "100010" => ALUControl <= "0110"; -- SUB
                    when "100100" => ALUControl <= "0000"; -- AND
                    when "100101" => ALUControl <= "0001"; -- OR
                    when "101010" => ALUControl <= "0111"; -- SLT
                    when others   => ALUControl <= "1111"; -- Unknown command
                end case;
            when "00" => ALUControl <= "0010"; -- LW, SW ADD
            when "01" => ALUControl <= "0110"; -- BEQ SUB
            when others => ALUControl <= "1111"; -- Unknown ALUop
        end case;
    end process;
end Behavioral;