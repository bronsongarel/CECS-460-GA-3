`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSULB
// Engineer: Bronson Garel, Andrew Nyugen, Kenneth Vuong, Kyle Wyckoff
// 
// Create Date: 02/27/2025 06:31:45 PM
// Design Name: 
// Module Name: master
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


module master(
    input wire clk_master,
    input wire reset,
    input wire [7:0] write_data,
    output wire [7:0] read_data,
    output reg w_en,
    output wire r_en,
    output wire full
    );
    
    reg [7:0] write_data_reg;
    wire [7:0] fifo_data_out;
    
    // Write to FIFO
    always @(posedge clk_master or posedge reset) begin
        if (reset) begin
            write_data_reg <= 0;
        end else begin
            if (!full) begin
                w_en <= 1;
                write_data_reg <= write_data;
            end
        end
    end
    
    // Read from FIFO
    assign read_data = fifo_data_out;
    assign read_enable = 1;
    
    // FIFO
    // asynch_fifo fifo1(
    //     .clk_master(clk_master),
    //     .clk_mem(clk_mem),
    //     .reset(reset),
    //     .data_in(write_data_reg),
    //     .w_en(w_en), 
    //     .full(full),
    //     .r_en(r_en),
    //     .data_out(fifo_data_out),  
    //     .empty(empty)   
    //     );
endmodule
