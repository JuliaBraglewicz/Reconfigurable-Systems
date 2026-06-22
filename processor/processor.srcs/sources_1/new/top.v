`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 13:17:55
// Design Name: 
// Module Name: top
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


module top(
    input clk50,
    input [3:0] sw,
    output [3:0] led
);

wire clk_slow;

clk_divider u_divider(
    .clk50(clk50),
    .clk_out(clk_slow)
);

wire [7:0] gpi;
wire [7:0] gpo;

assign gpi = {4'b0000, sw};

processor u_processor(
    .clk(clk_slow),
    .gpi(gpi),
    .gpo(gpo)
);

assign led = gpo[3:0];

endmodule
