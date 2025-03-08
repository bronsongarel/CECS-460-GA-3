`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2025 09:55:56 AM
// Design Name: 
// Module Name: mem_control
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


module mem_control(
    input wire clk_mem,
    input wire reset,
    input wire rd_en_mem,
    input wire [7:0] data_in,
    output wire [7:0] data_out,
    output wire wr_en_mem
    );
    
    // BRAM Interface Simulation
    reg [7:0] bram [255:0];       // 8-bit BRAM (preloaded with data pattern)
    reg [7:0] data_out_reg;

    always @(posedge clk_mem or posedge reset) begin
        if (reset) begin
            data_out_reg <= 8'b0;
        end else if (rd_en_mem) begin
            // Read data from BRAM
            data_out_reg <= bram[rd_en_mem]; 
        end
    end

    assign data_out = data_out_reg;

    always @(posedge clk_mem) begin
        // Simulating writing read data back to FIFO
        if (wr_en_mem) begin
            // Data writing logic
        end
    end
    
endmodule
