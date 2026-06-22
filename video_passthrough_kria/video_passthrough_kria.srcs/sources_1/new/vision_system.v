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


module vision_system # (
    parameter IMG_W = 1920,
    parameter IMG_H = 1080,
    parameter H_SIZE = 2200
)(
    input clk,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0]pixel_in,
    input [3:0]sw,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0]pixel_out
    );
    
wire [23:0]rgb_mux[15:0];
wire de_mux[15:0];
wire hsync_mux[15:0];
wire vsync_mux[15:0];

assign rgb_mux[0] = pixel_in;
assign de_mux[0] = de_in;
assign hsync_mux[0] = hsync_in;
assign vsync_mux[0] = vsync_in;

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
    .pixel_in(rgb_mux[0]),
    .de_out(de_mux[1]),
    .hsync_out(hsync_mux[1]),
    .vsync_out(vsync_mux[1]),
    .pixel_out(rgb_mux[1])
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

wire [7:0]bin;

localparam Ta = 8'd77;
localparam Tb = 8'd127;
localparam Tc = 8'd133;
localparam Td = 8'd173;

wire [7:0]Cb;
wire [7:0]Cr;

assign Cb = rgb_mux[1][15:8];
assign Cr = rgb_mux[1][7:0];

assign bin = (Cb > Ta && Cb < Tb && Cr > Tc && Cr < Td) ? 8'd255 : 0;

assign rgb_mux[2] = {bin, bin, bin};
assign de_mux[2] = de_mux[1];
assign hsync_mux[2] = hsync_mux[1];
assign vsync_mux[2] = vsync_mux[1];

rgb2hsv_0 conv_hsv (
    .clk(clk),
    .de_in(de_in),
    .hsync_in(hsync_in),
    .vsync_in(vsync_in),
    .pixel_in(rgb_mux[0]),
    .de_out(de_mux[3]),
    .hsync_out(hsync_mux[3]),
    .vsync_out(vsync_mux[3]),
    .pixel_out(rgb_mux[3])
);

wire [7:0]filter_bin;

median5x5 # (
    .H_SIZE(H_SIZE)
) filter (
    .clk(clk),
    .de(de_mux[2]),
    .hsync(hsync_mux[2]),
    .vsync(vsync_mux[2]),
    .mask(rgb_mux[2][0]),
    .de_out(de_mux[4]),
    .hsync_out(hsync_mux[4]),
    .vsync_out(vsync_mux[4]),
    .mask_new(filter_bin)
);

assign rgb_mux[4] = {filter_bin, filter_bin, filter_bin};

wire [10:0]x;
wire [10:0]y;

centroid #(
    .IMG_W(IMG_W),
    .IMG_H(IMG_H)
) center (
    .clk(clk),
    .ce(1'b1),
    .rst(1'b0),
    .de(de_mux[4]),
    .hsync(hsync_mux[4]),
    .vsync(vsync_mux[4]),
    .mask(rgb_mux[4][0]),
    .x(x),
    .y(y)
);

vis_centroid #(
    .IMG_W(IMG_W),
    .IMG_H(IMG_H)
) visualization (
    .clk(clk),
    .de_in(de_mux[4]),
    .hsync_in(hsync_mux[4]),
    .vsync_in(vsync_mux[4]),
    .pixel_in(rgb_mux[4]),
    .x(x),
    .y(y),
    .de_out(de_mux[5]),
    .hsync_out(hsync_mux[5]),
    .vsync_out(vsync_mux[5]),
    .pixel_out(rgb_mux[5])
);

vis_centroid_circle #(
    .IMG_W(IMG_W),
    .IMG_H(IMG_H)
) visualization_circle (
    .clk(clk),
    .de_in(de_mux[4]),
    .hsync_in(hsync_mux[4]),
    .vsync_in(vsync_mux[4]),
    .pixel_in(rgb_mux[4]),
    .x(x),
    .y(y),
    .de_out(de_mux[6]),
    .hsync_out(hsync_mux[6]),
    .vsync_out(vsync_mux[6]),
    .pixel_out(rgb_mux[6])
);

