`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2026 23:01:03
// Design Name: 
// Module Name: signals
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


module signals(
    output clk,
    output ce,
    output [17:0]A,
    output [7:0]B,
    output [11:0]C,
    output [7:0]D,
    output [13:0]E,
    output [18:0]F
);

reg r_clk = 1'b0;
reg r_ce = 1'b0;
reg [17:0]a = 18'b0;
reg [7:0]b = 8'b0;
reg [11:0]c = 12'b0;
reg [7:0]d = 8'b0;
reg [13:0]e = 14'b0;
reg [18:0]f = 19'b0;

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
    #5;
    r_ce <= 1'b1;
    @(posedge clk);
    a <= 18'b111001101110101001;
    b <= 8'b00111011;
    c <= 12'b110110001010;
    d <= 8'b00100100;
    e <= 14'b11001110000000;
    f <= 19'b0010000110100011111;
    @(posedge clk);
    a <= 18'b111111010111110111;
    b <= 8'b01111111;
    c <= 12'b100000000000;
    d <= 8'b01111111;
    e <= 14'b11111011000000;
    f <= 19'b0000001101011101001;
    @(posedge clk);
    a <= 18'b000110010001100110;
    b <= 8'b11000011;
    c <= 12'b011111111111;
    d <= 8'b10000000;
    e <= 14'b00101100010111;
    f <= 19'b1111011101011100001;
    @(posedge clk);
    a <= 18'b111001000011100100;
    b <= 8'b11101110;
    c <= 12'b111001010110;
    d <= 8'b00010010;
    e <= 14'b00011011110010;
    f <= 19'b0001000010101010010;
    #20; $finish;
end

assign A = a;
assign B = b;
assign C = c;
assign D = d;
assign E = e;
assign F = f;
assign clk = r_clk;
assign ce = r_ce;

endmodule
