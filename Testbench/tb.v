`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 23:28:57
// Design Name: Rohit Vijay Gupta 
// Module Name: tb_uart
// Project Name: uart
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

module tb_top_module;
    reg clk_tb;
    reg reset_tb;
    reg en_tx_tb;
    reg en_rx_tb;
    reg [127:0] data_in_tb;
    wire u_tx_done_tb;
    wire u_rx_done_tb;
    wire [127:0] data_out_tb;

    top_module uut (
        .clk(clk_tb),
        .reset(reset_tb),
        .en_tx(en_tx_tb),
        .en_rx(en_rx_tb),
        .data_in(data_in_tb),
        .u_tx_done(u_tx_done_tb),
        .u_rx_done(u_rx_done_tb),
        .data_out(data_out_tb)
    );

    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; 
    end

    task perform_tx_rx;
        input [127:0] data_in_task;
        begin

            reset_tb = 1;
            #150 reset_tb = 0; // 150 is must 

            data_in_tb = data_in_task;
            en_tx_tb = 1;
            en_rx_tb = 1;
            
            #2000; 
            
            $display("Time = %0t | Test with input = %h | Received data_out = %h", $time, data_in_task, data_out_tb);
                    
        end
    endtask

    initial begin
        reset_tb = 1;
        en_tx_tb = 0;
        en_rx_tb = 0;
        data_in_tb = 128'h0;

        #20 reset_tb = 0;

        // Test Case 1
        #10 perform_tx_rx(128'h00112233445566778899aabbccddeeff);

        // Test Case 2
        #150 perform_tx_rx(128'hffeeddccbbaa99887766554433221100);

        // Test Case 3
        #150 perform_tx_rx(128'h0123456789abcdef0123456789abcdef);

        $finish;
    end

    initial begin
        $monitor("Time = %0t | data_in_tb = %h | u_tx_done_tb = %b | u_rx_done_tb = %b | data_out_tb = %h", 
                 $time, data_in_tb, u_tx_done_tb, u_rx_done_tb, data_out_tb);
    end
endmodule
