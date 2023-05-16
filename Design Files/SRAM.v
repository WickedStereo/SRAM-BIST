`timescale 1ns / 1ps

module SRAM(
input [3:0] data_in,
input [7:0] addr,
input we, clk,
output [3:0] data_out
);

reg [3:0] ram[7:0];
reg [7:0] addr_reg;

always @ (posedge clk)
begin
    if (we)
        ram[addr] <= data_in;
    addr_reg <= addr;
end

assign data_out = ram[addr_reg];

endmodule

    
    
