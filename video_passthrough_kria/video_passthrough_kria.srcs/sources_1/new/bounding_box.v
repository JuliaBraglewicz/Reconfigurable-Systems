`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 22:03:45
// Design Name: 
// Module Name: bounding_box
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


module bounding_box # (
    parameter IMG_W = 1920,
    parameter IMG_H = 1080
)
(
    input clk,
    input ce,
    input rst,
    input de,
    input  hsync,
    input vsync,
    input mask,
    output [10:0]x_min,
    output [10:0]x_max,
    output [10:0]y_min,
    output [10:0]y_max
    );

reg [10:0] x_pos = 0;
reg [10:0] y_pos = 0;

always @(posedge clk)
begin
    if (vsync)
    begin
        x_pos <= 0;
        y_pos <= 0;
    end
    else if (de)
    begin
        x_pos <= x_pos + 1;
        if (x_pos == IMG_W - 1)
        begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
            if (y_pos == IMG_H - 1)
            begin
                y_pos <= 0;
            end
        end
    end
end

wire eof;

reg prev_vsync = 0;

always @(posedge clk)
begin
    if (ce)
    begin
        prev_vsync <= vsync;
    end
end

assign eof = (prev_vsync == 1'b0 & vsync == 1'b1) ? 1'b1 : 1'b0;

reg [10:0] r_x_min = IMG_W - 1;
reg [10:0] r_x_max = 0;
reg [10:0] r_y_min = IMG_H - 1;
reg [10:0] r_y_max = 0;

always @(posedge clk) begin
    if (vsync) begin
        r_x_min <= IMG_W - 1;
        r_x_max <= 0;
        r_y_min <= IMG_H - 1;
        r_y_max <= 0;
    end else if (de && mask) begin
        if (x_pos < r_x_min) r_x_min <= x_pos;
        if (x_pos > r_x_max) r_x_max <= x_pos;
        if (y_pos < r_y_min) r_y_min <= y_pos;
        if (y_pos > r_y_max) r_y_max <= y_pos;
    end
end

reg [10:0] out_x_min = IMG_W - 1;
reg [10:0] out_x_max = 0;
reg [10:0] out_y_min = IMG_H - 1;
reg [10:0] out_y_max = 0;

always @(posedge clk) begin
    if (eof) begin
        out_x_min <= r_x_min;
        out_x_max <= r_x_max;
        out_y_min <= r_y_min;
        out_y_max <= r_y_max;
    end
end

assign x_min = out_x_min;
assign x_max = out_x_max;
assign y_min = out_y_min;
assign y_max = out_y_max;
    
endmodule
