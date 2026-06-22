`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 15:03:55
// Design Name: 
// Module Name: acc_register
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


module acc_register(
    input clk,
    input rst,
    input ce,
    input [30:0]s,
    output [30:0]y
    );
    
reg [30:0]val = 31'b0;
    
always @(posedge clk)
begin
    if(rst) val <= 31'b0;
    else
        if(ce) val <= s;
        else val <= val;
end

assign y = val;

endmodule
