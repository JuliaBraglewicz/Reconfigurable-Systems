`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 13:23:41
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input  clk50,
    output clk_out
);

reg [19:0] counter = 20'd0;
reg clk_div = 1'b0;

always @(posedge clk50) begin
    if (counter == 20'd499_999) begin
        counter <= 20'd0;
        clk_div <= ~clk_div;
    end else begin
        counter <= counter + 1;
    end
end

assign clk_out = clk_div;

endmodule
