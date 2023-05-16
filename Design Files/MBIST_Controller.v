`timescale 1ns / 1ps

module MBIST_Controller(input start, rst, clk, cout, output isTesting, cen);
parameter RESET = 0, TEST = 1, DONE = 2; 
reg [1:0]state;
always @ (posedge clk) begin
    if (rst)
        state <= RESET;
    else
        case(state)
            RESET: if (start)
                        state <= TEST;
                    else
                        state <= RESET;
                        
            TEST: if (cout)
                        state <= DONE;
                   else
                        state <= TEST;
                        
            DONE: state <= DONE;
            
            default:
                    state <= RESET;
        endcase
end
assign cen = (state == TEST) ? 1'b1 : 1'b0;
assign isTesting = (state == TEST) ? 1'b1 : 1'b0;



endmodule
