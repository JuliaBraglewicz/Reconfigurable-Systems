`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2026 12:45:39
// Design Name: 
// Module Name: accumulator
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


module accumulator(
    input clk,
    input rst,
    input ce,
    input [12:0]A,
    output [20:0]Y
    );
    
wire signed [20:0]s;
wire signed [20:0]y;
    
c_addsub_0 sum
(
    .CE(ce),
    .A(A),
    .B(y),
    .S(s)
);

register reg_1
(
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .s(s),
    .y(y)
);

assign Y = y;

endmodule
