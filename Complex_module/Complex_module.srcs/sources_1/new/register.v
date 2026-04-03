`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2026 22:40:47
// Design Name: 
// Module Name: register
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


module register #
(
    parameter N=12
)
(
    input clk,
    input [N-1:0]d,
    output [N-1:0]q
);

reg [N-1:0]val=12'b0;

always @(posedge clk)
begin
    val<=d;
end

assign q=val;
endmodule
