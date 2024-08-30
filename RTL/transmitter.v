`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 22:48:03
// Design Name: 
// Module Name: transmitter
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


module transmitter(
    input clk, // clock
    input [7:0] data, // input from main bus or other module
    input en_tx, // enable signal to Tx UART
    output reg u_tx, // output to another uart 
    output reg u_tx_done // Tx is done
);

reg [2:0] state_tx;
reg [2:0] count;
reg [7:0] din;
reg en;

parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter DATA = 3'b010;
parameter PARITY = 3'b011;
parameter DONE = 3'b100;

// Optional initial state definition
initial state_tx = START;

always @(negedge clk) begin
    case (state_tx)
        START: begin
            if (en_tx) begin
                state_tx <= DATA;
                din <= data;
                u_tx <= 0;
                u_tx_done <= 0;
                count <= 0;
                en <= 1;  // Enable transmission process
            end else begin
                u_tx <= 1'bz;
            end
        end

        DATA: begin
            if (en) begin
                u_tx <= din[count];
                count <= count + 1;
                if (count == 3'b111) begin
                    state_tx <= PARITY;
                end
            end
        end

        PARITY: begin
            if (en) begin
                u_tx <= ^din;  // even parity
                state_tx <= DONE;
            end
        end

        DONE: begin
            u_tx_done <= 1;
            u_tx <= 0;
            en <= 0;  // Disable further transmission
            state_tx <= START;
        end
        
        default: begin
            state_tx <= START;
        end
    endcase
end

endmodule

