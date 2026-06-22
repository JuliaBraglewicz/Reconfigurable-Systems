`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 13:53:39
// Design Name: 
// Module Name: decoder
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


module decoder(
    input [2:0]d_op,
    output [6:0]ce
    );

reg [6:0]r_ce = 7'b0;

always @(*) begin
    r_ce = 7'b0;
    if (d_op <= 3'd6) r_ce[d_op] = 1'b1;
end

assign ce = r_ce;
    
endmodule
