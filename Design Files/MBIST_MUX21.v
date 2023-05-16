`timescale 1ns / 1ps
module MBIST_Mux21 #(parameter DATA_WIDTH = 4)(output [DATA_WIDTH-1:0] data_out, input [DATA_WIDTH-1:0]data_in0, data_in1, 
input sel);

 assign data_out = sel ? data_in1 : data_in0;
 
endmodule
