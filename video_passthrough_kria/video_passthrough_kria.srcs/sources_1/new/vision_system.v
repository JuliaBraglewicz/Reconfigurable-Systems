`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 19:46:35
// Design Name: 
// Module Name: vision_system
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


module vision_system(
    input clk,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0]pixel_in,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0]pixel_out
    );
    
//wire [7:0]red;
//wire [7:0]green;
//wire [7:0]blue;

//wire result;

//reg r_de = 0;
//reg r_hsync = 0;
//reg r_vsync = 0;
    
//LUT lut_red (
//    .a(pixel_in[23:16]),
//    .clk(clk),
//    .qspo(red)
//);

//LUT lut_green (
//    .a(pixel_in[15:8]),
//    .clk(clk),
//    .qspo(green)
//);

//LUT lut_blue (
//    .a(pixel_in[7:0]),
//    .clk(clk),
//    .qspo(blue)
//);

//assign result = red[0] & green[0] & blue[0];

rgb2ycbcr_0 conversion (
    .clk(clk),
    .de_in(de_in),
    .hsync_in(hsync_in),
    .vsync_in(vsync_in),
    .pixel_in(pixel_in),
    .de_out(de_out),
    .hsync_out(hsync_out),
    .vsync_out(vsync_out),
    .pixel_out(pixel_out)
);

//always @(posedge clk)
//begin
//    r_de <= de_in;
//    r_hsync <= hsync_in;
//    r_vsync <= vsync_in;
//end
    
//    assign de_out = r_de;
//    assign hsync_out = r_hsync;
//    assign vsync_out = r_vsync;
//    assign pixel_out = result ? 24'hFFFFFF : 24'h000000;
endmodule
