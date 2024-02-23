library ieee;
use ieee.std_logic_1164.all;

Entity adder is
port (
        X, Y    : in  std_logic_vector(3 downto 0);
        Cin     : in  std_logic;
        S       : out std_logic_vector(3 downto 0);
        Cout    : out std_logic;
		  BP, BG  : out std_logic
    );
end adder;

architecture carry_lookahead of adder is

component cla2 is
        port (
        X, Y    : in  std_logic_vector(1 downto 0);
        Cin     : in  std_logic;
        S       : out std_logic_vector(1 downto 0);
        Cout    : out std_logic;
        BP, BG  : out std_logic
    );
    end component cla2;

    component cgen2 is
        port (
        BG, BP    : in  std_logic_vector(1 downto 0);
        Cin       : in  std_logic;
        Co1, Co2  : out std_logic;
        G, P      : out std_logic
    );
    end component cgen2;

Signal BP1, BG1, BP2, BG2, Cout_cla : std_logic;
Signal Sum1, Sum2 : std_logic_vector(1 downto 0);

begin
 U_CLA1 : entity work.CLA2
 PORT MAP (X(0) => X(0), X(1) => X(1), Y(0) => Y(0), Y(1) => Y(1), Cin => Cout_cla, BP => BP1, BG => BG1, S => Sum1
);
 U_CLA2 : entity work.CLA2
 PORT MAP (X(0) => X(2), X(1) => X(3), Y(0) => Y(2), Y(1) => Y(3), Cin => Cin, BP => BP2, BG => BG2, S => Sum2
);
 U_CGEN : entity work.CGEN2
 PORT MAP (BG(0) => BG1, BG(1) => BG2, BP(0) => BP1, BP(1) => BP2, Cin => Cin, Co1 => Cout_cla, Co2 => Cout, G => BG, P => BP
);


S (1 downto 0) <= Sum1;
S (3 downto 2) <= Sum2;

end carry_lookahead;



architecture ripple_carry_adder of adder is

signal carry : std_logic_vector(4 downto 0);
    
begin

    carry(0) <= cin;

    RIPPLE_CARRY : for i in 0 to 3 generate
        U_FA : entity work.full_adder
            port map (
                x    => x(i),
                y    => y(i),
                cin  => carry(i),
                s    => s(i),
                cout => carry(i+1)
                );        
    end generate;

    cout <= carry(4);
    


end ripple_carry_adder;


library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        x, y, cin : in  std_logic;
        s, cout   : out std_logic
        );
end full_adder;

architecture default_arch of full_adder is
begin

    s    <= x xor y xor cin;
    cout <= (x and y) or (cin and (x xor y));
end default_arch;









































library ieee;
use ieee.std_logic_1164.all;


entity cla2 is
    port (
        X, Y    : in  std_logic_vector(1 downto 0);
        Cin     : in  std_logic;
        S       : out std_logic_vector(1 downto 0);
        Cout    : out std_logic;
        BP, BG  : out std_logic
    );
end entity cla2;

architecture Behavioral of cla2 is

   signal G, P, C : std_logic_vector(1 downto 0);

begin
G <= x and y;
P <= x or y;

C(0) <= G(0) or (P(0) and Cin);
C(1) <= G(1) or (P(1) and C(0));

S(0) <= x(0) xor y(0) xor Cin;
S(1) <= x(1) xor y(1) xor C(0);

Cout <= C(1);

BP <= P(1) and P(0);
BG <= (G(0) and P(1)) or G(1);


end architecture Behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity cgen2 is
    port (
        BG, BP    : in  std_logic_vector(1 downto 0);
        Cin       : in  std_logic;
        Co1, Co2  : out std_logic;
        G, P      : out std_logic
    );
end entity cgen2;

architecture Behavioral of cgen2 is

begin

Co1 <= BG(0) or (BP(0) and Cin);
Co2 <= BG(1) or (BP(1) and BG(0)) or (BP(1) and BP(0) and Cin);

P <= BP(1) and BP(0);
G <= (BG(0) and BP(1)) or BG(1);

end architecture Behavioral;
