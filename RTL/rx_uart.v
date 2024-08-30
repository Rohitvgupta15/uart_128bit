`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 22:57:25
// Design Name: 
// Module Name: rx_uart
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


module rx_uart(
    input clk,
    input u_tx,
    input en_rx,
    output u_rx_done,
    output reg [127:0] data_out 
    );
    
    reg [4:0]counter = 5'b0;
    wire [7:0]uart_slave_data;
    
    always @( uart_slave_data)
       begin
         if(counter <= 5'd15) begin
            counter =counter +1;
            if(u_rx_done)
               data_out={data_out[119:0],uart_slave_data};
            end
                 
         end
          
    
    recevier r1 (
        .clk(clk),
        .u_rx(uart_tx), 
        .en_rx(en_rx),
        .data(uart_slave_data),
        .u_rx_done(u_rx_done)
    );
    
    
endmodule
