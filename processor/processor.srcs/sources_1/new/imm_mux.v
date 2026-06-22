`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 21:04:08
// Design Name: 
// Module Name: imm_mux
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


module imm_mux(
    input imm_op,
    input [7:0]ry,
    input [7:0]imm,
    output [7:0]ry_imm_data
    );
    
assign ry_imm_data = imm_op ? imm : ry;

endmodule
