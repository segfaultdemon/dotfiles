
-- header
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity black_box is -- entity -> describes the connections needed by our design
  port(
        a,b,s: in std_logic; -- a,b,s are the inputs
        z: out std_logic -- z is the output
      );
end entity;

architecture rtl of black_box is -- describes the behaviour of the design
  signal d,e: std_logic;  -- d,e are internal, they can only be described between the "architecture" and "begin"
begin
  d <= a and s;
  e <= (not s) and b;
  z <= d or e;
end architecture;
