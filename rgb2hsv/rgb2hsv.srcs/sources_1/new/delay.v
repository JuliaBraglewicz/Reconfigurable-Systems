`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 19:05:46
// Design Name: 
// Module Name: delay
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


module delay #
(
    parameter N=8,
    parameter DELAY=5
)

(
    input clk,
    input [N-1:0]idata,
    output [N-1:0]odata
);

wire [N-1:0] tdata [DELAY:0];
assign tdata[0]=idata;

genvar i;
generate
    for(i=0;i<DELAY;i=i+1)
    begin
    regi #
    (
        .N(N)
    )
    reg_i
    (
        .clk(clk),
        .d(tdata[i]),
        .q(tdata[i+1])
    );
    end
endgenerate
assign odata=tdata[DELAY];
endmodule
