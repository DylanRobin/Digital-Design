library ieee;
use ieee.std_logic_1164.all;

entity register1 is
    generic (
        N       : positive := 8
    );
    port (
        input   : in  std_logic_vector(N - 1 downto 0);
        load    : in  std_logic;
        clk     : in  std_logic;
        output  : out std_logic_vector(N - 1 downto 0)
    );
end entity register1;

architecture Behavioral of register1 is
    signal reg : std_logic_vector(N - 1 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if load = '1' then
                reg <= input;
            end if;
        end if;
    end process;
    
    output <= reg;
end architecture Behavioral;