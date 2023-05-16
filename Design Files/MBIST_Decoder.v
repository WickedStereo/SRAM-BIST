`timescale 1ns / 1ps
`include "parameters.vh"

module BIST_Decoder(input data_in, input [1:0]sel, output [`SRAM_WORD_WIDTH-1:0] data_out);
    assign data_out = ((sel==2'b00) | (sel==2'b10) | (sel==2'b11) )?(data_in?4'b1111:4'b0000):(data_in?4'b1010:4'b0101);
endmodule



