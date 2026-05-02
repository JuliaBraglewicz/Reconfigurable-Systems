`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 18:47:10
// Design Name: 
// Module Name: postprocess
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


module postprocess(
    input [23:0]video_in,
    output [35:0]video_out
    );
    
    wire [11:0] b = {video_in[7:0],4'b0000};
    wire [11:0] g = {video_in[15:8],4'b0000};
    wire [11:0] r = {video_in[23:16],4'b0000};
    
    assign video_out = {b, r, g};
endmodule
