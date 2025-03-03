`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSULB
// Engineer: Bronson Garel, Andrew Nyugen, Kenneth Vuong, Kyle Wyckoff
// 
// Create Date: 02/28/2025 09:48:33 PM
// Design Name: GA3
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
    input wire r_en,
    input wire w_en,
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
       .readWrite(w_en),
       .addr(read_address),
       .out(bram_read_data)
        );
    
    asynch_fifo fifo1(
        .clk_master(clk_master),
        .clk_mem(clk_mem),
        .reset(reset),
        .data_in(write_data),
        .w_en(w_en),
        .full(full),
        .r_en(r_en),
        .data_out(fifo_data_out),
        .empty(empty)
        );
        
    assign read_data = bram_read_data;
    
endmodule
