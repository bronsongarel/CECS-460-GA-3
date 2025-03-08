`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2025 10:01:48 AM
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb();
    // Declare testbench signals
    reg clk_master;           // 90 MHz clock for the Master Module
    reg clk_mem;              // 65 MHz clock for the Memory Controller
    reg reset;                // Reset signal

    // Wires for connecting to the top module
    wire wr_en_master;        // Write enable from Master Module
    wire [7:0] data_in;       // Data to FIFO from Master Module
    wire rd_en_master;        // Read enable to FIFO from Master Module
    wire [7:0] data_out_master; // Data from FIFO to Master Module

    wire wr_en_mem;           // Write enable from Memory Controller to FIFO
    wire [7:0] data_in_mem;   // Data to FIFO from Memory Controller
    wire rd_en_mem;           // Read enable to FIFO from Memory Controller
    wire [7:0] data_out_mem;  // Data from FIFO to Memory Controller

    wire fifo_full;           // FIFO full flag
    wire fifo_empty;          // FIFO empty flag

    // Instantiate the top module
    top uut (
        .clk_master(clk_master),
        .clk_mem(clk_mem),
        .reset(reset)
    );

    // Clock generation (90 MHz for Master, 65 MHz for Memory Controller)
    always begin
        clk_master = 1'b0;
        #5 clk_master = 1'b1; // 90 MHz clock (5 ns period)
    end

    always begin
        clk_mem = 1'b0;
        #7.692 clk_mem = 1'b1; // 65 MHz clock (~7.692 ns period)
    end

    // Initial block for stimulus
    initial begin
        // Initialize signals
        reset = 1'b1;   // Apply reset
        #20;            // Wait for a while to ensure reset propagation
        reset = 1'b0;   // Deassert reset

        // Apply stimulus for writing data into FIFO
        #10;
        // Simulate Master Module writes to FIFO
        #10;
        // Simulate reading from FIFO by Memory Controller
        #20;
        // Simulate Memory Controller writes back data to FIFO
        #30;
        // Master reads data from FIFO
        #20;

        // Finish simulation after sufficient time
        #100;
        $stop;
    end

    // Monitoring for simulation outputs
    initial begin
        $monitor("At time %t, wr_en_master = %b, data_in = %h, rd_en_master = %b, data_out_master = %h, wr_en_mem = %b, data_in_mem = %h, rd_en_mem = %b, data_out_mem = %h, fifo_full = %b, fifo_empty = %b",
                $time, wr_en_master, data_in, rd_en_master, data_out_master, wr_en_mem, data_in_mem, rd_en_mem, data_out_mem, fifo_full, fifo_empty);
    end
endmodule
