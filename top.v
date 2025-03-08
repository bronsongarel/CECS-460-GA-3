`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2025 10:00:35 AM
// Design Name: 
// Module Name: top
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


module top(
    input clk_master,
    input clk_mem,
    input reset
    );
    
    // Wires to connect the modules
    reg wr_en_master;          // Write enable from Master Module
    wire [7:0] data_in;         // Data input from Master Module to FIFO
    reg rd_en_master;          // Read enable from Master Module to FIFO
    wire [7:0] data_out_master; // Data output from FIFO to Master Module

    reg wr_en_mem;             // Write enable from Memory Controller to FIFO
    wire [7:0] data_in_mem;     // Data input from Memory Controller to FIFO
    reg rd_en_mem;             // Read enable from Memory Controller from FIFO
    wire [7:0] data_out_mem;    // Data output from FIFO to Memory Controller

    wire fifo_full;             // FIFO full flag
    wire fifo_empty;            // FIFO empty flag

    // Instantiating the FIFO module
    fifo fifo_inst (
        .clk_master(clk_master), 
        .clk_mem(clk_mem), 
        .reset(reset),
        .wr_en_master(wr_en_master), 
        .data_in(data_in), 
        .rd_en_mem(rd_en_mem),
        .data_out(data_out_mem), 
        .fifo_full(fifo_full), 
        .fifo_empty(fifo_empty)
    );

    // Instantiating the Master Module
    master master_inst (
        .clk_master(clk_master), 
        .reset(reset), 
        .wr_en_master(wr_en_master), 
        .data_in(data_in), 
        .rd_en_master(rd_en_master), 
        .data_out(data_out_master)
    );

    // Instantiating the Memory Controller
    mem_control mem_inst (
        .clk_mem(clk_mem), 
        .reset(reset), 
        .wr_en_mem(wr_en_mem), 
        .data_in(data_in_mem), 
        .rd_en_mem(rd_en_mem), 
        .data_out(data_out_mem)
    );

    // Logic to control read/write enables based on FIFO flags
    always @(posedge clk_master or posedge reset) begin
        if (reset) begin
            // Reset logic for controlling signals
            wr_en_master <= 0;
            rd_en_master <= 0;
        end else begin
            // Master-to-FIFO logic
            if (!fifo_full) begin
                wr_en_master <= 1;  // Enable write to FIFO if not full
            end
            if (!fifo_empty) begin
                rd_en_master <= 1;  // Enable read from FIFO if not empty
            end
        end
    end

    always @(posedge clk_mem or posedge reset) begin
        if (reset) begin
            // Reset logic for controlling signals
            wr_en_mem <= 0;
            rd_en_mem <= 0;
        end else begin
            // FIFO-to-Memory logic
            if (!fifo_empty) begin
                rd_en_mem <= 1;  // Enable read from FIFO to Memory
            end
            if (!fifo_full) begin
                wr_en_mem <= 1;  // Enable write from Memory to FIFO
            end
        end
    end
    
endmodule
