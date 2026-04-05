`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 14:43:15
// Design Name: 
// Module Name: tb_accumulator
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


module tb_accumulator(

    );

wire clk;
wire rst;
wire ce;
wire signed [12:0]A;
wire signed [20:0]Y;

stimulate st_i
(
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .A(A)
);

accumulator uut
(
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .A(A),
    .Y(Y)
);

endmodule
