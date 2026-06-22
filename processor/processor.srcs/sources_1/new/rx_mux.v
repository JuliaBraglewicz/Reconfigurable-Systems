`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 20:50:33
// Design Name: 
// Module Name: rx_mux
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


module rx_mux(
    input [2:0]rx_op,
    input [7:0]r0,
    input [7:0]r1,
    input [7:0]r2,
    input [7:0]r3,
    input [7:0]r4,
    input [7:0]r5,
    input [7:0]r6,
    input [7:0]r7,
    output [7:0]rx
    );

assign rx = (rx_op == 3'd0) ? r0 :
            (rx_op == 3'd1) ? r1 :
            (rx_op == 3'd2) ? r2 :
            (rx_op == 3'd3) ? r3 :
            (rx_op == 3'd4) ? r4 :
            (rx_op == 3'd5) ? r5 :
            (rx_op == 3'd6) ? r6 :
            (rx_op == 3'd7) ? r7 : 8'b0; // sprawdziæ

endmodule
