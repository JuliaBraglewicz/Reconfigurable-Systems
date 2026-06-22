`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 22:18:30
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [7:0]rx,
    input [7:0]ry_imm_data,
    output [7:0]alu1,
    output [7:0]alu2,
    output [7:0]alu3,
    output [7:0]alu4
    );

assign alu1 = rx & ry_imm_data;
assign alu2 = rx + ry_imm_data;
assign alu3 = (rx == 8'b0) ? 8'd1 : 8'd0;
assign alu4 = ry_imm_data;

endmodule
