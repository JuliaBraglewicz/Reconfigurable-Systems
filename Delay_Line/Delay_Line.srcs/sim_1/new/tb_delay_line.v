`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2026 20:17:19
// Design Name: 
// Module Name: tb_delay_line
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


module tb_delay_line
(
);

wire [7:0]idata;
wire [7:0]odata1;
wire [6:0]odata2;
wire [5:0]odata3;

reg clk=1'b0;
reg [7:0]cnt=8'b0;

delay_line #
(
    .N(8),
    .DELAY(0)
)
dut1
(
    .clk(clk),
    .idata(idata),
    .odata(odata1)
);

delay_line #
(
    .N(7),
    .DELAY(4)
)
dut2
(
    .clk(clk),
    .idata(idata),
    .odata(odata2)
);

delay_line #
(
    .N(6),
    .DELAY(5)
)
dut3
(
    .clk(clk),
    .idata(idata),
    .odata(odata3)
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

assign idata=cnt;

endmodule
