`timescale 1ns / 1ps

module MBIST_CounterCH
(input clk, cen, rst,
output [7: 0] addr,
output [3:0] data,
output we,cout);

reg [10:0] counter;

always @(posedge clk) begin
    if (rst)
        counter <= 0;
    else if (cen)
            counter <= counter + 1;
    else
        counter <= counter;
end

assign cout = counter[10];
assign addr = counter[7:0];
assign we = ~counter[8];
assign data = counter[9]?(counter[0]?4'b1010:4'b0101):(counter[0]?4'b0101:4'b1010);

endmodule