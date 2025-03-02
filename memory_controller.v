`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2025 09:48:33 PM
// Design Name: 
// Module Name: memory_controller
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


module memory_controller(
    input wire clk_mem,
    input wire reset,
    input wire read_enable,
    input wire write_enable,
    input wire [7:0] write_data,
    input wire [7:0] read_address,
    output wire [7:0] read_data,
    output wire empty
    );
    
    wire [7:0] bram_read_data;
    
    bram bram1(
       .clk(clk_mem),
       .reset(reset),
       .data(write_data),
       .readWrite(write_enable),
       .addr(read_address),
       .out(bram_read_data)
        );
    
    asynch_fifo fifo1(
        .clk_master(clk_master),
        .clk_mem(clk_mem),
        .reset(reset),
        .data_in(write_data),
        .w_en(write_enable),
        .full(full),
        .r_en(read_enable),
        .data_out(fifo_data_out),
        .empty(empty)
        );
        
    assign read_data = bram_read_data;
    
endmodule
