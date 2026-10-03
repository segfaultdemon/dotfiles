-- header
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is 
  port(
        a,b,c,d: in std_logic;
        f: out std_logic
      );
end entity;

architecture beh of top is
  signal o1,o2: std_logic;
begin
  o1 <= a and (not b);
  o2 <= (not c) and (not d);
  f  <= not (o1 or o2);
end architecture;
