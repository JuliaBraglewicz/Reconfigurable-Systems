`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 21:01:59
// Design Name: 
// Module Name: ry_mux
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


module ry_mux(
    input [2:0]ry_op,
    input [7:0]r0,
    input [7:0]r1,
    input [7:0]r2,
    input [7:0]r3,
    input [7:0]r4,
    input [7:0]r5,
    input [7:0]r6,
    input [7:0]r7,
    output [7:0]ry
    );

assign ry = (ry_op == 3'd0) ? r0 :
            (ry_op == 3'd1) ? r1 :
            (ry_op == 3'd2) ? r2 :
            (ry_op == 3'd3) ? r3 :
            (ry_op == 3'd4) ? r4 :
            (ry_op == 3'd5) ? r5 :
            (ry_op == 3'd6) ? r6 :
            (ry_op == 3'd7) ? r7 : 8'b0; // sprawdziæ

endmodule
