`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 22:39:32
// Design Name: 
// Module Name: processor
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


module processor(
    input clk,
    input [7:0]gpi,
    output [7:0]gpo
    );
    
wire [31:0]instr;
wire [7:0]alu_res;
wire [6:0]ce;
wire [7:0]rd_data;
wire [7:0]pc_addr;
wire [7:0]addr_plus;
wire jump_con;
wire [7:0]pc_data;
wire [7:0]r0;
wire [7:0]r1;
wire [7:0]r2;
wire [7:0]r3;
wire [7:0]r4;
wire [7:0]r5;
wire [7:0]r6;
wire [7:0]r7;
wire [7:0]rx;
wire [7:0]ry;
wire [7:0]ry_imm_data;
wire [7:0]alu1;
wire [7:0]alu2;
wire [7:0]alu3;
wire [7:0]alu4;
wire [7:0]mem_data;
wire cmp_res;

assign addr_plus = pc_addr + 8'd1;
assign cmp_res = alu3[0];
    
decoder u_decoder(
    .d_op(instr[10:8]),
    .ce(ce)
);

rd_mux u_rd_mux(
    .rd_op(instr[11]),
    .alu_res(alu_res),
    .mem_data(mem_data),
    .rd_data(rd_data)
);

pc_mux u_pc_mux(
    .alu_res(alu_res),
    .addr_plus(addr_plus),
    .jump_con(jump_con),
    .pc_data(pc_data)
);

register_bank u_bank(
    .clk(clk),
    .ce(ce),
    .rd_data(rd_data),
    .pc_data(pc_data),
    .gpi(gpi),
    .gpo(gpo),
    .pc_addr(pc_addr),
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r4(r4),
    .r5(r5),
    .r6(r6),
    .r7(r7)
);

rx_mux u_rx_mux(
    .rx_op(instr[18:16]),
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r4(r4),
    .r5(r5),
    .r6(r6),
    .r7(r7),
    .rx(rx)
);

ry_mux u_ry_mux(
    .ry_op(instr[14:12]),
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r4(r4),
    .r5(r5),
    .r6(r6),
    .r7(r7),
    .ry(ry)
);

imm_mux u_imm_mux(
    .imm_op(instr[15]),
    .ry(ry),
    .imm(instr[7:0]),
    .ry_imm_data(ry_imm_data)
);

ALU u_ALU(
    .rx(rx),
    .ry_imm_data(ry_imm_data),
    .alu1(alu1),
    .alu2(alu2),
    .alu3(alu3),
    .alu4(alu4)
);

alu_mux u_alu_mux(
    .alu_op(instr[21:20]),
    .alu1(alu1),
    .alu2(alu2),
    .alu3(alu3),
    .alu4(alu4),
    .alu_res(alu_res)
);

warunek_skoku u_jump(
    .pc_op(instr[25:24]),
    .cmp_res(cmp_res),
    .jump_con(jump_con)
);

i_mem
 u_i_mem(
    .address(pc_addr),
    .data(instr)
);

d_mem u_d_mem(
    .address(alu_res),
    .data(mem_data)
);
    
endmodule
