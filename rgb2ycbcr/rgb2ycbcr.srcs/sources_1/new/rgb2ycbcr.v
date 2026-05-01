`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2026 11:01:14
// Design Name: 
// Module Name: rgb2ycbcr
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


module rgb2ycbcr(
    input clk,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0]pixel_in,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0]pixel_out
    );
    
wire signed [17:0]R;
wire signed [17:0]G;
wire signed [17:0]B;

assign R = {10'd0, pixel_in[23:16]};
assign G = {10'd0, pixel_in[15:8]}; 
assign B = {10'd0, pixel_in[7:0]};

reg [17:0]a11 = 18'b001001100100010111;
reg [17:0]a12 = 18'b010010110010001011;
reg [17:0]a13 = 18'b000011101001011110;
reg [17:0]a21 = 18'b111010100110011011;
reg [17:0]a22 = 18'b110101011001100101;
reg [17:0]a23 = 18'b010000000000000000;
reg [17:0]a31 = 18'b010000000000000000;
reg [17:0]a32 = 18'b110010100110100010;
reg [17:0]a33 = 18'b111101011001011110;

wire signed [35:0]P11;
wire signed [35:0]P12;
wire signed [35:0]P13;
wire signed [35:0]P21;
wire signed [35:0]P22;
wire signed [35:0]P23;
wire signed [35:0]P31;
wire signed [35:0]P32;
wire signed [35:0]P33;

wire signed [8:0]y_r;
wire signed [8:0]y_g;
wire signed [8:0]y_b;
wire signed [8:0]cb_r;
wire signed [8:0]cb_g;
wire signed [8:0]cb_b;
wire signed [8:0]cr_r;
wire signed [8:0]cr_g;
wire signed [8:0]cr_b;

assign y_r = P11[25:17];
assign y_g = P12[25:17];
assign y_b = P13[25:17];
assign cb_r = P21[25:17];
assign cb_g = P22[25:17];
assign cb_b = P23[25:17];
assign cr_r = P31[25:17];
assign cr_g = P32[25:17];
assign cr_b = P33[25:17];

wire signed [8:0]term_y_rg;
wire signed [8:0]term_y_rgb;
wire signed [8:0]Y;
wire signed [8:0]term_cb_rg;
wire signed [8:0]term_cb_rgb;
wire signed [8:0]Cb;
wire signed [8:0]term_cr_rg;
wire signed [8:0]term_cr_rgb;
wire signed [8:0]Cr;

reg [8:0]b1 = 9'b0;
reg [8:0]b23 = 9'b010000000;
    
mult_gen_0 mul_11(
    .CLK(clk),
    .A(a11),
    .B(R),
    .P(P11)
);

mult_gen_0 mul_12(
    .CLK(clk),
    .A(a12),
    .B(G),
    .P(P12)
);

mult_gen_0 mul_13(
    .CLK(clk),
    .A(a13),
    .B(B),
    .P(P13)
);

mult_gen_0 mul_21(
    .CLK(clk),
    .A(a21),
    .B(R),
    .P(P21)
);

mult_gen_0 mul_22(
    .CLK(clk),
    .A(a22),
    .B(G),
    .P(P22)
);

mult_gen_0 mul_23(
    .CLK(clk),
    .A(a23),
    .B(B),
    .P(P23)
);

mult_gen_0 mul_31(
    .CLK(clk),
    .A(a31),
    .B(R),
    .P(P31)
);

mult_gen_0 mul_32(
    .CLK(clk),
    .A(a32),
    .B(G),
    .P(P32)
);

mult_gen_0 mul_33(
    .CLK(clk),
    .A(a33),
    .B(B),
    .P(P33)
);

c_addsub_0 add_y1(
    .A(y_r),
    .B(y_g),
    .CLK(clk),
    .S(term_y_rg)
);

c_addsub_0 add_y2(
    .A(term_y_rg),
    .B(y_b),
    .CLK(clk),
    .S(term_y_rgb)
);

c_addsub_0 add_y3(
    .A(term_y_rgb),
    .B(b1),
    .CLK(clk),
    .S(Y)
);

c_addsub_0 add_cb1(
    .A(cb_r),
    .B(cb_g),
    .CLK(clk),
    .S(term_cb_rg)
);

c_addsub_0 add_cb2(
    .A(term_cb_rg),
    .B(cb_b),
    .CLK(clk),
    .S(term_cb_rgb)
);

c_addsub_0 add_cb3(
    .A(term_cb_rgb),
    .B(b23),
    .CLK(clk),
    .S(Cb)
);

c_addsub_0 add_cr1(
    .A(cr_r),
    .B(cr_g),
    .CLK(clk),
    .S(term_cr_rg)
);

c_addsub_0 add_cr2(
    .A(term_cr_rg),
    .B(cr_b),
    .CLK(clk),
    .S(term_cr_rgb)
);

c_addsub_0 add_cr3(
    .A(term_cr_rgb),
    .B(b23),
    .CLK(clk),
    .S(Cr)
);

delay_line
#(
    .N(3),
    .DELAY(6)
)
delay_sync
(
    .clk(clk),
    .idata({de_in, hsync_in, vsync_in}),
    .odata({de_out, hsync_out, vsync_out})
);

assign pixel_out = {Y[7:0], Cb[7:0], Cr[7:0]};

endmodule
