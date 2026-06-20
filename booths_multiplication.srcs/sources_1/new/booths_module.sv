`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2026 08:42:04 PM
// Design Name: 
// Module Name: booths_module
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


module REG1
  (
    input logic [7:0] data_in,
    input ld, clr, sft, clk,
    
    output logic [7:0] data_out,
    output logic sft_out
  );
  
  
  always_ff @(posedge clk)
    begin
      if(clr)
        begin
          data_out <= 0;
          sft_out <= 0;
        end
      else if(ld)
        begin
          data_out <= data_in;
        end
      else if(sft)
        begin
          data_out <= {data_out[7],data_out[7:1]};
        end
    end
endmodule

module REG2
  (
    input logic [7:0] data_in,
    input ld, clr, sft, sft_in, clk,
    
    output logic [7:0] data_out,
    output logic sft_out
  );
  
  
  always_ff @(posedge clk)
    begin
      if(clr)
        begin
          data_out <= 0;
          sft_out <= 0;
        end
      else if(ld)
        begin
          data_out <= data_in;
        end
      else if(sft)
        begin
          data_out <= {sft_in, data_out[7:1]};
        end
    end
endmodule

module REG3
  (
    input logic sft_in,
    input logic sft, clr, clk,
    
    output logic data_out
  );
  
  always_ff @(posedge clk)
    begin
      if(clr)
        begin
          data_out <= 0;
        end
      else if(sft)
        begin
          data_out <= sft_in;
        end
    end
endmodule

module cnt(
    input logic set, clr, dec, clk,
    output logic conti
  );
  
  logic [7:0] count;
  
  always_ff @(posedge clk)
    begin
      if(clr)
        begin
          count <= 0;
        end
      else if(set)
        begin
          count <= 4'b1000;
        end
      else if(dec)
        begin
          count <= count - 1'b1;
        end
    end
  
  assign conti = |count;
  
endmodule

module REG4
  (
    input logic [7:0] data_in,
    input logic ld, clk,
    
    output logic [7:0] data_out
  );
  
  always_ff @(posedge clk)
    begin
      if(ld)
        begin
          data_out <= data_in;
        end
    end
endmodule


module ALU
  (
    input logic [7:0] data_in1, data_in2,
    input logic addsub, clk,
    
    output logic [7:0] data_out
  );
  
  logic [7:0] tmp;
  
  always_comb
    begin
      if(addsub)
        begin
          data_out = data_in1 + data_in2;
        end
      else
        begin
          data_out = $signed(data_in1) - $signed(data_in2);
        end
    end
endmodule
