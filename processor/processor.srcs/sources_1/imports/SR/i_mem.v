`timescale 1ns / 1ps
//-----------------------------------------------
// Company: agh
//-----------------------------------------------
module i_mem
(
  input [7:0]address,
  output [31:0]data
);
//-----------------------------------------------
//instruction memory
wire [31:0]program[255:0];

//assign program[0]=32'b00000000000000000000000000000000;

//assign program[1]=32'b00000000000101101000000000110100; //movi R0, 0x34
//assign program[2]=32'b00000000000100000110000100000000; //mov R1, R0
////
//assign program[3]=32'b00000000000101100110011000000000; //nop
//                    0000001000010Rx 0110011000000000
//assign program[4]=32'b00000001000100000110011000000000; //jump R0
//assign program[4]=32'b00000001000100110110011000000000; //jump R3
////                    000000010001011010000110imm
//assign program[5]=32'b00000001000101101000011000000001; //jumpi 1
//assign program[5]=32'b00000001000101101000011000000100; //jumpi 4
////                    0000001100110Rx 10000110imm
//assign program[6]=32'b00000011001100001000011000000001; //jz R0, 1
//assign program[6]=32'b00000011001101001000011000001000; //jz R4, 8
////                    0000001000110Rx 10000110imm
//assign program[7]=32'b00000010001100001000011000000001; //jnz R0, 1
//assign program[7]=32'b00000010001101011000011000000101; //jnz R5, 5
////                    0000000000010Rx 0Ry 0Rd 00000000    add Rd, Rx, Ry
//assign program[8]=32'b00000000000100100011000100000000; //add R1, R2, R3
//assign program[8]=32'b00000000000101010110010000000000; //add R4, R5, R6
////                    0000000000010Rx 10000Rd imm         addi Rd, Rx, imm
//assign program[9]=32'b00000000000100001000000100000001; //addi R1, R0, 1
//assign program[9]=32'b00000000000100101000001100001001; //addi R3, R2, 9
////                     0000000000000Rx 0Ry 0Rd 00000000    and Rd, Rx, Ry
//assign program[10]=32'b00000000000000100001001100000000; //and R3, R2, R1
//assign program[10]=32'b00000000000001010100011000000000; //and R6, R5, R4
////                     0000000000000Rx 10000Rd imm         andi Rd, Rx, imm
//assign program[11]=32'b00000000000000011000001000000001; //andi R2, R1, 1
//assign program[11]=32'b00000000000001001000001100001111; //andi R3, R4, 15
////                     0000000000010Rx 01101Rd 00000000    load Rd, Rx
//assign program[12]=32'b00000000000100010110101000000000; //load R2, R1
//assign program[12]=32'b00000000000101010110101100000000; //load R3, R5
////                     000000000001011010001Rd imm
//assign program[13]=32'b00000000000101101000100000000000; // loadi R0, 0
//assign program[13]=32'b00000000000101101000100100000001; // loadi R1, 1
//-----------------------------------------------
// program2
//assign program[0]=32'h00168000;
//assign program[1]=32'h00168104;
//assign program[2]=32'h00108001;
//assign program[3]=32'h00001200;
//assign program[4]=32'h03328602;
//assign program[5]=32'h00168301;
//-----------------------------------------------
//// program3
//assign program[0] = 32'h00168401; // movi R4, 0x01
//assign program[1] = 32'h00168132; // movi R1, 0x32
//assign program[2] = 32'h00168200; // movi R2, 0x00
//assign program[3] = 32'h00128201; // addi R2, R2, 0x01
//assign program[4] = 32'h000283FF; // andi R3, R2, 0xFF
//assign program[5] = 32'h02338603; // jnz R3, 0x03
//assign program[6] = 32'h001181FF; // addi R1, R1, 0xFF
//assign program[7] = 32'h02318602; // jnz R1, 0x02
//assign program[8] = 32'h00168402; // movi R4, 0x02
//assign program[9] = 32'h00058301; // andi R3, R5, 0x01
//assign program[10] = 32'h03338609; // jz R3, 0x09
//assign program[11] = 32'h00168404; // movi R4, 0x04
//assign program[12] = 32'h00168132; // movi R1, 0x32
//assign program[13] = 32'h00168200; // movi R2, 0x00
//assign program[14] = 32'h00128201; // addi R2, R2, 0x01
//assign program[15] = 32'h000283FF; // andi R3, R2, 0xFF
//assign program[16] = 32'h0233860E; // jnz R3, 0x0E
//assign program[17] = 32'h001181FF; // addi R1, R1, 0xFF
//assign program[18] = 32'h0231860D; // jnz R1, 0x0D
//assign program[19] = 32'h00168408; // movi R4, 0x08
//assign program[20] = 32'h00058302; // andi R3, R5, 0x02
//assign program[21] = 32'h03338614; // jz R3, 0x14
//assign program[22] = 32'h01168600; // jumpi 0x00
//-----------------------------------------------
// program4
assign program[0]  = 32'h00168401; // movi R4, 0x01
assign program[1]  = 32'h00168019; // movi R0, 0x19
assign program[2]  = 32'h001080FF; // addi R0, R0, -1
assign program[3]  = 32'h02308602; // jnz R0, 0x02
assign program[4]  = 32'h00168402; // movi R4, 0x02
assign program[5]  = 32'h00058201; // andi R2, R5, 0x01
assign program[6]  = 32'h03328605; // jz R2, 0x05
assign program[7]  = 32'h00168404; // movi R4, 0x04
assign program[8]  = 32'h00168019; // movi R0, 0x19
assign program[9]  = 32'h001080FF; // addi R0, R0, -1
assign program[10] = 32'h02308609; // jnz R0, 0x09
assign program[11] = 32'h00168408; // movi R4, 0x08
assign program[12] = 32'h00058202; // andi R2, R5, 0x02
assign program[13] = 32'h0332860C; // jz R2, 0x0C
assign program[14] = 32'h01168600; // jumpi 0x00
//-----------------------------------------------
assign data=program[address];
//-----------------------------------------------
endmodule
//-----------------------------------------------
