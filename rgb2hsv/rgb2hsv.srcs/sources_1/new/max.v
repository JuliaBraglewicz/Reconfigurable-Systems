`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2026 14:14:43
// Design Name: 
// Module Name: max
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


module max(
    input clk,
    input [9:0]r,
    input [9:0]g,
    input [9:0]b,
    output [9:0]max,
    output [1:0]pos
    );

reg [9:0]max_val;
reg [1:0]max_pos;

assign max = max_val;
assign pos = max_pos;
    
always @(posedge clk)
begin
    if (r >= g && r >= b)
    begin
        max_val <= r;
        max_pos <= 2'd0;
    end
    else if (g >= r && g >= b)
    begin
        max_val <= g;
        max_pos <= 2'd1;
    end
    else
    begin
        max_val <= b;
        max_pos <= 2'd2;
    end
end 
    
endmodule
