`timescale 1ns / 1ps

module MBIST(
input clk, start, rst, we,
input [3:0]data_in,
input [7:0]data_addr,
input [1:0]test_sel,
output fail,done,
output [7:0]fail_addr,
output [3:0]data_out);

wire [7:0]sram_addr;
wire [3:0]sram_data_out, sram_data_in, delayed_out;

wire [7:0] addr_out, counter_out_BL,counter_out_CH,counter_out_MC,counter_out_MA;
wire [3:0] cdata_out, data_out_BL,data_out_CH,data_out_MC,data_out_MA;
wire we_out, we_BL, we_CH, we_MC, we_MA;
wire counter_cout, cout_BL, cout_CH, cout_MC, cout_MA;

wire muxSel;
wire comp_out, count_enable;
wire [3:0] mux41_cen,mux41_rst;

assign done = counter_cout;
assign data_out = sram_data_out;

MBIST_Controller Control (.start(start), .rst(rst), .clk(clk), .cout(counter_cout), .isTesting(muxSel), .cen(count_enable));

MBIST_Mux41 #(4)MUX41_CEN(.data_in0(4'b0001),.data_in1(4'b0010),.data_in2(4'b0100),.data_in3(4'b1000),.sel(test_sel),.data_out(mux41_cen));
MBIST_Mux41 #(4)MUX41_RST(.data_in0(4'b1110),.data_in1(4'b1101),.data_in2(4'b1011),.data_in3(4'b0111),.sel(test_sel),.data_out(mux41_rst));

MBIST_Mux41 #(8)MUX1_COUNTER(.data_in0(counter_out_BL),.data_in1(counter_out_CH),.data_in2(counter_out_MC),.data_in3(counter_out_MA),.sel(test_sel),.data_out(addr_out));
MBIST_Mux41 #(8)MUX2_COUNTER(.data_in0(data_out_BL),.data_in1(data_out_CH),.data_in2(data_out_MC),.data_in3(data_out_MA),.sel(test_sel),.data_out(cdata_out));
MBIST_Mux41 #(8)MUX3_COUNTER(.data_in0(we_BL),.data_in1(we_CH),.data_in2(we_MC),.data_in3(we_MA),.sel(test_sel),.data_out(we_out));

MBIST_Mux41 #(4)MUX41_COUT(.data_in0(cout_BL),.data_in1(cout_CH),.data_in2(cout_MC),.data_in3(cout_MA),.sel(test_sel),.data_out(counter_cout));

MBIST_CounterBL BL_COUNTER (.clk(clk), .cen(mux41_cen[0] & count_enable), .rst(mux41_rst[0] | rst), .addr(counter_out_BL), .data(data_out_BL), .we(we_BL), .cout(cout_BL));
MBIST_CounterCH CH_COUNTER (.clk(clk), .cen(mux41_cen[1] & count_enable), .rst(mux41_rst[1] | rst), .addr(counter_out_CH), .data(data_out_CH), .we(we_CH), .cout(cout_CH));
MBIST_CounterMC MC_COUNTER (.clk(clk), .cen(mux41_cen[2] & count_enable), .rst(mux41_rst[2] | rst), .addr(counter_out_MC), .data(data_out_MC), .we(we_MC), .cout(cout_MC));
MBIST_CounterMA MA_COUNTER (.clk(clk), .cen(mux41_cen[3] & count_enable), .rst(mux41_rst[3] | rst), .addr(counter_out_MA), .data(data_out_MA), .we(we_MA), .cout(cout_MA));

Delay #(4) DELAY1(.clk(clk), .data_in(cdata_out), .data_out(delayed_out));
Delay #(8) DELAY2(.clk(clk), .data_in(sram_addr), .data_out(fail_addr));

MBIST_Mux21 #(4) MUX21_DATA (.data_in0(data_in),.data_in1(cdata_out),.sel(muxSel),.data_out(sram_data_in));
MBIST_Mux21 #(8) MUX21_ADDR (.data_in0(data_addr),.data_in1(addr_out),.sel(muxSel),.data_out(sram_addr));
MBIST_Mux21 #(1) MUX21_WE (.data_in0(we),.data_in1(we_out),.sel(muxSel),.data_out(sram_we));

SRAM RAM (.data_in(sram_data_in),.addr(sram_addr),.we(sram_we), .clk(clk),.data_out(sram_data_out));
MBIST_Comparator COMP (.data_in1(sram_data_out), .data_in2(delayed_out),.isEqual(comp_out));

assign fail = (muxSel && sram_we && comp_out !== 1'bx)?(comp_out?0:1):0;

endmodule
