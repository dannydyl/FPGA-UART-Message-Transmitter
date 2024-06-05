----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2024 10:11:23 PM
-- Design Name: 
-- Module Name: UART_Transmitter_tb - Behavioral
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

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use work.all;

entity uart_tb is
end uart_tb;

architecture behave of uart_tb is

  component uart_tx is
    generic (
      g_CLKS_PER_BIT : integer := 10417   -- Needs to be set correctly
      );
    port (
      i_clk       : in  std_logic;
      i_tx_dv     : in  std_logic;
      i_tx_byte   : in  std_logic_vector(7 downto 0);
      o_tx_active : out std_logic;
      o_tx_serial : out std_logic;
      o_tx_done   : out std_logic
      );
  end component uart_tx;

  -- Test Bench uses a 10 MHz Clock
  -- Want to interface to 115200 baud UART
  -- 10000000 / 115200 = 87 Clocks Per Bit.
  constant c_CLKS_PER_BIT : integer := 10417;

  constant c_BIT_PERIOD : time := 8680 ns;

  signal r_CLOCK     : std_logic                    := '0';
  signal r_TX_DV     : std_logic                    := '0';
  signal r_TX_BYTE   : std_logic_vector(7 downto 0) := (others => '0');
  signal w_TX_SERIAL : std_logic;
  signal w_TX_DONE   : std_logic;
  -- Commented out signals related to receiver
  --signal w_RX_DV     : std_logic;
  --signal w_RX_BYTE   : std_logic_vector(7 downto 0);
  --signal r_RX_SERIAL : std_logic := '1';

begin

-- Instantiate UART transmitter 
UART_TX_INST : uart_tx 
  generic map (
    g_CLKS_PER_BIT => c_CLKS_PER_BIT
      )
    port map (
      i_clk       => r_CLOCK,
      i_tx_dv     => r_TX_DV,
      i_tx_byte   => r_TX_BYTE,
      o_tx_active => open,
      o_tx_serial => w_TX_SERIAL,
      o_tx_done   => w_TX_DONE
      );

  -- Commented out UART Receiver instantiation
  -- UART_RX_INST : uart_rx
  --   generic map (
  --     g_CLKS_PER_BIT => c_CLKS_PER_BIT
  --     )
  --   port map (
  --     i_clk       => r_CLOCK,
  --     i_rx_serial => r_RX_SERIAL,
  --     o_rx_dv     => w_RX_DV,
  --     o_rx_byte   => w_RX_BYTE
  --     );

  r_CLOCK <= not r_CLOCK after 10 ns;

  process is
  begin

    -- Tell the UART to send a command.
    wait until rising_edge(r_CLOCK);
    wait until rising_edge(r_CLOCK);
    r_TX_DV   <= '1';
    r_TX_BYTE <= X"AB"; -- Example data byte
    wait until rising_edge(r_CLOCK);
    r_TX_DV   <= '0';
    wait until w_TX_DONE = '1';

    -- Wait for a few clock cycles before ending the test
    wait for 1000ms;

--    report "Test Complete - UART Transmitter" severity note;
--    assert false report "End of Test" severity failure;

  end process;

end behave;
