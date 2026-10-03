---------------------------------------------------------
-- EPSEM - UPC
-- Digital Systems Labs
-- Albert Comerma
-- v0.1 - July 2023
--
-- Lab 1:
-- A simple clock divider
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_div is
    generic(divider : integer := 49);
    port(
        clk     : in  std_logic;    -- Main clock
        n_reset : in  std_logic;    -- Reset signal, active low
        clk_out : out std_logic  -- Divided clock, 1 second output
    );
end entity clk_div;

architecture rtl of clk_div is
    signal counter : integer;  -- Divide by divider
    signal clk_divided : std_logic;
begin
    --Run on change of clk or n_reset
    process_count : process(clk, n_reset) is      
    begin
        --Asynchronous reset
        if n_reset = '0' then                       
            counter <= 0;
            clk_divided <= '0';
        --If not reset on each rising edge of clk signal
        elsif rising_edge(clk) then
            if(counter >= divider) then
                counter <= 0;
                clk_divided <= not clk_divided;     -- Change output every divider rising edges
            else
                counter <= counter + 1;
            end if;
        end if;
    end process process_count;
    clk_out <= clk_divided;           
end architecture rtl;