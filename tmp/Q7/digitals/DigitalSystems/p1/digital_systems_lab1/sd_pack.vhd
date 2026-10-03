--------------------------------------------------------------
--  _   _ ____   ____           _       
-- | | | |  _ \ / ___|  ___  __| |_   _ 
-- | | | | |_) | |     / _ \/ _` | | | |
-- | |_| |  __/| |___ |  __/ (_| | |_| |
--  \___/|_|    \____(_)___|\__,_|\__,_| 
-- EPSEM - UPC
-- Digital Systems Labs
-- Albert Comerma
-- v0.1 - 2025 added package for some functions
-- Ascii art created with: https://patorjk.com/software/taag/
-- Big font for Digital Systems and Standard for lab 
--------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package sd is
        --Array of animations, only g to a segments, not dp
    --Used to represent some lines on the 7segment display
    --Circular moving around the display
    type animation is array(1 to 48) of std_logic_vector(6 downto 0);
    constant animate1 : animation := (
    "0001000", "0000000", "0000000", "0000000", --    _
    "0001000", "0001000", "0000000", "0000000", --   __
    "0001000", "0001000", "0001000", "0000000", --  ___
    "0001000", "0001000", "0001000", "0001000", -- ____
    "0001000", "0001000", "0001000", "0011000", --|____    
    "0001000", "0001000", "0001000", "0111000",   
    "0001000", "0001000", "0001000", "0111001",
    "0001000", "0001000", "0001001", "0111001",
    "0001000", "0001001", "0001001", "0111001",
    "0001001", "0001001", "0001001", "0111001",
    "0001011", "0001001", "0001001", "0111001", 
    "0001111", "0001001", "0001001", "0111001"
    );

    type animation_short is array(1 to 16) of std_logic_vector(6 downto 0);
    constant animate2 : animation_short := (
    "0111111", "0000110", "1011011", "1001111",
    "1100110", "1101101", "1111101", "0000111",
    "1111111", "1101111", "1110111", "1111100",
    "1011000", "1011110", "1111001", "1110001"
    );

    procedure print_header(
        lab : in integer
    );
    procedure print_message(
        message : in string
    );
    procedure wait_until_after_next_rising_clock_edge(signal clock: in std_logic; period: in time);
end package sd;

package body sd is

    procedure print_message(
        message : in string
    ) is
        
    begin
        report "-----------------------------------------------------------------------";
        report message;
        report "-----------------------------------------------------------------------";
    end;

    -- wait until a little (1/10th of a clock period) after the next rising clock edge
    procedure wait_until_after_next_rising_clock_edge(signal clock: in std_logic; period: in time) is
    begin
        wait until rising_edge(clock);
        wait for period / 10;  
    end procedure wait_until_after_next_rising_clock_edge;


    procedure print_header(
        lab : in integer
    ) is
    begin
            report "                             *************                   ";
            report "                        ***********************              ";
            report "                     *****************************           ";
            report "                   *********************************         ";
            report "                 *******     ****     ****     *******       ";
            report "               ********       **       **       ********     ";
            report "              *********       **       **       *********    ";
            report "             ***********     ****     ****     ***********   ";
            report "            ***********************************************  ";
            report "           *************     ****     ****     ************* ";
            report "           ************       **       **       ************ ";
            report "          *************       **       **       *************";
            report "          ***************   ******   ******   ***************";
            report "          ***************************************************";
            report "          **************     ****     ****     **************";
            report "          *************       **       **       *************";
            report "          **************      **       **      **************";
            report "           ***************  ******* *******  *************** ";
            report "           ************************************************* ";
            report "            ************  ***  **     *****    ************  ";
            report "             ***********  ***  **  **  **   **************   ";
            report "              **********  ***  **      **  **************    ";
            report "               *********  **   **  ******   ************     ";
            report "                 ********     ***  *******     *******       ";
            report "                   *********************************         ";
            report "                     *****************************           ";
            report "                        ***********************              ";
            report "                             *************                   ";
            report "  _____  _       _ _        _    _____           _                     ";
            report " |  __ \(_)     (_) |      | |  / ____|         | |                    ";
            report " | |  | |_  __ _ _| |_ __ _| | | (___  _   _ ___| |_ ___ _ __ ___  ___ ";
            report " | |  | | |/ _` | | __/ _` | |  \___ \| | | / __| __/ _ \ '_ ` _ \/ __|";
            report " | |__| | | (_| | | || (_| | |  ____) | |_| \__ \ ||  __/ | | | | \__ \";
            report " |_____/|_|\__, |_|\__\__,_|_| |_____/ \__, |___/\__\___|_| |_| |_|___/";
            report "            __/ |                       __/ |                          ";
            report "           |___/                       |___/                           ";
        
            case lab is
                when 0 =>
                    report "                                            _                      ";
                    report "                                         __| | ___ _ __ ___   ___  ";
                    report "     Albert Comerma                     / _` |/ _ \ '_ ` _ \ / _ \ ";
                    report " (albert.comerma@upc.edu)              | (_| |  __/ | | | | | (_) |";
                    report "          2025                          \__,_|\___|_| |_| |_|\___/ ";
                when 1 =>
                    report "                                              _          _       _ ";
                    report "                                             | |    __ _| |__   / |";
                    report "                                             | |   / _` | '_ \  | |";
                    report "                                             | |__| (_| | |_) | | |";
                    report "                                             |_____\__,_|_.__/  |_|";
                when 2 =>
                    report "                                              _          _       ____  ";
                    report "                                             | |    __ _| |__   |___ \ ";
                    report "                                             | |   / _` | '_ \    __) |";
                    report "                                             | |__| (_| | |_) |  / __/ ";
                    report "                                             |_____\__,_|_.__/  |_____|";
                when 3 =>
                    report "                                               _          _       _____ ";
                    report "                                              | |    __ _| |__   |___ / ";
                    report "                                             | |   / _` | '_ \    |_ \ ";
                    report "                                             | |__| (_| | |_) |  ___) |";
                    report "                                             |_____\__,_|_.__/  |____/ ";
                when 4 =>
                    report "                                              _          _       _  _   ";
                    report "                                             | |    __ _| |__   | || |  ";
                    report "                                             | |   / _` | '_ \  | || |_ ";
                    report "                                             | |__| (_| | |_) | |__   _|";
                    report "                                             |_____\__,_|_.__/     |_|  ";               
                when 5 =>
                    report "                                              _          _       ____  ";
                    report "                                             | |    __ _| |__   | ___| ";
                    report "                                             | |   / _` | '_ \  |___ \ ";
                    report "                                             | |__| (_| | |_) |  ___) |";
                    report "                                             |_____\__,_|_.__/  |____/ ";
                when others =>
            end case;
    end;

end package body sd;
