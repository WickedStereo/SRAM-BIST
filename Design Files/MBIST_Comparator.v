`timescale 1ns / 1ps

module MBIST_Comparator
(input[3:0] data_in1, data_in2,
output isEqual);
    
    assign isEqual = data_in1 == data_in2;
    
endmodule



