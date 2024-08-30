`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 23:28:57
// Design Name: 
// Module Name: tb
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


module tb_topmodule;
    reg clk_tb;
    reg en_tx_tb;
    reg en_rx_tb;
    reg [127:0] data_in_tb;
    wire u_tx_done_tb;
    wire u_rx_done_tb;
    wire [127:0] data_out_tb;

    top_module uut (
        .clk(clk_tb),
        .en_tx(en_tx_tb),
        .en_rx(en_rx_tb),
        .data_in(data_in_tb),
        .u_tx_done(u_tx_done_tb),
        .u_rx_done(u_rx_done_tb),
        .data_out(data_out_tb)
    );

    // Clock generation
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        en_tx_tb = 0;
        en_rx_tb = 0;
        data_in_tb = 128'h00112233445566778899aabbccddeeff;

        // Start transmission and reception
        #10 en_tx_tb = 1; en_rx_tb = 1;
        wait(u_tx_done_tb == 1); // Wait for transmission to complete
        
//        #10 en_rx_tb = 0; // Stop reception
//        wait(u_rx_done_tb == 1); // Wait for reception to complete

//        // Check data_out
        #10;
        $display("Received data_out: %h", data_out_tb);

        // End simulation
        #1790;
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time = %0t | data_in_tb = %h | u_tx_done_tb = %b | u_rx_done_tb = %b | data_out_tb = %h", 
                 $time, data_in_tb, u_tx_done_tb, u_rx_done_tb, data_out_tb);
    end
endmodule
