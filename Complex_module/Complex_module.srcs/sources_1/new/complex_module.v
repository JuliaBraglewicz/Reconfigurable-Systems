`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2026 18:58:00
// Design Name: 
// Module Name: complex_module
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


module complex_module(
    input clk,
    input ce,
    input [17:0]A,
    input [7:0]B,
    input [11:0]C,
    input [7:0]D,
    input [13:0]E,
    input [18:0]F,
    output [36:0]Y
    );
    
wire signed [12:0]b;
wire signed [10:0]d;
wire signed [17:0]e;
wire signed [18:0]s1;
wire signed [14:0]s2;
wire signed [19:0]s3;
wire signed [36:0]s4;
wire signed [11:0]C_delayed;
wire signed [30:0]p1;
wire signed [34:0]p2;
wire signed [35:0]p3;

assign b={B,5'b0};
assign d={D,3'b0};
assign e={E,4'b0};
assign p3={p2,1'b0};

c_addsub_0 adder_1 //latencja 2
(
    .CLK(clk),
    .CE(ce),
    .A(A),
    .B(b),
    .S(s1)
);

delay_line # (
    .N(12),
    .DELAY(2)
)
delay (
    .clk(clk),
    .idata(C),
    .odata(C_delayed)
);

mult_gen_0 mul_1 //latencja 3
(
    .CLK(clk),
    .CE(ce),
    .A(s1),
    .B(C_delayed),
    .P(p1)
);

c_addsub_1 adder_2 //latencja 2
(
    .CLK(clk),
    .CE(ce),
    .A(d),
    .B(E),
    .S(s2)
);

c_addsub_2 adder_3 //latencja 2
(
    .CLK(clk),
    .CE(ce),
    .A(e),
    .B(F),
    .S(s3)
);

mult_gen_1 mul_2 //latencja 3
(
    .CLK(clk),
    .CE(ce),
    .A(s2),
    .B(s3),
    .P(p2)
);

c_addsub_3 adder_4 //latencja 2
(
    .CLK(clk),
    .CE(ce),
    .A(p1),
    .B(p3),
    .S(s4)
);

assign Y=s4;

endmodule
