--------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2024 10:51:48 PM
-- Design Name: 
-- Module Name: Massage_send - Behavioral
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
use work.all;
use ieee.numeric_std.all;

entity Message_send is
    port(
        button : in std_logic;
        rst_bar : in std_logic;
        clk : in std_logic;
        o_TX_Active : out std_logic;
        o_TX_Serial : out std_logic;
        o_TX_Done : out std_logic
        );
end Message_send;

architecture Behavioral of Message_send is
signal button_clear : std_logic;
signal i_TX_Byte : std_logic_vector(7 downto 0) := (others => '0');
signal i_TX_DV      : std_logic := '0';
--signal r_TX_Data   : std_logic_vector(7 downto 0) := "01000001"; -- ASCII for 'A'
signal divided_clk : std_logic;
signal r_Sending       : std_logic := '0';
signal r_TX_Done       : std_logic := '0';
constant CLKS_PER_BIT : integer := 10417;  -- 9600 baud rate with 100 MHz clock

-- Define the message to be sent
--type t_message is array (0 to 4) of std_logic_vector(7 downto 0);
--constant c_message : t_message := (
--    "01001000", -- H
--    "01000101", -- E
--    "01001100", -- L
--    "01001100", -- L
--    "01001111"  -- O
--);

constant CLEAR_SCREEN : std_logic_vector(7 downto 0) := "00001100";  -- ASCII for Form Feed (FF)

constant MESSAGE_LENGTH : integer := 40;
signal r_Message_Index : integer range 0 to MESSAGE_LENGTH := 0;

    type t_message_lut is array (0 to MESSAGE_LENGTH-1) of std_logic_vector(7 downto 0);
    constant c_message_lut : t_message_lut := (
        "01001000", -- H
        "01100101", -- e
        "01101100", -- l
        "01101100", -- l
        "01101111", -- o
        "00100000", -- space
        "01010111", -- W
        "01101111", -- o
        "01110010", -- r
        "01101100", -- l
        "01100100", -- d
        "00100000", -- space
        "01100110", -- f
        "01110010", -- r
        "01101111", -- o
        "01101101", -- m
        "00100000", -- space
        "01000100", -- D
        "01101111", -- o
        "01101110", -- n
        "01100111", -- g
        "01111001", -- y
        "01110101", -- u
        "01101110", -- n
        "00100000", -- space
        "01001100", -- L
        "01100101", -- e
        "01100101", -- e
        "00100000", -- space
        "00110010", -- 2
        "00110000", -- 0
        "00110010", -- 2
        "00110100", -- 4
        "00101110", -- .
        "00110000", -- 0
        "00110110", -- 6
        "00101110", -- .
        "00110000", -- 0
        "00110101",  -- 5
        "00100000" -- space
    );


begin
    debounce : entity debounce_fsm
    port map(
        button => button,
        rst_bar => rst_bar,
        clk => clk,
        out_button => button_clear
        );
        
     UART_TX1 : entity UART_TX
        generic map(g_CLKS_PER_BIT => CLKS_PER_BIT)
        port map (
            i_Clk       => clk,
            i_TX_DV     => i_TX_DV,
            i_TX_Byte   => i_TX_Byte,
            o_TX_Active => o_TX_Active,
            o_TX_Serial => o_TX_Serial,
            o_TX_Done   => r_TX_Done
        );
        
--      clk_divder : entity Clock_Divider
--      generic map(g_CLKS_PER_BIT => CLKS_PER_BIT)
--      port map(
--        i_Clk => clk,
--        o_Baud_Clk => divided_clk
--        );
        
            -- Control process to send the character "A" on button press
--    process(clk)
--    begin
--        if rising_edge(clk) then
--            if button_clear = '1' then
--                i_TX_DV <= '1';  -- Trigger UART transmission
--            elsif o_TX_Done = '1' then
--                i_TX_DV <= '0';  -- Reset the trigger
--            end if;
--        end if;
--    end process;

-- Control process to send multiple characters
    process(clk, rst_bar)
    variable r_Message_Index : integer range 0 to MESSAGE_LENGTH := 0;
    begin
        if rising_edge(clk) then
                    if rst_bar = '0' then
                    -- When reset is active, send clear screen character

                    i_TX_Byte <= CLEAR_SCREEN;
                    i_TX_DV <= '1';
                    r_Message_Index := 0;
                    
                    elsif button_clear = '1' and r_Sending = '0' then
                    -- When button is pressed and not already sending, start sending the message
                        r_Sending <= '1';
                        r_Message_Index := 0;
                        i_TX_Byte <= c_message_lut(r_Message_Index);
                        i_TX_DV <= '1';
                    elsif r_Sending = '1' then
                                if r_TX_Done = '1' then
                                    
                                            if r_Message_Index < MESSAGE_LENGTH - 1 then
                                                r_Message_Index := r_Message_Index + 1;    
                                               i_TX_Byte <= c_message_lut(r_Message_Index);                                                         
                                                --message_index <=   r_Message_Index; -- just for testbench waveform     
                        --                        i_TX_DV <= '1';
                                            else
                                                r_Sending <= '0';  -- Message sent
                                                i_TX_DV <= '0';  -- De-assert TX data valid
                                            end if;
                                end if;
                    else
                        i_TX_DV <= '0';
                    end if;
        end if;
        o_TX_Done <= r_TX_Done;
    end process;
end Behavioral;