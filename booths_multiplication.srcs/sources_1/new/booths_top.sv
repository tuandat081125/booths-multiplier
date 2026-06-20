`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2026 08:42:04 PM
// Design Name: 
// Module Name: booths_top
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


module booths_top
  (
    input logic [7:0] data_in,
    input logic rst, start,
    input logic clk,
    
    output logic [7:0] data_outA,
    output logic [7:0] data_outQ,
    output logic done
  );
  
  logic data_outQ_1;
  logic conti; 
    
  logic ldA, clrA, sftA;
  logic ldQ, clrQ, sftQ;
  logic clrQ_1, sftQ_1;
  logic ldM;
  logic addsub;
  logic dec_cnt, set_cnt, clr_cnt; 
  
  Datapath datapath
  (
    .data_in     (data_in),
    .ldA         (ldA), 
    .clrA        (clrA), 
    .sftA        (sftA),
    .ldQ         (ldQ), 
    .clrQ        (clrQ), 
    .sftQ        (sftQ),
    .clrQ_1      (clrQ_1), 
    .sftQ_1      (sftQ_1),
    .ldM         (ldM),
    .addsub      (addsub),
    .dec_cnt     (dec_cnt), 
    .set_cnt     (set_cnt), 
    .clr_cnt     (clr_cnt),
    .clk         (clk),
    
    .data_outA   (data_outA),
    .data_outQ   (data_outQ),
    .data_outQ_1 (data_outQ_1),
    .conti       (conti)
  );
  
  Controlpath controlpath
  (
    .data_outQ   (data_outQ),
    .start       (start),
    .data_outQ_1 (data_outQ_1),
    .conti       (conti), 
    .clk         (clk),
    .rst         (rst),
    
    .ldA         (ldA), 
    .clrA        (clrA), 
    .sftA        (sftA),
    .ldQ         (ldQ), 
    .clrQ        (clrQ), 
    .sftQ        (sftQ),
    .clrQ_1      (clrQ_1), 
    .sftQ_1      (sftQ_1),
    .ldM         (ldM),
    .addsub      (addsub),
    .dec_cnt     (dec_cnt), 
    .set_cnt     (set_cnt), 
    .clr_cnt     (clr_cnt),
    .done        (done)
  );
endmodule