wire [10:0]x_min;
wire [10:0]x_max;
wire [10:0]y_min;
wire [10:0]y_max;

bounding_box # (
    .IMG_W(IMG_W),
    .IMG_H(IMG_H)
) bbox (
    .clk(clk),
    .ce(1'b1),
    .rst(1'b0),
    .de(de_mux[4]),
    .hsync(hsync_mux[4]),
    .vsync(vsync_mux[4]),
    .mask(rgb_mux[4][0]),
    .x_min(x_min),
    .x_max(x_max),
    .y_min(y_min),
    .y_max(y_max)
);

vis_bounding_box # (
    .IMG_W(IMG_W),
    .IMG_H(IMG_H)
) visualization_bbox (
    .clk(clk),
    .de_in(de_mux[4]),
    .hsync_in(hsync_mux[4]),
    .vsync_in(vsync_mux[4]),
    .pixel_in(rgb_mux[4]),
    .x(x),
    .y(y),
    .x_min(x_min),
    .x_max(x_max),
    .y_min(y_min),
    .y_max(y_max),
    .de_out(de_mux[7]),
    .hsync_out(hsync_mux[7]),
    .vsync_out(vsync_mux[7]),
    .pixel_out(rgb_mux[7])
);

wire [7:0] erosion_out;
wire [7:0] dilation_out;

median5x5 # (
    .H_SIZE(H_SIZE),
    .THRESHOLD(18)
) filter_erosion (
    .clk(clk),
    .de(de_mux[2]),
    .hsync(hsync_mux[2]),
    .vsync(vsync_mux[2]),
    .mask(rgb_mux[2][0]),
    .de_out(de_mux[8]),
    .hsync_out(hsync_mux[8]),
    .vsync_out(vsync_mux[8]),
    .mask_new(erosion_out)
);

assign rgb_mux[8] = {erosion_out, erosion_out, erosion_out};

median5x5 # (
    .H_SIZE(H_SIZE),
    .THRESHOLD(6)
) filter_dilation (
    .clk(clk),
    .de(de_mux[8]),
    .hsync(hsync_mux[8]),
    .vsync(vsync_mux[8]),
    .mask(rgb_mux[8][0]),
    .de_out(de_mux[9]),
    .hsync_out(hsync_mux[9]),
    .vsync_out(vsync_mux[9]),
    .mask_new(dilation_out)
);

assign rgb_mux[9] = {dilation_out, dilation_out, dilation_out};

wire [7:0] mean_Y;

mean3x3 #(
    .H_SIZE(H_SIZE)
) filter_mean_Y (
    .clk(clk),
    .de(de_mux[1]),
    .hsync(hsync_mux[1]),
    .vsync(vsync_mux[1]),
    .Y(rgb_mux[1][23:16]),
    .de_out(de_mux[10]),
    .hsync_out(hsync_mux[10]),
    .vsync_out(vsync_mux[10]),
    .Y_out(mean_Y)
);

assign rgb_mux[10] = {mean_Y, mean_Y, mean_Y};

wire [7:0]sobel_Y;

sobel # (
    .H_SIZE(H_SIZE)
) filter_sobel (
    .clk(clk),
    .de(de_mux[1]),
    .hsync(hsync_mux[1]),
    .vsync(vsync_mux[1]),
    .Y(rgb_mux[1][23:16]),
    
    .de_out(de_mux[11]),
    .hsync_out(hsync_mux[11]),
    .vsync_out(vsync_mux[11]),
    .Y_out(sobel_Y)
);

assign rgb_mux[11] = {sobel_Y, sobel_Y, sobel_Y};

assign pixel_out = rgb_mux[sw];
assign de_out = de_mux[sw];
assign hsync_out = hsync_mux[sw];
assign vsync_out = vsync_mux[sw];

endmodule
