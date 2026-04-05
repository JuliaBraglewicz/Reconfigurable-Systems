`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 20:54:37
// Design Name: 
// Module Name: indata
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


module indata(
    output [12:0]A,
    output [12:0]B
    );
    
reg [12:0]a = 13'b0;
reg [12:0]b = 13'b0;
    
initial
begin
    #2; a <= 13'b1111111111111; b <= 13'b1111111111111;
    #2; a <= 13'b0000000000000; b <= 13'b0000000000000;
    #2; a <= 13'b0111111111111; b <= 13'b0000000010000;
    #2; a <= 13'b1000000000000; b <= 13'b1111111110000;
    #2; a <= 13'b1111101011000; b <= 13'b1111010111100;
    #2; a <= 13'b0000000000001; b <= 13'b1111111111111;
    #2; a <= 13'b0000001011000; b <= 13'b0111111111111;
    #2; a <= 13'b1100000000000; b <= 13'b0011111110000;
    #2; $finish;
end

assign A = a;
assign B = b;

endmodule
