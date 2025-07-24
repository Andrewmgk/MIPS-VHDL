library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl_tb is
end entity;

architecture Behavioral of ALUControl_tb is
    signal Funct         : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUop         : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUControl_out : STD_LOGIC_VECTOR(3 downto 0);

    component ALUControl
        port (
            Funct      : in  STD_LOGIC_VECTOR(5 downto 0);
            ALUop      : in  STD_LOGIC_VECTOR(1 downto 0);
            ALUControl : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin

    uut: ALUControl port map (
        Funct      => Funct,
        ALUop      => ALUop,
        ALUControl => ALUControl_out
    );

    process
    begin
        Funct <= "100000"; --100000 – 10 (ADD)
        ALUop <= "10";
        wait for 10 ns;
		assert ALUControl_out = "0010"
        report "Test ADD (R-type): ALUControl = " severity error;

        Funct <= "100010";--100010 – 10 (SUB)
        ALUop <= "10";
        wait for 10 ns;
		assert ALUControl_out = "0110"
        report "Test SUB (R-type): ALUControl = " severity error;

        Funct <= "111111";--111111 – 00 (ADD)
        ALUop <= "00";
        wait for 10 ns;
		assert ALUControl_out = "0010"
        report "Test default ADD (I-type): ALUControl = " severity error;


        Funct <= "111111";--111111 – 01 (SUB for BEQ)
        ALUop <= "01";
        wait for 10 ns;
		assert ALUControl_out = "0010"
        report "Test BEQ SUB (I-type): ALUControl = " severity error;

        wait;
    end process;

end architecture;
