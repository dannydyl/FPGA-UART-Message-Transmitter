----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2024 10:39:55 PM
-- Design Name: 
-- Module Name: message_send_tb - Behavioral
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

entity tb_Message_send is
end tb_Message_send;

architecture Behavioral of tb_Message_send is

    -- Signals for Testbench
    signal tb_button      : std_logic := '0';
    signal tb_rst_bar     : std_logic := '1';
    signal tb_clk         : std_logic := '0';
    signal tb_TX_Active   : std_logic;
    signal tb_TX_Serial   : std_logic;
    signal tb_TX_Done     : std_logic;

    -- Clock period definition
    constant c_CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Message_send component
    uut : entity message_send
        port map (
            button      => tb_button,
            rst_bar     => tb_rst_bar,
            clk         => tb_clk,
            o_TX_Active => tb_TX_Active,
            o_TX_Serial => tb_TX_Serial,
            o_TX_Done   => tb_TX_Done
        );
    
    -- Clock Generation
    clk_process : process
    begin
        while True loop
            tb_clk <= '0';
            wait for c_CLK_PERIOD / 2;
            tb_clk <= '1';
            wait for c_CLK_PERIOD / 2;
        end loop;
    end process;

    -- Test Process
    test_process : process
    begin
        -- Initialize
        tb_rst_bar <= '0';
        tb_button <= '0';
        wait for 1ms;
        tb_rst_bar <= '1';
        wait for 1ms;
        
        -- Simulate button press
        tb_button <= '1';
        wait for 20ms;
--        tb_button <= '0';
        
--        -- Wait for message to be sent
--        wait until tb_TX_Done = '1';
        
--        -- Hold simulation for a while to observe
--        wait for 1000 * c_CLK_PERIOD;

        -- Report completion
        report "Test complete" severity note;
        wait;
    end process;

end Behavioral;

