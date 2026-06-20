`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2026 01:24:33 PM
// Design Name: 
// Module Name: booths_tb
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


//-127 to 127
module booths_tb;
  logic clk;
  logic rst;
  logic start;
  logic [7:0] data_in;
  logic [7:0] data_outA;
  logic [7:0] data_outQ;
  logic [15:0] data_out;
  logic done;
  
  logic [7:0] M, Q;
  
  integer fd;
  logic signed [15:0] expected;
  integer error_count = 0;
  
  booths_top DUT
  (
    .data_in   (data_in),
    .rst       (rst),
    .start     (start),
    .clk       (clk),
    
    .data_outA (data_outA),
    .data_outQ (data_outQ),
    .done      (done)
  );
  
  assign data_out = {data_outA, data_outQ};
  
  always
    #5 clk = ~clk;
  
  initial begin
    fd = $fopen("error_log.txt", "w");
    clk = 0;
    rst = 0;
    start = 0;
    M = 0;
    Q = 0;
    
    #2
    rst = 1;
    
    #10
    start = 1;
    rst = 0;
    
    #10
    start = 1'b0;
    data_in = M;
    
    #10
    data_in = Q;
  end
  
  initial
    forever begin
      @(posedge done);
      expected = $signed(M) * $signed(Q);

      if(data_out !== expected && M != 8'b10000000) 
      begin
        error_count++;
          $fdisplay(fd, "ERROR %0d: M=%0d Q=%0d EXPECT=%0d GOT=%0d",
            error_count,
            $signed(M),
            $signed(Q),
            expected,
            $signed(data_out));
      end
      
      if(Q == 8'b11111111)
          if(M == 8'b11111111)
            begin
              $fdisplay(fd, "TOTAL ERRORS = %0d", error_count);
              $fclose(fd);
              $display("All tests completed");
              $finish;
            end
          else
            begin
              M = M + 1'b1;
              Q = 0;
            end
        else
          Q = Q + 1'b1;
      
      #7
      rst = 1;
      #10
      start = 1;
      rst = 0;
      
      #10
      start = 1'b0;
      data_in = M;
      
      #10
      data_in = Q;
    end
      
endmodule
