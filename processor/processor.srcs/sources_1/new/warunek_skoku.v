`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 20:36:31
// Design Name: 
// Module Name: warunek_skoku
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


module warunek_skoku(
    input [1:0]pc_op,
    input cmp_res,
    output jump_con
    );
    
assign jump_con = (pc_op == 2'b01) ? 1'b1 :
                  (pc_op == 2'b10) ? ~cmp_res :
                  (pc_op == 2'b11) ? cmp_res : 1'b0;

endmodule
