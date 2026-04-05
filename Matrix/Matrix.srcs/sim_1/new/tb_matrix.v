`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 20:49:50
// Design Name: 
// Module Name: tb_matrix
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


module tb_matrix(

    );

wire signed [12:0]A;
wire signed [12:0]B;
wire signed [31:0]Y;
wire signed [31:0]Z;

indata in_i
(
    .A(A),
    .B(B)
);
    
matrix uut
(
    .A(A),
    .B(B),
    .Y(Y),
    .Z(Z)
);

verify v_i
(
    .Y(Y),
    .Z(Z)
);

endmodule
