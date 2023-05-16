`timescale 1ns / 1ps

module MBIST_Mux41 #(parameter DATA_WIDTH = 8)
  (input [DATA_WIDTH-1:0] data_in0,
   input [DATA_WIDTH-1:0] data_in1,
   input [DATA_WIDTH-1:0] data_in2,
   input [DATA_WIDTH-1:0] data_in3,
   input [1:0] sel,
   output [DATA_WIDTH-1:0] data_out);
    
    
   assign data_out = (sel == 2'b00) ? data_in0 :
                     (sel == 2'b01) ? data_in1 :
                     (sel == 2'b10) ? data_in2 :
                                        data_in3;


endmodule