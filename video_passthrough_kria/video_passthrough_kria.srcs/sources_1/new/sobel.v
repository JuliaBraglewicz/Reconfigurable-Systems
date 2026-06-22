`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 20:43:57
// Design Name: 
// Module Name: sobel
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


module sobel# (
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
    output [7:0]Y_out
);

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

reg signed [11:0] gx_stage1;
reg signed [11:0] gy_stage1;
    
reg [10:0] abs_gx;
reg [10:0] abs_gy;
    
reg [11:0] sobel_sum;

reg context_valid_d1, context_valid_d2, context_valid_d3;
reg de_d1, de_d2, de_d3;
reg hsync_d1, hsync_d2, hsync_d3;
reg vsync_d1, vsync_d2, vsync_d3;

wire context_valid = D11[2] & D12[2] & D13[2] &
                     D21[2] & D22[2] & D23[2] &
                     D31[2] & D32[2] & D33[2];

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

    gx_stage1 <= ($signed({1'b0, C}) - $signed({1'b0, A})) + 
                 (($signed({1'b0, F}) - $signed({1'b0, D})) << 1) + 
                 ($signed({1'b0, I}) - $signed({1'b0, G}));

    gy_stage1 <= ($signed({1'b0, C}) - $signed({1'b0, G})) + 
                 (($signed({1'b0, B}) - $signed({1'b0, H})) << 1) + 
                 ($signed({1'b0, A}) - $signed({1'b0, I}));

    abs_gx <= (gx_stage1 < 0) ? -gx_stage1 : gx_stage1;
    abs_gy <= (gy_stage1 < 0) ? -gy_stage1 : gy_stage1;

    sobel_sum <= abs_gx + abs_gy;

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
end

wire [7:0] sobel_scaled = sobel_sum[10:3];

assign Y_out     = context_valid_d3 ? sobel_scaled : 8'd0;
assign de_out    = de_d3;
assign hsync_out = hsync_d3;
assign vsync_out = vsync_d3;

endmodule
