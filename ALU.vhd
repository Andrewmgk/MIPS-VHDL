library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    port (
        A         : in  STD_LOGIC_VECTOR(31 downto 0);
        B         : in  STD_LOGIC_VECTOR(31 downto 0);
        ALUop	  : in  STD_LOGIC_VECTOR(3 downto 0);
        Result    : out STD_LOGIC_VECTOR(31 downto 0);
        Zero      : out STD_LOGIC                      
    );
end entity ALU;

architecture Behavioral of ALU is
    signal temp_result : STD_LOGIC_VECTOR(31 downto 0);
begin
    process(A, B, ALUop)
    begin
        case ALUop is
            when "0000" =>  -- AND
                temp_result <= A and B;
            
            when "0001" =>  -- OR
                temp_result <= A or B;
            
            when "0010" =>  -- ADD
                temp_result <= A + B;
            
            when "0110" =>  -- SUB
                temp_result <= A - B;
            
            when "0111" =>  -- SLT
                if A < B then
                    temp_result <= (others => '0');
                    temp_result(0) <= '1';
                else
                    temp_result <= (others => '0');
                end if;
            
            when others =>
                temp_result <= (others => '0');  
        end case;

        Result <= temp_result;

        if temp_result = X"00000000" then  --Check if zero
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end Behavioral;