`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 19:40:17
// Design Name: 
// Module Name: matrix
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


module matrix(
    input [12:0]A,
    input [12:0]B,
    output [31:0]Y,
    output [31:0]Z
    );
    
reg [17:0]m [3:0];
wire signed [30:0]p [3:0];
wire signed [31:0]s [1:0];

initial
begin
    m[0] = 18'b111111110001111011;
    m[1] = 18'b000100100110011010;
    m[2] = 18'b000110010001111011;
    m[3] = 18'b101001100000000000;
end

genvar i;
generate
    for(i=0;i<4;i=i+1)
    begin
        mult_gen_0 mul_i
        (
            .A(m[i]),
            .B((i % 2 == 0) ? A : B),
            .P(p[i])
        );
    end
endgenerate

c_addsub_0 adder_Y
(
    .A(p[0]),
    .B(p[1]),
    .S(s[0])
);

c_addsub_0 adder_Z
(
    .A(p[2]),
    .B(p[3]),
    .S(s[1])
);

assign Y = s[0];
assign Z = s[1];

endmodule
