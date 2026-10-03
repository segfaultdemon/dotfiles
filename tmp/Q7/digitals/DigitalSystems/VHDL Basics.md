## Parts of the code
### Header
```
library ieee;
use ieee_std_logic_1164.ALL;
```
### Entity
```
entity black_box is
	port(
		a, b, c: in std_logic;
		d: out std_logic;
		);
end entity;
```
### Architecture
```
architecture rtl of black_box is
	signal f, g: std_logic; -- internal variables
begin
	f = ...
	g = ...
	d = ...
end architecture;
```

*lab is making a 7 segment display (counter, for 4 different 7 segment displays in parallel, activating one at a time rapidly enough for the eye not to notice it).