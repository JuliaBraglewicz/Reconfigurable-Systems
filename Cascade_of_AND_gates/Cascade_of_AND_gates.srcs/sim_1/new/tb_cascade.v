`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2026 17:15:00
// Design Name: 
// Module Name: tb_cascade
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


module tb_cascade(
);

wire [7:0]x;
wire y;

reg clk=1'b0;
reg [7:0]cnt=8'b0;

cascade dut
(
    .x(x),
    .y(y)
);

initial
begin
    while(1)
    begin
        #1; clk=1'b0;
        #1; clk=1'b1;
    end
end

always @(posedge clk)
begin
    cnt<=cnt+1;
end

assign x=cnt;

endmodule
