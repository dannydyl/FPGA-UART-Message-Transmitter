----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2024 11:43:56 PM
-- Design Name: 
-- Module Name: clock_divider_tb - Behavioral
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
use work.all;
entity tb_Clock_Divider is
    -- Testbench has no ports
end tb_Clock_Divider;

architecture Behavioral of tb_Clock_Divider is
    -- Component Declaration
--    component Clock_Divider
--        generic (
--            g_CLKS_PER_BIT : integer := 87  -- Adjust as per your clock and baud rate
--        );
--        port (
--            i_Clk       : in  std_logic;
--            o_Baud_Clk  : out std_logic
--        );
--    end component;

    -- Signals for Testbench
    signal tb_Clk       : std_logic := '0';
    signal tb_Baud_Clk  : std_logic;

    -- Clock period definition
    constant c_CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Clock Divider
    uut : entity Clock_Divider
        generic map (
            g_CLKS_PER_BIT => 87  -- Adjust as needed
        )
        port map (
            i_Clk       => tb_Clk,
            o_Baud_Clk  => tb_Baud_Clk
        );

    -- Clock Generation
    clk_process : process
    begin
        while True loop
            tb_Clk <= '0';
            wait for c_CLK_PERIOD / 2;
            tb_Clk <= '1';
            wait for c_CLK_PERIOD / 2;
        end loop;
    end process;

    -- Test Process
    test_process : process
    begin
        -- Wait for a few clock cycles to observe the behavior
        wait for 1000 * c_CLK_PERIOD;
        
        -- End the simulation
        report "Test complete" severity note;
        wait;
    end process;

end Behavioral;
