`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 16:35:20
// Design Name: 
// Module Name: stimulate
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


module stimulate(
    output clk,
    output rst,
    output ce,
    output [12:0]A
    );
    
reg r_clk = 1'b0;
reg r_ce = 1'b0;
reg r_rst = 1'b0;
reg [12:0]a = 13'b0;

initial
begin
    while(1)
    begin
        #1; r_clk = 1'b0;
        #1; r_clk = 1'b1;
    end
end

initial
begin
    #5; r_ce = 1'b1;
    @(posedge clk);
    a <= 13'b0001010101111;
    @(posedge clk);
    a <= 13'b0000110111001;
    @(posedge clk);
    a <= 13'b1111111101011;
    @(posedge clk);
    a <= 13'b1111110011001;
    @(posedge clk);
    a <= 13'b1111110101011;
    @(posedge clk);
    a <= 13'b1111011001010;
    @(posedge clk);
    a <= 13'b0000000001110; 
    @(posedge clk);
    a <= 13'b0000000010001;
    @(posedge clk);
    a <= 13'b0000111111100;
    @(posedge clk);
    a <= 13'b0000111011000;
    @(posedge clk);
    r_ce <= 1'b0;
    #5; r_rst <= 1'b1;
    #5; $finish;
end

assign clk = r_clk;
assign rst = r_rst;
assign ce = r_ce;
assign A = a;

endmodule
