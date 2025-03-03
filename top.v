`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bronson Garel, Andrew Nyugen, Kenneth Vuong, Kyle Wyckoff
// 
// Create Date: 03/01/2025 09:20:38 PM
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
    input wire clk_master,
    input wire clk_mem,
    input wire reset,
    input wire [7:0] write_data,
    output wire [7:0] read_data,
    output wire full,
    output wire empty
    );
    
    // FIFO Signals
    wire [7:0] fifo_data_out;
    wire w_en_master;
    wire r_en_mem;
    
    // Memory Controller Signals
    wire [7:0] write_data_mem;
    wire [7:0] read_address_mem;
    wire w_en_mem;
    wire r_en_mem_internal;
    
    master master1(
        .clk_master(clk_master),
        .reset(reset),
        .write_data(write_data),
        .read_data(fifo_data_out),
        .w_en(w_en_master),
        .r_en(r_en_mem),
        .full(full)
        ); 
    
    memory_controller memory_inst (
        .clk_mem(clk_mem),
        .reset(reset),
        .write_data(write_data_mem),
        .read_data(read_data),
        .w_en(w_en_mem),
        .r_en(r_en_mem_internal),
        .read_address(read_address_mem),
        .empty(empty)
    );

    // Instantiate the FIFO
    asynch_fifo fifo_inst (
        .clk_master(clk_master),
        .clk_mem(clk_mem),
        .reset(reset),
        .data_in(write_data),
        .w_en(w_en_master),
        .full(full),
        .r_en(r_en_mem_internal),
        .data_out(fifo_data_out),
        .empty(empty)
    );

    // Instantiate BRAM
    bram bram_inst (
        .clk(clk_mem),
        .reset(reset),
        .addr(read_address_mem),
        .data(write_data_mem),
        .readWrite(w_en_mem),
        .out(read_data)
    );

    // Data Flow
    assign write_data_mem = fifo_data_out;   // Data from FIFO is written to BRAM
    assign read_address_mem = fifo_data_out; // Address read from FIFO data
    assign w_en_mem = w_en_master;  // Same write enable logic for BRAM
    assign r_en_mem_internal = r_en_mem;  // Control the read from FIFO
endmodule

