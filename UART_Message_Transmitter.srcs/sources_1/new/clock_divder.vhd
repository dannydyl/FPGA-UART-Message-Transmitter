----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2024 11:42:59 PM
-- Design Name: 
-- Module Name: clock_divder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Clock_Divider is
    generic (
        g_CLKS_PER_BIT : integer := 87  -- Adjust as per your clock and baud rate
    );
    port (
        i_Clk       : in  std_logic;
        o_Baud_Clk  : out std_logic
    );
end Clock_Divider;

architecture Behavioral of Clock_Divider is
    signal r_Count : integer range 0 to g_CLKS_PER_BIT-1 := 0;
    signal r_Baud_Clk : std_logic := '0';
begin
    process(i_Clk)
    begin
        if rising_edge(i_Clk) then
            if r_Count = g_CLKS_PER_BIT - 1 then
                r_Count <= 0;
                r_Baud_Clk <= not r_Baud_Clk;
            else
                r_Count <= r_Count + 1;
            end if;
        end if;
    end process;

    o_Baud_Clk <= r_Baud_Clk;
end Behavioral;

