`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2026 08:42:04 PM
// Design Name: 
// Module Name: booths_control
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


module Controlpath
  ( 
    input logic [7:0] data_outQ,
    input logic start,
    input logic data_outQ_1,
    input logic conti, 
    input logic clk,
    input logic rst,
    
    output logic ldA, clrA, sftA,
    output logic ldQ, clrQ, sftQ,
    output logic clrQ_1, sftQ_1,
    output logic ldM,
    output logic addsub,
    output logic dec_cnt, set_cnt, clr_cnt,
    output logic done
  );
  
  typedef enum logic [3:0]
  {
    S0,
    S1,
    S2,
    S3,
    S4,
    S5,
    S6,
    S7,
    S8
  } state_t;
  
  state_t state, next_state;
  
  always_ff @(posedge clk)
    begin
      if(rst)
        state <= S0;
      else
        state <= next_state;
    end
  
  always_comb
    begin
      next_state = state;
      
      case(state)
        S0:
          begin
            if(start)
              next_state = S1;
          end
        S1:
          begin
            next_state = S2;
          end
        S2:
          begin
            next_state = S3;
          end
        S3:
          begin
            if({data_outQ[0], data_outQ_1} == 2'b01)
              next_state = S4;
            else if ({data_outQ[0], data_outQ_1} == 2'b10)
              next_state = S5;
            else
              next_state = S6;
          end
        S4:
          begin
            next_state = S6;
          end
        S5:
          begin
            next_state = S6;
          end
        S6:
          begin
            next_state = S7;
          end
        S7:
          begin
            if (conti == 0)
              next_state = S8;
            else if({data_outQ[0], data_outQ_1} == 2'b01)
              next_state = S4;
            else if ({data_outQ[0], data_outQ_1} == 2'b10)
              next_state = S5;
            else
              next_state = S6;
          end
        S8: 
          next_state = S8;
        default:
          next_state = state;
      endcase
    end
  
  always_comb
    begin    
      ldA = 0; clrA = 0; sftA = 0;
      ldQ = 0; clrQ = 0; sftQ = 0;
      clrQ_1 = 0; sftQ_1 = 0;
      ldM = 0;
      addsub = 0;
      dec_cnt = 0; set_cnt = 0; clr_cnt = 0;
      
      case(state)
        S0:
          begin
            clrA = 1'b1;
            clrQ = 1'b1;
            clrQ_1 = 1'b1;
            clr_cnt = 1'b1;
            done = 1'b0;
          end
        S1:
          begin
            ldM = 1'b1;
            set_cnt = 1'b1;
            clrQ_1 = 1'b1;
          end
        S2:
          begin
            ldQ = 1'b1;
          end
        S3: ;
        S4: 
          begin
            addsub = 1'b1;
            ldA = 1'b1;
          end
        S5:
          begin
            addsub = 1'b0;
            ldA = 1'b1;
          end
        S6:
          begin
            sftA = 1'b1;
            sftQ = 1'b1;
            sftQ_1 = 1'b1;
            dec_cnt = 1'b1;
          end
        S7: ;
        S8: done = 1'b1;
      endcase
    end
endmodule