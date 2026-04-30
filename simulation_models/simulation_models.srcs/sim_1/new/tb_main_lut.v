`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2026 13:26:18
// Design Name: 
// Module Name: tb_main_lut
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


module tb_main_lut(

    );

reg clk=1'b0;
reg [7:0]addra=8'h00;

wire [7:0]douta;

main_lut uut (
    .clk(clk),
    .addra(addra),
    .douta(douta)
);
    
initial
begin
    while(1)
    begin
    #5; clk=1'b1;
    #5; clk=1'b0;
    end
end

initial
begin
    addra=8'h00;
    #128;
    addra=8'hAA;
    #180;
    $finish;
end
    
endmodule
