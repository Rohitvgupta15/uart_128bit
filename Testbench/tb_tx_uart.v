`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 22:51:36
// Design Name: 
// Module Name: tb_tx_uart
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

module tb_tx_uart;
    reg clk;
    reg [127:0] data_in;
    reg en_tx;
    wire u_tx;
    wire u_tx_done;

    tx_uart uut (
        .clk(clk),
        .data_in(data_in),
        .en_tx(en_tx),
        .u_tx(u_tx),
        .u_tx_done(u_tx_done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        en_tx = 0;
        data_in = 128'h00112233445566778899aabbccddeeff;

        #10 en_tx = 1;
        wait(u_tx_done == 1); 

        #1790;
        #10 $finish;
    end

    initial begin
        $monitor("Time = %0t | data_in = %h | u_tx = %b | u_tx_done = %b", $time, data_in, u_tx, u_tx_done);
    end
endmodule
