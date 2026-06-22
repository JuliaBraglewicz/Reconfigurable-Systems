`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 13:01:59
// Design Name: 
// Module Name: centroid
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


module centroid # (
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
    output [10:0]x,
    output [10:0]y
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

reg [20:0] m00;

always @(posedge clk)
begin
    if (eof)
    begin
        m00 <= 0;
    end
    else if (ce && de && mask)
    begin
        m00 <= m00 + 1;
    end
end

wire [30:0] m10;
wire [30:0] m01;

accumulator acc_m10 (
    .clk(clk),
    .rst(eof),
    .ce(mask & de),
    .A(x_pos),
    .Y(m10)
);

accumulator acc_m01 (
    .clk(clk),
    .rst(eof),
    .ce(mask & de),
    .A(y_pos),
    .Y(m01)
);

reg [10:0]x_center = 11'b0;
reg [10:0]y_center = 11'b0;

wire [31:0] quotient_x;
wire [31:0] quotient_y;
wire qv_x;
wire qv_y;

divider_32_21_0 div_x( // latency 4
    .clk(clk),
    .start(eof),
    .dividend({1'b0, m10}),
    .divisor(m00),
    .quotient(quotient_x),
    .qv(qv_x)
);

divider_32_21_0 div_y( // latency 4
    .clk(clk),
    .start(eof),
    .dividend({1'b0, m01}),
    .divisor(m00),
    .quotient(quotient_y),
    .qv(qv_y)
);

always @(posedge clk) begin
    if (qv_x)
    begin
        x_center <= quotient_x[10:0];
    end
    
    if (qv_y)
    begin
        y_center <= quotient_y[10:0];
    end
end

assign x = x_center;
assign y = y_center;
    
endmodule
