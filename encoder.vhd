library ieee;
use ieee.std_logic_1164.all;
entity encoder is
Port (a: in std_logic_vector(7 downto 0);
		b: out std_logic_vector(2 downto 0));
end encoder;

architecture bhv of encoder is
begin
	process (a)
		begin
		if (a = "10000000") then
			b <= "000";
		elsif (a = "01000000") then
			b <= "001";
		elsif (a = "00100000") then
			b <= "010";
		elsif (a = "00010000") then
			b <= "011";
		elsif (a = "00001000") then
			b <= "100";
		elsif (a = "00000100") then
			b <= "101";
		elsif (a = "00000010") then
			b <= "110";
		elsif (a = "00000001") then
			b <= "111";
		end if;
	end process;
end bhv;