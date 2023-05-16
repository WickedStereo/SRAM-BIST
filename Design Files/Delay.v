`timescale 1ns / 1ps
module Delay#(parameter DATA_WIDTH = 4)(
input clk,
input [DATA_WIDTH-1:0]data_in,
output reg [DATA_WIDTH-1:0]data_out);
    
    always@(posedge clk)
        data_out<=data_in;
        
endmodule