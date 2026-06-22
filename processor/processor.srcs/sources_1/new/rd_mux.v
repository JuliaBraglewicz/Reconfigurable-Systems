`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 19:10:36
// Design Name: 
// Module Name: rd_mux
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


module rd_mux(
    input rd_op,
    input [7:0]alu_res,
    input [7:0]mem_data,
    output [7:0]rd_data
    );
    
assign rd_data = rd_op ? mem_data : alu_res;

endmodule
