library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    port(
        in0, in1, sel : in  std_logic;
        output        : out std_logic);
end mux2x1;

architecture default_arch of mux2x1 is
begin
    output <= in0 when sel = '0' else in1;
end default_arch;

library ieee;
use ieee.std_logic_1164.all;

entity mux4_to_1 is
    port(
        inputs : in  std_logic_vector(3 downto 0);
        sel    : in  std_logic_vector(1 downto 0);
        output : out std_logic
        );
end mux4_to_1;

architecture STR1 of mux4_to_1 is

    signal mux1_out, mux2_out : std_logic;

begin
    
    U_MUX1 : entity work.mux2x1 port map (
        in0    => inputs(2),
        in1    => inputs(3),
        sel    => sel(0),
        output => mux1_out
        );

    U_MUX2 : entity work.mux2x1 port map (
        in0    => inputs(0),
        in1    => inputs(1),
        sel    => sel(0),
        output => mux2_out
        );

    U_MUX3 : entity work.mux2x1 port map (
        in0    => mux2_out,
        in1    => mux1_out,
        sel    => sel(1),
        output => output
        );

end STR1;

architecture default_arch of mux4_to_1 is
begin
    U_MUX : entity work.mux4_to_1(STR1)
        port map (
            inputs => inputs,
            sel    => sel,
            output => output);
end default_arch;