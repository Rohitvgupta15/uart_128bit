`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 22:45:46
// Design Name: 
// Module Name: tx_uart
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


module tx_uart(
    input clk,
    input reset, 
    input [127:0] data_in,
    input en_tx,
    output u_tx,
    output u_tx_done
    );
    
    wire uart_tx;              
    wire [7:0] uart_slave_data; 
    reg [127:0] shift;
    reg [3:0] count;
    reg tx_en;               
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift <= 128'b0;
            count <= 4'b0;
            tx_en <= 1'b0;
        end else if (en_tx) begin
            if (u_tx_done) begin
                if (count < 4'd15) begin
                    shift <= shift << 8; //left shift
                    count <= count + 1;
                end else begin
                    count <= 4'd0; 
                    tx_en <= 1'b0; 
                end
            end
            if (!tx_en) begin
                shift <= data_in; 
                count <= 4'd0;
                tx_en <= 1'b1; 
            end
        end
    end

    transmitter t1 (
        .clk(clk),
        .data(shift[127:120]), 
        .en_tx(tx_en),
        .u_tx(uart_tx),
        .u_tx_done(u_tx_done)
    );
   
    assign u_tx = uart_tx;
    
endmodule
