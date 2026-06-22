`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2026 14:48:10
// Design Name: 
// Module Name: tb_rgb2hsv
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


module tb_rgb2hsv(

    );
    
reg clk = 1'b0;
reg de_in = 1'b0;
reg hsync_in = 1'b0;
reg vsync_in = 1'b0;
reg [23:0]pixel_in = 24'b0;

wire de_out;
wire hsync_out;
wire vsync_out;
wire [23:0]pixel_out;

rgb2hsv uut (
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

initial
begin
    while(1)
    begin
        #5; clk=1'b0;
        #5; clk=1'b1;
    end
end

initial
begin
    #20;
    de_in<=1'b1;
    pixel_in<={8'd100, 8'd150, 8'd200};
    #10;
    pixel_in<={8'd200, 8'd100, 8'd150};
    #10;
    pixel_in<={8'd150, 8'd200, 8'd100};
    #10;
    pixel_in<={8'd123, 8'd231, 8'd312};
    #1000;
    $finish;
end
    
endmodule
