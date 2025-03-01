`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bronson Garel
//           Kyle Wyckoff
//           Andrew Nguyen
//           Kenneth Vuong
// 
// Create Date: 02/12/2025 03:43:25 PM
// Design Name: 
// Module Name: bram
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


module bram(
    input clk,
    input reset,
    input [7:0] data,
    input readWrite,
    input [7:0] addr,
    output reg [7:0] out
    );
    
    reg [7:0] bram [0:255];
    reg [7:0] regBits;
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            bram[i] = 255 - i;
        end
        out <= 0;
    end
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) begin
                bram[i] = 255 - i;
            end
            out <= 0;
        end
        else if (!readWrite) begin //read = 0
            out <= bram[addr];
        end
        else if (readWrite) begin //write = 1
            out <= 0;
            bram[addr] <= data;
        end
    end
    
endmodule
