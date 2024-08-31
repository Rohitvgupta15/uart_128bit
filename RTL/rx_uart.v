`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 22:57:25
// Design Name: Rohit Vijay Gupta
// Module Name: rx_uart
// Project Name: recevier
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

module rx_uart(
    input clk,
    input reset,
    input u_tx,
    input en_rx,
    output u_rx_done,  
    output reg [127:0] data_out
);

    reg [4:0] counter; 
    wire [7:0] uart_slave_data;
    reg receiving;

    
    recevier r1 (
        .clk(clk),
        .u_rx(u_tx),
        .en_rx(en_rx),
        .data(uart_slave_data),
        .u_rx_done(u_rx_done)  
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 5'd0;
            data_out <= 128'd0;
            receiving <= 1'b0;
        end else if (en_rx) begin
            if (u_rx_done && !receiving && counter <= 16) begin
                receiving <= 1'b1;
                data_out <= {data_out[119:0], uart_slave_data};  
                counter <= counter + 1;
            end else if (!u_rx_done && receiving) begin
                receiving <= 1'b0;
            end
        end
    end
endmodule
