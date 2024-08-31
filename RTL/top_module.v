`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 23:18:35
// Design Name: Rohit Vijay Gupta
// Module Name: Uart_top_module
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


module uart(
    input clk,
    input reset,
    input en_tx,
    input en_rx,
    input [127:0]data_in,
    output u_tx_done,
    output u_rx_done,
    output [127:0]data_out
    );
   
   wire uart_tx;
    
    tx_uart tx1 (
           .clk(clk),
           .reset(reset),        
           .data_in(data_in), 
           .en_tx(en_tx),
           .u_tx(uart_tx),
           .u_tx_done(u_tx_done)
       );
       
    rx_uart rx1 (
           .clk(clk),
           .reset(reset),        
           .u_tx(uart_tx), 
           .en_rx(en_rx),
           .data_out(data_out),
           .u_rx_done(u_rx_done)
       );

endmodule
