`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 19:29:30
// Design Name: 
// Module Name: tb_processor
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


module tb_processor(

    );
    
reg clk=1'b0;

initial
begin
    while(1)
    begin
        #1 clk=1'b0;
        #1 clk=1'b1;
    end
end

reg  [7:0] gpi = 8'h00;
wire [7:0] gpo;

processor u_processor(
    .clk(clk),
    .gpi(gpi),
    .gpo(gpo)
);

//initial begin
//    // ?? KROK 1: czekaj a¿ LED0 siê zapali (gpo[0]=1) ??
//    $display("Czekam na LED0...");
//    wait(gpo[0] == 1'b1);
//    $display("LED0 zapalona - OK (czas=%0t)", $time);

//    // ?? KROK 2: czekaj a¿ LED1 siê zapali (gpo[1]=1) ??
//    $display("Czekam na LED1...");
//    wait(gpo[1] == 1'b1);
//    $display("LED1 zapalona - OK (czas=%0t)", $time);

//    // wymuœ SW0 = 1 (wciœniêcie prze³¹cznika)
//    #2 gpi = 8'h01;
//    $display("SW0 wcisniety (gpi=0x01)");

//    // poczekaj a¿ procesor to zauwa¿y i przejdzie dalej
//    wait(gpo[1] == 1'b0);
//    #2 gpi = 8'h00;  // zwolnij SW0
//    $display("SW0 zwolniony");

//    // ?? KROK 3: czekaj a¿ LED2 siê zapali (gpo[2]=1) ??
//    $display("Czekam na LED2...");
//    wait(gpo[2] == 1'b1);
//    $display("LED2 zapalona - OK (czas=%0t)", $time);

//    // ?? KROK 4: czekaj a¿ LED3 siê zapali (gpo[3]=1) ??
//    $display("Czekam na LED3...");
//    wait(gpo[3] == 1'b1);
//    $display("LED3 zapalona - OK (czas=%0t)", $time);

//    // wymuœ SW1 = 1
//    #2 gpi = 8'h02;
//    $display("SW1 wcisniety (gpi=0x02)");

//    // poczekaj a¿ procesor przejdzie dalej (LED3 zgaœnie)
//    wait(gpo[3] == 1'b0);
//    #2 gpi = 8'h00;  // zwolnij SW1
//    $display("SW1 zwolniony");

//    // ?? KROK 5: sprawdŸ powrót do pocz¹tku (LED0 znów) ?
//    $display("Czekam na powrot do poczatku (LED0)...");
//    wait(gpo[0] == 1'b1);
//    $display("Powrot do poczatku - OK (czas=%0t)", $time);

//    $display("\nWszystkie testy zakonczone pomyslnie!");
//    $finish;
//end

//// ?? Timeout - zabezpieczenie przed zawieszeniem ???????
//initial begin
//    #1_000_000;
//    $display("TIMEOUT - procesor sie zawiesil!");
//    $finish;
//end

initial
begin
    #100;
    $finish;
end

endmodule
