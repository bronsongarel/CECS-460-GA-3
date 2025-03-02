`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andrew Nguyen
// 
// Create Date: 02/28/2025 06:31:45 PM
// Design Name: 
// Module Name: Top_tb
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
// Clock Period = 1/Frequency
//////////////////////////////////////////////////////////////////////////////////
module tb_top;

    // Clock and reset signals
    reg clk_master;  // 90 MHz clock for Master Module
    reg clk_mem;     // 65 MHz clock for Memory Controller
    reg reset;       // Active-high reset

    // Master Module signals
    reg [7:0] write_data;  // Data to be written by Master
    wire [7:0] read_data;  // Data read by Master
    wire w_en;             // Write enable from Master
    wire r_en;             // Read enable from Master
    wire full;             // FIFO full flag
    wire empty;            // FIFO empty flag

    // Memory Controller signals
    wire [7:0] read_address;  // Address for BRAM read
    wire [7:0] read_data_mem; // Data read from BRAM

    // Instantiate the Master Module
    master master_inst (
        .clk_master(clk_master),
        .reset(reset),
        .write_data(write_data),
        .read_data(read_data),
        .w_en(w_en),
        .r_en(r_en),
        .full(full)
    );

    // Instantiate the Memory Controller
    memory_controller mem_ctrl_inst (
        .clk_mem(clk_mem),
        .reset(reset),
        .read_enable(r_en),
        .write_enable(w_en),
        .write_data(write_data),
        .read_address(read_address),
        .read_data(read_data_mem),
        .empty(empty)
    );

    // Clock generation for 90 MHz (Master Module)
    initial begin
        clk_master = 0;
        forever #5.555 clk_master = ~clk_master; // 90 MHz clock (11.11 ns period)
    end

    // Clock generation for 65 MHz (Memory Controller)
    initial begin
        clk_mem = 0;
        forever #7.692 clk_mem = ~clk_mem; // 65 MHz clock (15.384 ns period)
    end

    // Reset generation
    initial begin
        reset = 1; // Assert reset
        #20;       // Hold reset for 20 ns
        reset = 0; // De-assert reset
    end

    // Stimulus for Master Module
    initial begin
        write_data = 8'h00; // Initialize write data
        #30; // Wait for reset to de-assert

        // Write data to FIFO
        for (integer i = 0; i < 16; i = i + 1) begin
            write_data = i; // Write data incrementing from 0 to 15
            #11.11; // Wait for one clock cycle of 90 MHz
        end

        // Read data from FIFO
        #100; // Wait for Memory Controller to process data
        for (integer i = 0; i < 16; i = i + 1) begin
            #15.384; // Wait for one clock cycle of 65 MHz
        end

        // End simulation
        #100;
        $finish;
    end

endmodule
