`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 20:00:58
// Design Name: 
// Module Name: vis_centroid_circle
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


module vis_centroid_circle # (
    parameter IMG_W = 1920,
    parameter IMG_H = 1080
)(
    input clk,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0] pixel_in,
    input [10:0] x,
    input [10:0] y,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0] pixel_out
    );

reg [10:0] x_pos = 0;
reg [10:0] y_pos = 0;

always @(posedge clk)
begin
    if (vsync_in)
    begin
        x_pos <= 0;
        y_pos <= 0;
    end
    else if (de_in)
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

wire [7:0] i_red;
wire [7:0] i_green;
wire [7:0] i_blue;

assign i_red   = pixel_in[23:16];
assign i_green = pixel_in[15:8];
assign i_blue  = pixel_in[7:0];

wire [7:0] o_red;
wire [7:0] o_green;
wire [7:0] o_blue;

wire [10:0]dx;
wire [10:0]dy;

assign dx = (x_pos > x) ? (x_pos - x) : (x - x_pos);
assign dy = (y_pos > y) ? (y_pos - y) : (y - y_pos);

reg circle;

always @(*)
begin
    circle = 1'b0;
    if (dx < 4 && dy < 4) begin
        if((dx + dy) <= 4) begin
            circle = 1'b1;
        end
    end
end

assign o_red = (circle ? 8'hff : i_red);
assign o_green = (circle ? 8'h00 : i_green);
assign o_blue  = (circle ? 8'h00 : i_blue);

assign pixel_out = {o_red, o_green, o_blue};
assign de_out = de_in;
assign hsync_out = hsync_in;
assign vsync_out = vsync_in;
    
endmodule

