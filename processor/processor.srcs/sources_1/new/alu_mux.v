`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 22:30:17
// Design Name: 
// Module Name: alu_mux
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


module alu_mux(
    input [1:0]alu_op,
    input [7:0]alu1,
    input [7:0]alu2,
    input [7:0]alu3,
    input [7:0]alu4,
    output [7:0]alu_res
    );
    
assign alu_res = (alu_op == 2'b00) ? alu1 :
                 (alu_op == 2'b01) ? alu2 :
                 (alu_op == 2'b10) ? alu3 :
                 (alu_op == 2'b11) ? alu4 : 8'b0;

endmodule
