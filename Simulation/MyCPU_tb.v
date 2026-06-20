`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 11:53:27 AM
// Design Name: 
// Module Name: MyCPU_tb
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


module MyCPU_tb();
reg clk ;
reg rstn;
reg INT;
initial begin 
clk  = 1'b0;
rstn = 1'b1;
INT = 1'b0;
#100;
rstn = 1'b0;
#500;
INT = 1'b1;
#500;
INT = 1'b0;
end
always #5 clk = ~clk;
wire [15:0] sw = 16'h0005;
wire [15:0] led;

Basys3_Abacus_Top Basys3_Abacus_Top_inst(
.clk (clk),
.btnC(rstn),
.btnR(INT),
.sw  (sw),    
.led (led)
 );

endmodule
