`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2026 10:16:54
// Design Name: 
// Module Name: modulo
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


module modulo #
(
    parameter N=6,
    parameter WIDTH = $clog2(N)
)
(
    input clk,
    input ce,
    input rst,
    output [WIDTH-1:0]cnt
);

reg [WIDTH-1:0]val=0;

always @(posedge clk)
begin
    if(rst) val<=0;
    else
    begin
        if(ce)
        begin
            if(val==N-1) val<=0;
            else val<=val+1;
        end
    end
end

assign cnt=val;

endmodule
