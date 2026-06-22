`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2026 10:12:19
// Design Name: 
// Module Name: rgb2hsv
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


module rgb2hsv(
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
    
wire [7:0]R;
wire [7:0]G;
wire [7:0]B;
    
assign R = pixel_in[23:16];
assign G = pixel_in[15:8]; 
assign B = pixel_in[7:0];

wire [15:0]dout_r;
wire [15:0]dout_g;
wire [15:0]dout_b;

wire [7:0]q_r;
wire [7:0]f_r;
wire [7:0]q_g;
wire [7:0]f_g;
wire [7:0]q_b;
wire [7:0]f_b;

wire valid_r;
wire valid_g;
wire valid_b;
    
div_gen_0 div_R ( //latency 18
    .aclk(clk),
    .s_axis_divisor_tvalid(1'b1),
    .s_axis_divisor_tdata(8'd255),
    .s_axis_dividend_tvalid(de_in),
    .s_axis_dividend_tdata(R),
    .m_axis_dout_tvalid(valid_r),
    .m_axis_dout_tdata(dout_r)
);
    
assign q_r = dout_r[15:8];
assign f_r = dout_r[7:0];
    
wire signed [9:0] r_01;
assign r_01[9] = 1'b0; // bit znaku - tu na 0
assign r_01[8] = q_r[0]; // czesc calkowita wyniku
assign r_01[7:0] = f_r; // czesc ulamkowa wyniku

div_gen_0 div_G ( //latency 18
    .aclk(clk),
    .s_axis_divisor_tvalid(1'b1),
    .s_axis_divisor_tdata(8'd255),
    .s_axis_dividend_tvalid(de_in),
    .s_axis_dividend_tdata(G),
    .m_axis_dout_tvalid(valid_g),
    .m_axis_dout_tdata(dout_g)
);
    
assign q_g = dout_g[15:8];
assign f_g = dout_g[7:0];
    
wire signed [9:0] g_01;
assign g_01[9] = 1'b0; // bit znaku - tu na 0
assign g_01[8] = q_g[0]; // czesc calkowita wyniku
assign g_01[7:0] = f_g; // czesc ulamkowa wyniku

div_gen_0 div_B ( //latency 18
    .aclk(clk),
    .s_axis_divisor_tvalid(1'b1),
    .s_axis_divisor_tdata(8'd255),
    .s_axis_dividend_tvalid(de_in),
    .s_axis_dividend_tdata(B),
    .m_axis_dout_tvalid(valid_b),
    .m_axis_dout_tdata(dout_b)
);
    
assign q_b = dout_b[15:8];
assign f_b = dout_b[7:0];
    
wire signed [9:0] b_01;
assign b_01[9] = 1'b0; // bit znaku - tu na 0
assign b_01[8] = q_b[0]; // czesc calkowita wyniku
assign b_01[7:0] = f_b; // czesc ulamkowa wyniku

wire signed [9:0]V_res;
wire signed [9:0]min;
wire [1:0]pos_max;
wire [1:0]pos_min;

max maximum ( // latency 1
    .clk(clk),
    .r(r_01),
    .g(g_01),
    .b(b_01),
    .max(V_res),
    .pos(pos_max)
    
);

min minimum ( // latency 1
    .clk(clk),
    .r(r_01),
    .g(g_01),
    .b(b_01),
    .min(min),
    .pos(pos_min)
);

wire signed [10:0]C;
wire signed [9:0]V_del_S;

c_addsub_4 sub ( //latency 2
    .A(V_res),
    .B(min),
    .CLK(clk),
    .S(C)
);

delay  # (
    .N(10),
    .DELAY(2)
) delay_V (
    .clk(clk),
    .idata(V_res),
    .odata(V_del_S)
);

wire valid_S;

wire [23:0]dout_S;

div_gen_1 div_S ( // latency 22
    .aclk(clk),
    .s_axis_divisor_tvalid(1'b1),
    .s_axis_divisor_tdata(V_del_S),
    .s_axis_dividend_tvalid(1'b1),
    .s_axis_dividend_tdata(C),
    .m_axis_dout_tvalid(valid_S),
    .m_axis_dout_tdata(dout_S)
);

wire signed [9:0]S_01;
wire [9:0]S_01_q;
wire [8:0]S_01_f;

assign S_01_q = dout_S[18:9];
assign S_01_f = dout_S[8:0];

assign S_01 = (V_del_S > 0) ? {S_01_q[0], S_01_f[8:1]} : 10'd0;

// H

wire signed [9:0]r_01_del;
wire signed [9:0]g_01_del;
wire signed [9:0]b_01_del;

delay  # ( 
    .N(10),
    .DELAY(1)
) delay_r (
    .clk(clk),
    .idata(r_01),
    .odata(r_01_del)
);

delay  # (
    .N(10),
    .DELAY(1)
) delay_g (
    .clk(clk),
    .idata(g_01),
    .odata(g_01_del)
);

delay  # (
    .N(10),
    .DELAY(1)
) delay_b (
    .clk(clk),
    .idata(b_01),
    .odata(b_01_del)
);

reg [9:0]A1;
reg [9:0]A2;

always @(*)
begin
    case(pos_max)
    2'b00:
    begin
        A1 = g_01_del;
        A2 = b_01_del;
    end
    2'b01:
    begin
        A1 = b_01_del;
        A2 = r_01_del;
    end
    2'b10:
    begin
        A1 = r_01_del;
        A2 = g_01_del;
    end
    endcase
end

wire signed [10:0]A1_A2;

c_addsub_1 sub_A1_A2 ( // latency 2
    .A(A1),
    .B(A2),
    .CLK(clk),
    .S(A1_A2)
);

wire valid_A1_A2_c;
wire [23:0]dout_A1_A2_c;

div_gen_2 div_C ( //latency 25
    .aclk(clk),
    .s_axis_divisor_tvalid(1'b1),
    .s_axis_divisor_tdata(C),
    .s_axis_dividend_tvalid(1'b1),
    .s_axis_dividend_tdata(A1_A2),
    .m_axis_dout_tvalid(valid_A1_A2_c),
    .m_axis_dout_tdata(dout_A1_A2_c)
);

wire signed [10:0]res_A1_A2_c_q;
wire signed [9:0]res_A1_A2_c_f;

assign res_A1_A2_c_q = dout_A1_A2_c[20:10];
assign res_A1_A2_c_f = dout_A1_A2_c[9:0];

wire signed [10:0] res_A1_A2_c;
assign res_A1_A2_c[10] = (res_A1_A2_c_q[10] | res_A1_A2_c_f[9]); // bit znaku
assign res_A1_A2_c[9] = (res_A1_A2_c_f[9] == 1'b0 & res_A1_A2_c_q[10] == 1'b0) ? 1'b0 : 1'b1; // bit calkowity
assign res_A1_A2_c[8] = (res_A1_A2_c_f[9] == 1'b0 & res_A1_A2_c_q[0] == 1'b0) ? res_A1_A2_c_q[0] : 1'b1; // bit calkowity
assign res_A1_A2_c[7:0] = res_A1_A2_c_f[8:1]; // bity ulamkowe

reg [5:0]val_60 = 6'd60;
wire signed [17:0]A1_A2_c_60;

mult_gen_2 mult_60 ( // latency 3
    .CLK(clk),
    .A(val_60),
    .B(res_A1_A2_c),
    .P(A1_A2_c_60)
);

wire [1:0]pos_max_del;

delay  # (
    .N(2),
    .DELAY(30)
) delay_pos_max (
    .clk(clk),
    .idata(pos_max),
    .odata(pos_max_del)
);

reg [16:0]H_off;

always @(*)
begin
    case(pos_max_del)
    2'b00:
    begin
        H_off = {1'd0, 8'd0, 8'd0};
    end
    2'b01:
    begin
        H_off = {1'd0, 8'd120, 8'd0};
    end
    2'b10:
    begin
        H_off = {1'd0, 8'd240, 8'd0};
    end
    endcase
end

wire signed [18:0]res_H;

c_addsub_2 add_H_off ( //latency 2
    .A(A1_A2_c_60),
    .B(H_off),
    .CLK(clk),
    .S(res_H)
);

reg [16:0]val_360 = {9'd360, 8'b0};
wire signed [19:0]H_360;
wire signed [18:0]H_del;

c_addsub_3 add_360 ( // latency 2
    .A(res_H),
    .B(val_360),
    .CLK(clk),
    .S(H_360)
);

delay  # (
    .N(19),
    .DELAY(2)
) delay_H (
    .clk(clk),
    .idata(res_H),
    .odata(H_del)
);

wire [10:0]C_del;

delay  # (
    .N(11),
    .DELAY(32)
) delay_C (
    .clk(clk),
    .idata(C),
    .odata(C_del)
);

wire [18:0]H_0360;

assign H_0360 = (C_del == 11'd0) ? 19'd0 : 
                (H_del[18] == 1'b1) ? H_360[18:0] : H_del;
                
wire valid_H;
wire [39:0]dout_H;
                
div_gen_3 div_360 ( // latency 38
    .aclk(clk),
    .s_axis_divisor_tvalid(1'b1),
    .s_axis_divisor_tdata({9'd360, 8'b0}),
    .s_axis_dividend_tvalid(1'b1),
    .s_axis_dividend_tdata(H_0360),
    .m_axis_dout_tvalid(valid_H),
    .m_axis_dout_tdata(dout_H)
);

wire [22:0]H_q;
wire [16:0]H_f;

assign H_q = dout_H[39:17];
assign H_f = dout_H[16:0];
    
wire signed [9:0] H_01;
assign H_01[9] = 1'b0;
assign H_01[8] = H_q[0];
assign H_01[7:0] = H_f[16:9];

wire signed [9:0]V_del_255;
wire signed [9:0]S_del_255;

delay  # (
    .N(10),
    .DELAY(72)
) delay_V_255 (
    .clk(clk),
    .idata(V_res),
    .odata(V_del_255)
);

delay  # (
    .N(10),
    .DELAY(48)
) delay_S_255 (
    .clk(clk),
    .idata(S_01),
    .odata(S_del_255)
);

reg [7:0] val_255 = 8'd255;

wire signed [18:0]V_255;
wire signed [18:0]S_255;
wire signed [18:0]H_255;

mult_gen_3 mult_V ( // latency 3
    .CLK(clk),
    .A(V_del_255),
    .B(val_255),
    .P(V_255)
);

mult_gen_3 mult_S ( // latency 3
    .CLK(clk),
    .A(S_del_255),
    .B(val_255),
    .P(S_255)
);

mult_gen_3 mult_H ( // latency 3
    .CLK(clk),
    .A(H_01),
    .B(val_255),
    .P(H_255)
);

wire [7:0]H;
wire [7:0]S;
wire [7:0]V;

assign H = H_255[15:8];
assign S = S_255[15:8];
assign V = V_255[15:8];

assign pixel_out = {H, S, V};

delay # (
    .N(1),
    .DELAY(94)
) delay_de (
    .clk(clk),
    .idata(de_in),
    .odata(de_out)
);

delay # (
    .N(1),
    .DELAY(94)
) delay_hsync (
    .clk(clk),
    .idata(hsync_in),
    .odata(hsync_out)
);

delay # (
    .N(1),
    .DELAY(94)
) delay_vsync (
    .clk(clk),
    .idata(vsync_in),
    .odata(vsync_out)
);

endmodule
