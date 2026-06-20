`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Varun Kondagunturi
// 
// Create Date:    17:08:26 06/12/2014 
// Design Name: 
// Module Name:    Abacus_Top_Module 
// Project Name: 
// Target Devices: 
// Tool versions: 
//
//
// Description: 
//This is the Top-Level Source file for the Abacus Project. 
//Slide switches provide two 8-bit binary inputs A and B. 
//Slide Switches [15 down to 8] is input A.
//Slide Switches [7 down to 0] is input B.
//Inputs from the Push Buttons ( btnU, btnD, btnR, btnL) will allow the user to select different arithmetic operations that will be computed on the inputs A and B.
//btnU: Subtraction/Difference. Result will Scroll
//When A>B, difference is positive. 
//When A<B, difference is negative. If the button is not held down but just pressed once, the result will scroll. To find out if the result is negative, press and hold onto the push button btnU. This will show the negative sign. 
//btnD: Multiplication/Product. Result will Scroll
//btnR: Quotient(Division Operation). Press and Hold the button to display result
//btnL: Remainder ( Division Operation). Press and Hold the button to display result
//Output is displayed on the 7 segment LED display. 
//
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define SIM
 module Basys3_Abacus_Top(

//CLK Input
	 input clk,
	 
//Push Button Inputs	 
	 input btnC,
	 input btnU, 
	 input btnD,
	 input btnR,
	 input btnL,
	 
// Slide Switch Inputs
// Input A = sw[15:8]
//Input B = sw[7:0]	 
	 input [15:0] sw, 
   
// LED Outputs
     output [15:0] led,
     
// Seven Segment Display Outputs
     output [6:0] seg,
     output [3:0] an, 
     output dp
    
 );
wire rstn = !btnC;	
reg [23:0] DeBounc;
wire INT;
always @(posedge clk or negedge rstn)
    if (!rstn) DeBounc <= 24'hFFFFFF;
     else if (DeBounc != 24'hFFFFFF) DeBounc <= DeBounc + 1;
`ifdef SIM
     else if (btnR) DeBounc <= 24'hFFFF00;
`else     
     else if (btnR) DeBounc <= 24'h000000;
`endif     
`ifdef SIM
assign INT = (DeBounc == 24'hFFFF02) ? 1'b1 : 1'b0;
`else     
assign INT = (DeBounc == 24'h000002) ? 1'b1 : 1'b0;
`endif     

(* ram_style = "block" *)
(* dont_touch = "yes" *)
reg [19:0] Mem [0:255];
reg [19:0] OutMem;
initial begin
  $readmemh("ram_init.txt", Mem);
end

wire [7:0] PcCounter;
always @(posedge clk) begin 
     OutMem <= Mem[PcCounter];
end

wire [3:0] OpCode = OutMem[19:16];
wire [3:0] OpDes  = OutMem[15:12];
wire [3:0] OpSor  = OutMem[11:8];
wire [7:0] OpData = OutMem[7:0];


MyCPU MyCPU_inst(
.clk      (clk),
.rstn     (rstn),

.PcCounter(PcCounter),
.OpCode(OpCode),
.OpDes (OpDes ),
.OpSor (OpSor ),
.OpData(OpData),

.INT(INT),

.InData0 (sw[7:0]  ),
.InData1 (sw[15:8] ),
.OutData0(led[7:0] ),
.OutData1(led[15:8])
    );

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
ila_0 ila_0_inst (
	.clk(clk), // input wire clk

	.probe0(rstn), // input wire [0:0]  probe0  
	.probe1(PcCounter), // input wire [7:0]  probe1 
	.probe2(OutMem), // input wire [19:0]  probe2
	.probe3(sw[7:0]  ), // input wire [7:0]  probe3 
	.probe4(sw[15:8] ), // input wire [7:0]  probe4 
	.probe5(led[7:0] ), // input wire [7:0]  probe5 
	.probe6(led[15:8]) // input wire [7:0]  probe6
);

endmodule