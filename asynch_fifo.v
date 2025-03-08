`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2025 09:55:56 AM
// Design Name: 
// Module Name: fifo
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


module fifo(
    input wire clk_master,
    input wire clk_mem,
    input wire reset,
    input wire wr_en_master,
    input wire [7:0] data_in,
    input wire rd_en_mem,
    output wire [7:0] data_out,
    output wire full,
    output wire empty
    );
    
    // FIFO Depth and Size (Assuming 16-depth FIFO, can be adjusted)
    localparam FIFO_DEPTH = 16;
    reg [7:0] fifo_mem [FIFO_DEPTH-1:0];  // FIFO memory (8-bit wide)
    reg [3:0] wr_ptr_master, rd_ptr_mem;   // Write and read pointers
    reg [3:0] wr_ptr_sync, rd_ptr_sync;   // Synchronized pointers (Gray-coded)
    wire [3:0] wr_ptr_master_gray, rd_ptr_mem_gray;
    reg [3:0] rd_ptr_sync_d1;             // Delayed read pointer for synchronization
    reg full_flag, empty_flag;

    // Synchronizing write pointer using Gray code
    always @(posedge clk_master or posedge reset) begin
        if (reset) begin
            wr_ptr_master <= 4'b0;
        end else if (wr_en_master && !fifo_full) begin
            wr_ptr_master <= wr_ptr_master + 1;
        end
    end

    // Synchronizing read pointer using Gray code
    always @(posedge clk_mem or posedge reset) begin
        if (reset) begin
            rd_ptr_mem <= 4'b0;
        end else if (rd_en_mem && !fifo_empty) begin
            rd_ptr_mem <= rd_ptr_mem + 1;
        end
    end

    // Full/Empty Logic
    assign fifo_full = (wr_ptr_master == rd_ptr_sync_d1 && wr_ptr_master != rd_ptr_mem);
    assign fifo_empty = (rd_ptr_mem == wr_ptr_master_sync);

    // FIFO Data Storage (Write/Read Data)
    always @(posedge clk_master) begin
        if (wr_en_master && !fifo_full) begin
            fifo_mem[wr_ptr_master] <= data_in;
        end
    end

    assign data_out = (rd_en_mem && !fifo_empty) ? fifo_mem[rd_ptr_mem] : 8'bz;

endmodule
