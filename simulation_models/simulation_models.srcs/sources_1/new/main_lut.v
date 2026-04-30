`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2026 13:10:18
// Design Name: 
// Module Name: main_lut
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


module main_lut(
    input clk,
    input [7:0]addra,
    output [7:0]douta
    );
    
blk_mem_gen_0 LUT (
    .clka(clk),
    .addra(addra),
    .douta(douta)
);
    
endmodule
