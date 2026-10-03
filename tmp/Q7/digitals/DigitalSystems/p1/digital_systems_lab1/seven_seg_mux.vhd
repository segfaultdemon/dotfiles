---------------------------------------------------------
-- EPSEM - UPC
-- Digital Systems Labs
-- Albert Comerma
-- v0.1 - July 2023
--
-- Lab 3:
-- 7 segments dynamic display multiplexor
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_mux is
    port(
        clk : in std_logic;                             -- System clock
        u : in std_logic_vector(6 downto 0);  -- First display output
        d : in std_logic_vector(6 downto 0); -- Second display output
        c : in std_logic_vector(6 downto 0);  -- Third display output
        m : in std_logic_vector(6 downto 0); -- Fourth display output
        en     : out  std_logic_vector(3 downto 0);  -- Enable of 7 segment display
        seg : out std_logic_vector(6 downto 0);     -- 7 segment output (A to G)
        dp : out std_logic         --Dot control in display
    );
end entity seven_seg_mux;

architecture rtl of seven_seg_mux is
    signal active_display : unsigned (1 downto 0);
begin
    --Run on change of clk 
    process_mux : process(clk) is      
    begin
        if rising_edge(clk) then
            if(active_display < 3) then
                active_display <= active_display + 1;
            else
                active_display <= "00";
            end if;
            en <= (others => '0');
            dp <= '0';
            case to_integer(active_display) is
                when 0 =>
                        seg <= u;
                        en(0) <= '1';
                when 1 =>
                        seg <= d;
                        en(1) <= '1';
                when 2 =>
                        seg <= c;
                        dp <= '1';
                        en(2) <= '1';
                when others =>
                        seg <= m;
                        en(3) <= '1';
            end case;
        end if;
    end process process_mux;        
        
end architecture rtl;
