---------------------------------------------------------
--  _   _ ____   ____           _       
-- | | | |  _ \ / ___|  ___  __| |_   _ 
-- | | | | |_) | |     / _ \/ _` | | | |
-- | |_| |  __/| |___ |  __/ (_| | |_| |
--  \___/|_|    \____(_)___|\__,_|\__,_| 
-- EPSEM - UPC
-- Digital Systems Labs
-- Albert Comerma
-- v0.1 - July 2023
-- v0.2 - 2025 Modified to use standard vhdl for yosys flow
--
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sd.all;
use std.env.finish;
-- A testbench for the counter
entity tb is
end entity tb;

architecture rtl of tb is
    signal clk            : std_logic;
    signal n_reset        : std_logic;
    signal enable         : std_logic;
    signal updown         : std_logic;
    signal value_u          : std_logic_vector(3 downto 0);
    signal value_d          : std_logic_vector(3 downto 0);
    signal value_c          : std_logic_vector(3 downto 0);
    signal value_m          : std_logic_vector(3 downto 0);
    constant clock_period : time := 10 ns;
    -- wait until a little (1/10th of a clock period) after the next rising clock edge
    procedure wait_until_after_next_rising_clock_edge(signal clock: in std_logic; period: in time) is
    begin
        wait until rising_edge(clock);
        wait for period / 10;  
    end procedure wait_until_after_next_rising_clock_edge;

    begin
    -- instead of using a component we use the compiled entity from work library
    counter_inst : entity work.counter
        port map(
            clk   => clk,
            n_reset => n_reset,
            enable => enable,
            updown => updown,
            u => value_u,
            d => value_d,
            c => value_c,
            m => value_m
        );
    --process to generate main clock
    process_clk : process is
    begin
        if clk = '0' then
            clk <= '1';
        else
            clk <= '0';
        end if;
        wait for clock_period / 2;
    end process process_clk;
    --process to generate reset and enable signals
    process_reset : process is
    begin
        n_reset <= '1';
        enable <= '0';
        updown <= '0';
        wait for clock_period * 1.5;
        n_reset <= '0';
        wait for clock_period * 1.5;
        n_reset <= '1';
        wait for clock_period * 1.5;
        enable <= '1';
        wait;
    end process process_reset;
    --different tests
    test: process is
        begin
            print_header(1); 
            print_message("Starting testbench");
            --Check that reset is working...
            wait for 3*clock_period;
            assert to_integer(unsigned(value_u)) = 0 report "RESET TEST> ERROR value_u is not 0!!" severity failure;
            assert to_integer(unsigned(value_d)) = 0 report "RESET TEST> ERROR value does not match!!" severity failure;
            assert to_integer(unsigned(value_c)) = 0 report "RESET TEST> ERROR value does not match!!" severity failure;
            assert to_integer(unsigned(value_m)) = 0 report "RESET TEST> ERROR value does not match!!" severity failure;
            report "RESET TEST> OK";
            report "---------------------------------";
            --Check enable is working and counting
            wait for 2*clock_period;
            for test_count in 1 to 9 loop
                assert to_integer(unsigned(value_u)) = test_count report "ENABLE TEST> ERROR value does not match!!" severity failure;
                wait_until_after_next_rising_clock_edge(clk, clock_period);
            end loop;
            report "ENABLE TEST> OK";
            report "---------------------------------";
            --Check the counter goes back to 0 when finishes
            for test_count in 10 to 10000 loop
                if test_count = 10000 then
                    assert to_integer(unsigned(value_u)) = 0 report "OVERFLOW TEST> ERROR value_u is not 0!!" severity failure;
                    assert to_integer(unsigned(value_d)) = 0 report "OVERFLOW TEST> ERROR value does not match!!" severity failure;
                    assert to_integer(unsigned(value_c)) = 0 report "OVERFLOW TEST> ERROR value does not match!!" severity failure;
                    assert to_integer(unsigned(value_m)) = 0 report "OVERFLOW TEST> ERROR value does not match!!" severity failure;        
                end if;
                wait_until_after_next_rising_clock_edge(clk, clock_period);
            end loop;
            report "OVERFLOW TEST> OK";
            report "---------------------------------";
            --Finish all tests
            wait for 3*clock_period;
            print_message("Testbench finished, all OK");
            finish;
    end process test;

end architecture rtl;
