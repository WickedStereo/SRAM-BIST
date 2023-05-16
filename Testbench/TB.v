`timescale 1ns / 1ps

module TB#(parameter CLK_PERIOD = 50, BIST_ALGO = 0)();

wire HALF_CLK= CLK_PERIOD/2;

reg [3:0] data_in;
reg [7:0] data_addr;
reg we, start, rst, clk;

wire [3:0] data_out;
wire fail;
wire [7:0] fail_addr;

initial begin
    clk = 1;
end

MBIST DUT (.clk(clk), .start(start), .rst(rst), .we(we), .data_in(data_in), .data_addr(data_addr),.test_sel(BIST_ALGO),.fail(fail),.fail_addr(fail_addr),.data_out(data_out));

always #HALF_CLK clk = ~clk;

initial begin
    we = 0;
    start = 0;
    data_addr = 0;
    data_in = 0;
    rst = 1;

    repeat(2)#CLK_PERIOD;

    rst = 0;
    start = 1;
    
    #CLK_PERIOD;
    while(DUT.Control.state != 2)
        #CLK_PERIOD;
    
    $finish;
    
end

endmodule
