# UART Message Transmitter with Basys3

## Overview

This project implements a UART-based message transmitter using the Basys3 FPGA development board. The project was designed and implemented using Vivado Xilinx tools and PuTTY for UART communication. The system operates at a baud rate of 9600 and sends the message "Hello World from Dongyun Lee 2024.06.05" when a button is pressed. Additionally, it clears the terminal when the reset button is activated.

## Demonstration Video

A demonstration video of the project in action has been uploaded to YouTube. You can view the video here: (https://youtu.be/zg-xdQ0EZM8?si=Taq5_2_vcEwoI7bP)

## Features

- **UART Transmitter**: Sends a predefined message over UART at a baud rate of 9600.
- **Clear Screen Functionality**: Clears the terminal when the reset button is activated.
- **Modular Design**: Includes separate modules for UART transmission and message control.
- **Testbenches**: Comprehensive testbenches for each module to ensure correct functionality.

## System Architecture

### UART Transmitter

The UART transmitter module sends serial data, including start and stop bits. It handles the timing requirements for UART communication by using a clock divider to match the system clock to the baud rate.

### Message Controller

The message controller module manages the transmission of the message. It uses a lookup table (LUT) to store the message characters and sends each character sequentially when the button is pressed. It also sends a clear screen character when the reset button is activated.

### Finite State Machine (FSM)

The FSM technique is used to control the states of the UART transmitter and message controller. The FSM transitions between different states such as idle, start bit, data bits, stop bit, and cleanup to manage the UART transmission process efficiently.

### Debouncing

The debounce module is used to ensure that the physical button press is registered correctly by filtering out any noise or bouncing effects. This ensures reliable operation of the button press detection.

## Implementation Details

### UART Transmitter

- **Baud Rate**: 9600
- **Start Bit**: 1 bit
- **Data Bits**: 8 bits
- **Stop Bit**: 1 bit
- **FSM States**: Idle, Start Bit, Data Bits, Stop Bit, Cleanup

### Message Controller

- **Message**: "Hello World from Dongyun Lee 2024.06.05"
- **Clear Screen Character**: ASCII Form Feed (FF, `0x0C`)
- **Lookup Table (LUT)**: Used to store and sequentially access message characters

### Debouncer

- **Debouncing Delay**: Ensures that the button press is accurately detected by eliminating noise

## Testing

Comprehensive testbenches were developed for each module to verify their functionality. The testbenches simulate the behavior of each module and ensure correct operation under various conditions.

## Tools Used

- **Vivado Xilinx Tools**: For design and implementation.
- **PuTTY**: For UART communication and testing.
- **Basys3 FPGA Development Board**: The target hardware platform for the project.

## Project Structure

- **Source Files**: Contains VHDL files for UART transmitter, message controller, and top-level entity.
- **Testbenches**: Contains testbench files for each module.
- **Constraints**: Contains the XDC file for FPGA pin assignments.


