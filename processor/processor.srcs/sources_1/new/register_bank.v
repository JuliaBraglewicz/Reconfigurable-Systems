`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 13:08:14
// Design Name: 
// Module Name: register_bank
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


module register_bank(
    input clk,
    input [6:0]ce,
    input [7:0]rd_data,
    input [7:0]pc_data,
    input  [7:0]gpi,
    output [7:0]gpo,
    output [7:0]pc_addr,
    output [7:0]r0,
    output [7:0]r1,
    output [7:0]r2,
    output [7:0]r3,
    output [7:0]r4,
    output [7:0]r5,
    output [7:0]r6,
    output [7:0]r7
    );
    
wire [7:0]r[7:0];
    
genvar i;
generate
    for(i=0;i<4;i=i+1)
    begin
        register reg_i
        (
            .clk(clk),
            .ce(ce[i]),
            .d(rd_data),
            .q(r[i])
        );
    end
endgenerate

register reg_4 (
    .clk(clk),
    .ce(ce[4]),
    .d(rd_data),
    .q(r[4])
);

assign gpo = r[4];

assign r[5] = gpi;

register reg_6
(
    .clk(clk),
    .ce(ce[6]),
    .d(8'h00),
    .q(r[6])
);

register reg_7
(
    .clk(clk),
    .ce(1'b1),
    .d(pc_data),
    .q(r[7])
);

assign r0 = r[0];
assign r1 = r[1];
assign r2 = r[2];
assign r3 = r[3];
assign r4 = r[4];
assign r5 = r[5];
assign r6 = r[6];
assign r7 = r[7];

assign pc_addr = r7;
    
endmodule
