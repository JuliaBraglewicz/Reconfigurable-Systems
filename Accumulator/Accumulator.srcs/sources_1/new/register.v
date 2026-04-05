`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2026 12:22:19
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


module register(
    input clk,
    input rst,
    input ce,
    input [20:0]s,
    output [20:0]y
    );
    
reg [20:0]val = 21'b0;
    
always @(posedge clk)
begin
    if(rst) val <= 21'b0;
    else
        if(ce) val <= s;
        else val <= val;
end

assign y = val;

endmodule
