`timescale 1ns / 1ps

module MBIST_CounterMC
(input clk, cen, rst,
output [7:0] addr,
output reg [3:0] data,
output reg we,cout);

reg [10:0]counter;
wire [2:0]stage;
wire [7:0]delay_wire;
wire temp;
reg pass;
reg [7:0]delay;
assign temp = pass?4'b1111:4'b0000;
assign stage = counter[10:8];
always @(posedge clk) begin
    if (rst)
    begin
        we <= 1;
        counter <= 0;
        data <= 4'b0000;
        pass <= 0;
        cout <= 0;
    end
    else if (cen)
    begin
        case(stage)
        //w0
        0:begin
            data <= 4'b0000; 
            we <= 1;
            if(counter[7:0] == 255)
                pass <= 0;
            counter <= counter + 1;
          end
         //ro w1
        1:begin
            we <= pass;
            data <= temp;
            if(counter[7:0] == 255 && pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else begin
                pass <= pass + 1;
                counter <= counter;
            end
          end
          
          //r1 w0
         2:begin
            we <= pass;
            data <= ~temp;
            if(counter[7:0] == 255 && pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else
            begin
                pass <= pass + 1;
                counter <= counter;
            end
          end
          //r0 w1
         3:begin
            we <= pass;
            data <= temp;
            if(counter[7:0] == 255 && pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else
            begin
                pass <= pass + 1;
                counter <= counter;
            end
          end
          
         //r1 w0
         4:begin
            we <= pass;
            data <= ~temp;
            if(counter[7:0] == 255 && pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 1)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else
            begin
                pass <= pass + 1;
                counter <= counter;
            end
          end
           //r0
         5:begin
            we <= pass;
            data <= temp;
            if(counter[7:0] == 255 && pass == 0)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 0)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else
            begin
                pass <= pass + 1;
                counter <= counter;
            end
          end
          default : begin
                        we <= 0;
                        counter <= counter;
                        data <= 4'b0000;
                        cout <= 1;
                    end
          
        endcase
    end
    delay <= delay_wire;
end
assign delay_wire = (stage<3) ? counter[7:0]: 255-counter[7:0];
assign addr = delay;

endmodule