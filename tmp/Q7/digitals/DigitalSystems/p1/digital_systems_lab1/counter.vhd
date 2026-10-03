---------------------------------------------------------
-- EPSEM - UPC
-- Digital Systems Labs
-- Albert Comerma
-- v0.2 - July 2024
--
-- Lab 1:
-- A simple counter from 0 to 9999
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port(
        clk     : in  std_logic;                    -- Main clock of the counter
        n_reset : in  std_logic;                    -- Reset signal, active low
        enable  : in  std_logic;                    -- Enable counting
        updown  : in  std_logic;                    -- Up or down counting
        leds    : out std_logic_vector(5 downto 0);  -- Output to leds
        u, d, c, m : out std_logic_vector(3 downto 0) -- Outputs to seven segment values
    );
end entity counter;

architecture rtl of counter is
    signal count_u : unsigned(3 downto 0);
    signal count_d : unsigned(3 downto 0);
    signal count_c : unsigned(3 downto 0);
    signal count_m : unsigned(3 downto 0);
    signal count_leds : unsigned(5 downto 0);
begin
    -- Run on change of clk or n_reset
    process_counter : process(clk, n_reset) is      
    begin
        -- Asynchronous reset
        if n_reset = '0' then                       
            count_leds <= (others => '0');
            count_u <= (others => '0');
            count_d <= (others => '0');
            count_c <= (others => '0');
            count_m <= (others => '0');
        -- If not reset on each rising edge of clk signal
        elsif rising_edge(clk) then
            if (enable = '1') then
                if (updown = '1') then
                    -- Count up (0 to 9 per digit)
                    if count_u = 9 then
                        count_u <= (others => '0');
                        if count_d = 9 then
                            count_d <= (others => '0');
                            if count_c = 9 then
                                count_c <= (others => '0');
                                if count_m = 9 then
                                    count_m <= (others => '0');
                                else
                                    count_m <= count_m + 1;
                                end if;
                            else
                                count_c <= count_c + 1;
                            end if;
                        else
                            count_d <= count_d + 1;
                        end if;
                    else
                        count_u <= count_u + 1;
                    end if;
                else
                    -- Count down (9 to 0 per digit)
                    if count_u = 0 then
                        count_u <= to_unsigned(9, 4);
                        if count_d = 0 then
                            count_d <= to_unsigned(9, 4);
                            if count_c = 0 then
                                count_c <= to_unsigned(9, 4);
                                if count_m = 0 then
                                    count_m <= to_unsigned(9, 4);
                                else
                                    count_m <= count_m - 1;
                                end if;
                            else
                                count_c <= count_c - 1;
                            end if;
                        else
                            count_d <= count_d - 1;
                        end if;
                    else
                        count_u <= count_u - 1;
                    end if;
                end if;
                count_leds <= count_leds + 1;
            end if;
        end if;
    end process process_counter;

    -- Conversion to std_logic_vector for output
    leds <= std_logic_vector(count_leds);            
    u <= std_logic_vector(count_u);
    d <= std_logic_vector(count_d);
    c <= std_logic_vector(count_c);
    m <= std_logic_vector(count_m); 
end architecture rtl;
