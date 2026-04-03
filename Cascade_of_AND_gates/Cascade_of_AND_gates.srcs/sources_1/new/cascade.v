`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2026 17:14:03
// Design Name: 
// Module Name: cascade
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


module cascade #
(
    parameter LENGTH=8
)
(
    input [LENGTH-1:0]x,
    output y
);

wire [LENGTH:0]chain;
assign chain[0]=1'b1;

genvar i;
generate
    for(i=0;i<LENGTH;i=i+1)
    begin : and_gate
        assign chain[i+1] = x[i] & chain[i];
    end
endgenerate
assign y=chain[LENGTH];
endmodule
