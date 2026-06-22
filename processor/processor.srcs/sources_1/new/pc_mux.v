`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 19:22:07
// Design Name: 
// Module Name: pc_mux
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


module pc_mux(
    input [7:0]alu_res,
    input [7:0]addr_plus,
    input jump_con,
    output [7:0]pc_data
    );
    
assign pc_data = jump_con ? alu_res : addr_plus;
    
endmodule
