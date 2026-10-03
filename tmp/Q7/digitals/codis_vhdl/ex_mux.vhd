
-- 2 bit MUX

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity MUX_2B_SEL is
  port(
  a,b,c : in std_logic;
  s : in std_logic_vector(1 downto 0);
  z : out std_logic
      );
end;

architecture mux of MUX_2b_SEL is
begin
  process(a,b,c,s)
  begin
    case s is
      when "00" => z <= a;
      when "11" => z <= c;
      when others => z <= b;
    end case;
  end process;
end mux;
