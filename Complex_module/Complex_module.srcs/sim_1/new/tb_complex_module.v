`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2026 19:07:06
// Design Name: 
// Module Name: tb_complex_module
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


module tb_complex_module(
);

wire signed [17:0]A;
wire signed [7:0]B;
wire signed [11:0]C;
wire signed [7:0]D;
wire signed [13:0]E;
wire signed [18:0]F;
wire clk;
wire ce;
wire signed [36:0]Y;

signals sg_i
(
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .F(F),
    .clk(clk),
    .ce(ce)
);

complex_module uut
(
    .clk(clk),
    .ce(ce),
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .F(F),
    .Y(Y)
);

endmodule
