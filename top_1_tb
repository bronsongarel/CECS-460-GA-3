module top_tb();

 // Clock and Reset signals
    reg clk_master;
    reg clk_mem;
    reg reset;
    reg [7:0] write_data;
    
    // Outputs from top module
    wire [7:0] read_data;
    wire full;
    wire empty;

    // Clock generation
    always #5 clk_master = ~clk_master; // 90 MHz
    always #7 clk_mem = ~clk_mem;       // 65 MHz

    // Instantiate the top module
    top uut (
        .clk_master(clk_master),
        .clk_mem(clk_mem),
        .reset(reset),
        .write_data(write_data),
        .read_data(read_data),
        .full(full),
        .empty(empty)
    );

    // Stimulus
    initial begin
        // Initialize signals
        clk_master = 0;
        clk_mem = 0;
        reset = 1;
        write_data = 8'hAA; // Start with some test data

        // Reset for a few clock cycles
        #10 reset = 0;
        
        // Write some test data into the FIFO
        #50 write_data = 8'h55;
        #100 write_data = 8'hFF;

        // End simulation
        #200 $finish;
    end
    
endmodule
