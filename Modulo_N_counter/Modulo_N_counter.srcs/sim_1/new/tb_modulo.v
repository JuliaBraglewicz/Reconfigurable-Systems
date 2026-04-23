`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2026 10:18:08
// Design Name: 
// Module Name: tb_modulo
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


module tb_modulo(

    );

wire [2:0]cnt1;
wire [3:0]cnt2;

reg clk=1'b0;
reg ce=1'b0;
reg rst=1'b0;

modulo #
(
    .N(6)
)
dut1
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .cnt(cnt1)
);

modulo #
(
    .N(9)
)
dut2
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .cnt(cnt2)
);

initial
begin
    while(1)
    begin
        #1; clk=1'b0;
        #1; clk=1'b1;
    end
end

initial
begin
    while(1)
    begin
        #10; ce=1'b0;rst=1'b0;
        #10; ce=1'b0;rst=1'b1;
        #10; ce=1'b1;rst=1'b0;
        #20; ce=1'b0;rst=1'b0;
        #10; ce=1'b1;rst=1'b1;
    end
end
endmodule
