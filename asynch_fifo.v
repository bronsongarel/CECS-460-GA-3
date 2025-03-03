`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSULB
// Engineer: Bronson Garel, Andrew Nyugen, Kenneth Vuong, Kyle Wyckoff
// 
// Create Date: 02/27/2025 06:00:49 PM
// Design Name: 
// Module Name: asynch_fifo
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


module asynch_fifo #(parameter DATA_WIDTH=8,parameter FIFO_DEPTH=16)(
    input wire clk_master,  // 90 MHz Clock
    input wire clk_mem,     // 65 MHz Clock
    input wire reset,       // Active-high reset
    input wire [DATA_WIDTH-1:0] data_in,    // Data input from master
    input wire w_en,        // Write enable from master
    output wire full,       // FIFO Full Flag
    input wire r_en,        // Read enable from memory controller
    output wire [DATA_WIDTH-1:0] data_out,  // Data output to memory controller
    output wire empty       // FIFO Empty Flag
    );
    
    // FIFO Memory Array
    reg [DATA_WIDTH-1:0] fifo_mem [0:FIFO_DEPTH-1];

    // Write and read pointers 
    reg [4:0] wr_ptr_master, rd_ptr_mem;  // 5-bit pointers for a FIFO depth of 16
    reg [4:0] wr_ptr_mem, rd_ptr_master;
    
    // Gray code synchronization
    reg [4:0] wr_ptr_gray_master, rd_ptr_gray_mem;
    reg [4:0] wr_ptr_gray_mem, rd_ptr_gray_master;
    
    // FIFO status flags
    reg fifo_full, fifo_empty;
    
    // Gray code conversion
    function [4:0] to_gray(input [4:0] bin);
        to_gray = bin ^ (bin >> 1);
    endfunction
    
    // FIFO Write Logic
    always @(posedge clk_master or posedge reset) begin
        if (reset) begin
            wr_ptr_master <= 0;
            wr_ptr_gray_master <=0;
            fifo_full <= 0;
        end else if (w_en && !fifo_full) begin
            fifo_mem[wr_ptr_master] <= data_in;
            wr_ptr_master <= wr_ptr_master + 1;
            wr_ptr_gray_master <= to_gray(wr_ptr_master);
        end
    end
    
    // FIFO Read Logic
    always @ (posedge clk_mem or posedge reset) begin
        if (reset) begin
            rd_ptr_mem <= 0;
            rd_ptr_gray_mem <= 0;
            fifo_empty <= 0;
        end else if (r_en && !fifo_empty) begin
            rd_ptr_mem <= rd_ptr_mem + 1;
            rd_ptr_gray_mem <= to_gray(rd_ptr_mem);
        end
    end
    
    // Synch pointers between clock domains
    always @(posedge clk_mem) begin
        wr_ptr_gray_mem <= wr_ptr_gray_master;
    end
    
    always @(posedge clk_master) begin
        rd_ptr_gray_master <= rd_ptr_gray_mem;
    end
    
    // FIFO full and empty detection
    assign full     = (wr_ptr_gray_master == {~rd_ptr_gray_mem[4:0], rd_ptr_gray_mem[4]});
    assign empty    = (rd_ptr_gray_master == wr_ptr_gray_mem);
    assign data_out = fifo_mem[rd_ptr_mem];
    
    always @(posedge clk_master or posedge reset) begin
        if (reset) begin
            fifo_full <= 0;
            fifo_empty <= 1;
        end else begin
            fifo_full <= (wr_ptr_gray_master == {~rd_ptr_gray_mem[4:0], rd_ptr_gray_mem[4]});
            fifo_empty <= (rd_ptr_gray_master == wr_ptr_gray_mem);
        end
    end
endmodule
