`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2026 08:42:04 PM
// Design Name: 
// Module Name: booths_datapath
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


module Datapath
  (
    input logic [7:0] data_in,
    input logic ldA, clrA, sftA,
    input logic ldQ, clrQ, sftQ,
    input logic clrQ_1, sftQ_1,
    input logic ldM,
    input logic addsub,
    input logic dec_cnt, set_cnt, clr_cnt,
    input logic clk,
    
    output logic [7:0] data_outA,
    output logic [7:0] data_outQ,
    output logic data_outQ_1,
    output logic conti
  );
  
  logic [7:0] alu_out;
  logic sft_outA;
  logic sft_outQ, sft_inQ;
  logic sft_inQ_1;
  
  assign sft_inQ = data_outA[0];
  assign sft_inQ_1 = data_outQ[0];
  
  logic [7:0] data_outM;
  
  REG1 A
  (
    .data_in (alu_out),
    .ld      (ldA),
    .clr     (clrA),
    .sft     (sftA),
    .clk     (clk),

    .data_out(data_outA),
    .sft_out (sft_outA)
  );
  
  REG2 Q
  (
    .data_in (data_in),
    .ld      (ldQ),
    .clr     (clrQ),
    .sft     (sftQ),
    .sft_in  (sft_inQ),
    .clk     (clk),

    .data_out(data_outQ),
    .sft_out (sft_outQ)
  );
  
  REG3 Q_1
  (
    .clr     (clrQ_1),
    .sft     (sftQ_1),
    .sft_in  (sft_inQ_1),
    .clk     (clk),

    .data_out(data_outQ_1)
  );
  
  REG4 M
  (
    .data_in (data_in),
    .ld      (ldM),
    .clk     (clk),
    
    .data_out (data_outM)
  );
  
  cnt Cnt1
  (
    .set      (set_cnt),
    .dec      (dec_cnt),
    .clk      (clk),
    
    .conti    (conti)
  );
  
  ALU ALU1
  (
    .data_in1 (data_outA),
    .data_in2 (data_outM),
    .addsub   (addsub),
    .clk      (clk),
    
    .data_out (alu_out)
  );
  
endmodule
