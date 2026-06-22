`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 19:08:59
// Design Name: 
// Module Name: regi
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


module regi #
(
    parameter N=8
)
(
    input clk,
    input [N-1:0]d,
    output [N-1:0]q
);

reg [N-1:0]val=8'b0;

always @(posedge clk)
begin
    val<=d;
end

assign q=val;
endmodule
