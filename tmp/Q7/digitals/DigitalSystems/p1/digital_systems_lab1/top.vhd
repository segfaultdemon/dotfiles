---------------------------------------------------------
--  _   _ ____   ____           _       
-- | | | |  _ \ / ___|  ___  __| |_   _ 
-- | | | | |_) | |     / _ \/ _` | | | |
-- | |_| |  __/| |___ |  __/ (_| | |_| |
--  \___/|_|    \____(_)___|\__,_|\__,_| 
-- EPSEM - UPC
-- Digital Systems Labs
-- Albert Comerma
-- v0.1 - July 2023 initial version for Basys3
-- v0.2 - Sept 2025 modifications for tang trainer
--
-- Demo code to test board features:
-- Top entity
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sd.all;

entity top is
    port(
        clk : in  std_logic;                    -- Main clock 
        rst : in std_logic;                     -- Main reset
        seg : out std_logic_vector(0 to 6);     -- 7 segment multiplexed outputs 
        en : out std_logic_vector(3 downto 0);  -- Anode control of 7 segment displays
        dp : out std_logic;                     -- Anode dot of 7 segment displays
        led : out std_logic_vector(7 downto 0); -- Debug leds 
        sw : in std_logic_vector(1 downto 0);   -- Slider switches
        R,G,B : out std_logic                   -- RGB led outputs
    );
end entity top;

architecture rtl of top is

    signal clk_01k : std_logic;
    signal clk_1k : std_logic;
    signal enable, updown : std_logic;
    signal count_int : std_logic_vector(5 downto 0);
    signal u, d, c, m : std_logic_vector(3 downto 0);
    signal u7, d7, c7, m7 : std_logic_vector(6 downto 0);

begin
    R <= '0'; --Disable R led
    G <= '0'; --Disable G led
    B <= '0'; --Disable B led
    enable <= sw(0);
    updown <= sw(1);
    led(7) <= sw(0); --Green led on the side of slider sw
    led(6) <= sw(1); --Green led on the side of slider sw
    led(5 downto 0) <= not count_int; --Leds onboard are inverted
    --Instantiate different elements
    div1: entity work.clk_div generic map (13_499_9) port map(clk, rst, clk_01k);
    div2: entity work.clk_div generic map (13_499) port map(clk, rst, clk_1k);
    c1: entity work.counter port map(clk_01k, rst, enable, updown, count_int, u, d, c, m);
    bcd2seg1: entity work.bcd27seg port map(u, u7);
    bcd2seg2: entity work.bcd27seg port map(d, d7);
    bcd2seg3: entity work.bcd27seg port map(c, c7);
    bcd2seg4: entity work.bcd27seg port map(m, m7);
    disp1: entity work.seven_seg_mux port map(clk_1k, u7, d7, c7, m7, en, seg, dp);

end architecture rtl;
