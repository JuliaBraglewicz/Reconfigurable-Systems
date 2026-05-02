`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 18:42:45
// Design Name: 
// Module Name: preprocess
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


module preprocess(
    input [23:0]video_in,
    output [23:0]video_out
    );
    
    wire [7:0] r = video_in[15:8];
    wire [7:0] g = video_in[7:0];
    wire [7:0] b = video_in[23:16];
    
    assign video_out = {r, g, b};
endmodule
