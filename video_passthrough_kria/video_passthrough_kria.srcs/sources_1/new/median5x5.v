`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 13:26:17
// Design Name: 
// Module Name: median5x5
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


module median5x5 # (
    parameter H_SIZE = 83,
    parameter THRESHOLD = 12
)(
    input clk,
    input de,
    input hsync,
    input vsync,
    input mask,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [7:0]mask_new
    );
    
reg [3:0] D11, D12, D13, D14, D15;
reg [3:0] D21, D22, D23, D24, D25;
reg [3:0] D31, D32, D33, D34, D35;
reg [3:0] D41, D42, D43, D44, D45;
reg [3:0] D51, D52, D53, D54, D55;

wire [15:0] bram_din;
wire [15:0] bram_dout;

delayLineBRAM_WP #(
    .WIDTH(16),
    .BRAM_SIZE_W(13)
) single_bram_delay_line (
    .clk(clk),
    .rst(1'b0),
    .ce(1'b1),
    .din(bram_din),
    .dout(bram_dout),
    .h_size(H_SIZE - 5)
);

reg [2:0] sum_r1, sum_r2, sum_r3, sum_r4, sum_r5;
reg [4:0] sum;

reg context_valid_d1, context_valid_d2;
reg de_d1, de_d2;
reg hsync_d1, hsync_d2;
reg vsync_d1, vsync_d2;

wire context_valid = D11[2] & D12[2] & D13[2] & D14[2] & D15[2] & 
                     D21[2] & D22[2] & D23[2] & D24[2] & D25[2] & 
                     D31[2] & D32[2] & D33[2] & D34[2] & D35[2] & 
                     D41[2] & D42[2] & D43[2] & D44[2] & D45[2] & 
                     D51[2] & D52[2] & D53[2] & D54[2] & D55[2];

always @(posedge clk) begin
    D11 <= {mask, de, hsync, vsync};
    D12 <= D11;
    D13 <= D12;
    D14 <= D13;
    D15 <= D14;

    D21 <= bram_dout[3:0];
    D22 <= D21;
    D23 <= D22;
    D24 <= D23;
    D25 <= D24;
 
    D31 <= bram_dout[7:4];
    D32 <= D31;
    D33 <= D32;
    D34 <= D33;
    D35 <= D34;
 
    D41 <= bram_dout[11:8];
    D42 <= D41;
    D43 <= D42;
    D44 <= D43;
    D45 <= D44;
 
    D51 <= bram_dout[15:12];
    D52 <= D51;
    D53 <= D52;
    D54 <= D53;
    D55 <= D54;
        
    sum_r1 <= D11[3] + D12[3] + D13[3] + D14[3] + D15[3];
    sum_r2 <= D21[3] + D22[3] + D23[3] + D24[3] + D25[3];
    sum_r3 <= D31[3] + D32[3] + D33[3] + D34[3] + D35[3];
    sum_r4 <= D41[3] + D42[3] + D43[3] + D44[3] + D45[3];
    sum_r5 <= D51[3] + D52[3] + D53[3] + D54[3] + D55[3];
        
    sum <= sum_r1 + sum_r2 + sum_r3 + sum_r4 + sum_r5;
    
    context_valid_d1 <= context_valid;
    context_valid_d2 <= context_valid_d1;
    
    de_d1 <= D33[2];
    de_d2 <= de_d1;
    
    hsync_d1 <= D33[1];
    hsync_d2 <= hsync_d1;
    
    vsync_d1 <= D33[0];
    vsync_d2 <= vsync_d1;
end

assign bram_din = {D45, D35, D25, D15};

assign mask_new = (context_valid_d2 && (sum > THRESHOLD)) ? 255 : 0;
assign de_out     = de_d2;
assign hsync_out  = hsync_d2;
assign vsync_out  = vsync_d2;
    
endmodule
