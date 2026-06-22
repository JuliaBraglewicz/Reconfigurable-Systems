`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 18:25:28
// Design Name: 
// Module Name: mean3x3
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


module mean3x3# (
    parameter H_SIZE = 83
)(
    input clk,
    input de,
    input hsync,
    input vsync,
    input [7:0]Y,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [7:0]Y_out);

reg [10:0] D11, D12, D13;
reg [10:0] D21, D22, D23;
reg [10:0] D31, D32, D33;

wire [15:0] bram1_din;
wire [15:0] bram1_dout;

wire [15:0] bram2_din;
wire [15:0] bram2_dout;

delayLineBRAM_WP #(
    .WIDTH(16),
    .BRAM_SIZE_W(13)
) bram_line_1 (
    .clk(clk),
    .rst(1'b0),
    .ce(1'b1),
    .din(bram1_din),
    .dout(bram1_dout),
    .h_size(H_SIZE - 3)
);

delayLineBRAM_WP #(
    .WIDTH(16),
    .BRAM_SIZE_W(13)
) bram_line_2 (
    .clk(clk),
    .rst(1'b0),
    .ce(1'b1),
    .din(bram2_din),
    .dout(bram2_dout),
    .h_size(H_SIZE - 3)
);

assign bram1_din = {5'b0, D13};
assign bram2_din = {5'b0, D23};

wire [7:0] A = D13[10:3];
wire [7:0] B = D12[10:3];
wire [7:0] C = D11[10:3];
wire [7:0] D = D23[10:3];
wire [7:0] E = D22[10:3];
wire [7:0] F = D21[10:3];
wire [7:0] G = D33[10:3];
wire [7:0] H = D32[10:3];
wire [7:0] I = D31[10:3];

wire [7:0]  mult_A = A;
wire [8:0]  mult_B = {B, 1'b0};
wire [7:0]  mult_C = C;
wire [8:0]  mult_D = {D, 1'b0};
wire [9:0]  mult_E = {E, 2'b00};
wire [8:0]  mult_F = {F, 1'b0};
wire [7:0]  mult_G = G;
wire [8:0]  mult_H = {H, 1'b0};
wire [7:0]  mult_I = I;

reg [9:0]  sum_A_B;
reg [9:0]  sum_C_D;
reg [10:0] sum_E_F;
reg [8:0]  sum_G_I;

reg [10:0] sum_A_B_C_D;
reg [11:0] sum_E_F_G_H_I;

reg [11:0] sum;

reg context_valid_d1, context_valid_d2, context_valid_d3;
reg de_d1, de_d2, de_d3;
reg hsync_d1, hsync_d2, hsync_d3;
reg vsync_d1, vsync_d2, vsync_d3;

wire context_valid = D11[2] & D12[2] & D13[2] &
                     D21[2] & D22[2] & D23[2] &
                     D31[2] & D32[2] & D33[2];
                     
reg [7:0] pixel_d1;
reg [7:0] pixel_d2;
reg [7:0] pixel_d3;

always @(posedge clk) begin
    D11 <= {Y, de, hsync, vsync};
    D12 <= D11;
    D13 <= D12;

    D21 <= bram1_dout[10:0];
    D22 <= D21;
    D23 <= D22;

    D31 <= bram2_dout[10:0];
    D32 <= D31;
    D33 <= D32;

    sum_A_B <= {2'b00, mult_A} + {1'b0, mult_B};
    sum_C_D <= {2'b00, mult_C} + {1'b0, mult_D};
    sum_E_F <= {1'b0, mult_E}  + {2'b00, mult_F};
    sum_G_I <= {1'b0, mult_G}  + {1'b0, mult_I};

    sum_A_B_C_D <= {1'b0, sum_A_B} + {1'b0, sum_C_D};
    sum_E_F_G_H_I <= sum_E_F + {3'b000, mult_H} + {3'b000, sum_G_I};

    sum <= {1'b0, sum_A_B_C_D} + sum_E_F_G_H_I;

    context_valid_d1 <= context_valid;
    context_valid_d2 <= context_valid_d1;
    context_valid_d3 <= context_valid_d2;

    de_d1 <= D22[2];
    de_d2 <= de_d1;
    de_d3 <= de_d2;

    hsync_d1 <= D22[1];
    hsync_d2 <= hsync_d1;
    hsync_d3 <= hsync_d2;

    vsync_d1 <= D22[0];
    vsync_d2 <= vsync_d1;
    vsync_d3 <= vsync_d2;
    
    pixel_d1 <= D22[10:3];
    pixel_d2 <= pixel_d1;
    pixel_d3 <= pixel_d2;
end

wire [7:0] filtered_Y;

assign filtered_Y = sum[11:4];

assign Y_out = context_valid_d3 ? filtered_Y : pixel_d3;
assign de_out    = de_d3;
assign hsync_out = hsync_d3;
assign vsync_out = vsync_d3;

endmodule
