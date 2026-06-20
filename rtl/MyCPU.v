`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2026 09:29:57 PM
// Design Name: 
// Module Name: MyCPU
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


module MyCPU(
input clk,
input rstn,

output [7:0] PcCounter,
input [3:0] OpCode,
input [3:0] OpDes,
input [3:0] OpSor,
input [7:0] OpData,

input INT,

input  [7:0]  InData0,
input  [7:0]  InData1,
output [7:0] OutData0,
output [7:0] OutData1
    );
reg wINT;
always @(posedge clk or negedge rstn)
    if (!rstn) wINT <= 1'b0;
     else wINT <= INT;
wire [3:0] CleOpCode = (wINT) ? 4'h0  : OpCode;
wire [3:0] CleOpDes  = (wINT) ? 4'h0  : OpDes ;
wire [3:0] CleOpSor  = (wINT) ? 4'h0  : OpSor ;
wire [7:0] CleOpData = (wINT) ? 8'h00 : OpData;
 
localparam OPnop    = 4'h0;
localparam OPload   = 4'h1;
localparam OPmov    = 4'h2;
localparam OPadd    = 4'h3;
localparam OPb      = 4'h8;
localparam OPbz     = 4'h9;
localparam OPbnz    = 4'ha;
localparam OPreturn = 4'hb;

localparam  memdata  = 4'h0;
localparam  regA     = 4'h1;
localparam  regB     = 4'h2;
localparam  regC     = 4'h3;
localparam  regD     = 4'h4;
localparam  IntAdd   = 4'h5;
localparam  IntSaved = 4'h6;
localparam  InDa0    = 4'h8;
localparam  InDa1    = 4'h9;

                    
reg [7:0] RegisterA,RegisterB,RegisterC,RegisterD;
reg [7:0] INTjAdd, INTsave;
wire Load = (CleOpCode == OPload) ? 1'b1 : 1'b0;   
wire Mov  = (CleOpCode == OPmov) ? 1'b1 : 1'b0;   
wire Add  = (CleOpCode == OPadd) ? 1'b1 : 1'b0;   
reg [7:0] MainData;
always @(*) begin 
     case (CleOpSor) 
         memdata  : MainData = CleOpData;
         regA     : MainData = RegisterA;
         regB     : MainData = RegisterB;
         regC     : MainData = RegisterC;
         regD     : MainData = RegisterD;
         IntAdd   : MainData = INTjAdd;
         IntSaved : MainData = INTsave;
         InDa0    : MainData = InData0;
         InDa1    : MainData = InData1;
         default  : MainData = CleOpData; 
     endcase
end
reg [7:0] CompReg;
always @(*) begin 
     case (CleOpDes) 
         regA     : CompReg = RegisterA;
         regB     : CompReg = RegisterB;
         regC     : CompReg = RegisterC;
         regD     : CompReg = RegisterD;
         default  : CompReg = CleOpData; 
     endcase
end

wire Jump = (CleOpCode == OPb)                ? 1'b1 : 
            (CleOpCode == OPreturn)           ? 1'b1 : 
            ((CleOpCode == OPbz)  && !CompReg)? 1'b1 : 
            ((CleOpCode == OPbnz) && CompReg )? 1'b1 : 1'b0;   
reg [7:0] Reg_PcCounter;
always @(posedge clk or negedge rstn)
    if(!rstn) Reg_PcCounter <= 8'h00;
     else if (INT) Reg_PcCounter <= INTjAdd;
     else if (Jump) Reg_PcCounter <= MainData;
     else Reg_PcCounter <= Reg_PcCounter + 1;
assign PcCounter = Reg_PcCounter;   

always @(posedge clk or negedge rstn)
    if (!rstn) INTjAdd <= 8'h00;
     else if (CleOpDes == IntAdd) 
         if (Load) INTjAdd <= MainData;    
always @(posedge clk or negedge rstn)
    if (!rstn) INTsave <= 8'h00;
     else if (INT) 
            if ((CleOpCode[3] == 1'b1)&&Jump) INTsave <= CleOpData;
             else INTsave <= Reg_PcCounter;    


always @(posedge clk or negedge rstn)
    if (!rstn) RegisterA <= 8'h00;
     else if (CleOpDes == regA) 
         if (Load || Mov) RegisterA <= MainData;    
          else if (Add) RegisterA <= RegisterA + MainData;    
always @(posedge clk or negedge rstn)
    if (!rstn) RegisterB <= 8'h00;
     else if (CleOpDes == regB) 
         if (Load || Mov) RegisterB <= MainData;    
          else if (Add) RegisterB <= RegisterB + MainData;    
always @(posedge clk or negedge rstn)
    if (!rstn) RegisterC <= 8'h00;
     else if (CleOpDes == regC) 
         if (Load || Mov) RegisterC <= MainData;    
          else if (Add) RegisterC <= RegisterC + MainData;    
always @(posedge clk or negedge rstn)
    if (!rstn) RegisterD <= 8'h00;
     else if (CleOpDes == regD) 
         if (Load || Mov) RegisterD <= MainData;    
          else if (Add) RegisterD <= RegisterD + MainData;    
          
assign OutData0 = RegisterA;
assign OutData1 = RegisterB;
endmodule
