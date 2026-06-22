`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2026 14:16:22
// Design Name: 
// Module Name: min
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


module min(
    input clk,
    input [9:0]r,
    input [9:0]g,
    input [9:0]b,
    output [9:0]min,
    output [1:0]pos
    );

reg [9:0]min_val;
reg [1:0]min_pos;

assign min = min_val;
assign pos = min_pos;
    
always @(posedge clk)
begin
    if (r <= g && r <= b)
    begin
        min_val <= r;
        min_pos <= 2'd0;
    end
    else if (g <= r && g <= b)
    begin
        min_val <= g;
        min_pos <= 2'd1;
    end
    else
    begin
        min_val <= b;
        min_pos <= 2'd2;
    end
end 

endmodule
