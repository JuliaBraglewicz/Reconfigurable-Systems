`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 14:39:00
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
    input [10:0]A,
    output [30:0]Y
    );
    
wire [30:0]s;
wire [30:0]y;
    
c_addsub_5 acc
(
    .CE(ce),
    .A(A),
    .B(y),
    .S(s)
);

acc_register reg_acc
(
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .s(s),
    .y(y)
);

assign Y = y;

endmodule
