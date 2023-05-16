`timescale 1ns / 1ps

module MBIST_CounterMA
(input clk, cen, rst,
output [7:0] addr,
output reg [3:0] data,
output reg we,cout);

reg [10:0]counter;
wire [2:0]stage;
wire [7:0]delay_wire;
reg [1:0]pass;
reg [7:0]delay;
wire [3:0]temp;
assign stage = counter[10:8];
assign temp = pass[0]?4'b1111:4'b0000;

always @(posedge clk) begin
    if (rst)
    begin
        we <= 1;
        counter <= 0;
        pass <= 0;
        data <= 4'b0000;
        cout <= 0;
    end
    else if (cen)
    begin
        case(stage)
        //w0
        0:begin
            we <= 1;
            data <= 4'b0000;
            if(counter[7:0] == 255)
                pass <= 0;
            counter <= counter + 1;
          end
         //r0 w1 w0 w1
        1:begin
            we <= (pass[0] | pass[1]);
            data <= temp;
            if(counter[7:0] == 255 && pass == 3)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            
            else if(pass == 3)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else begin
                pass <= pass + 1;
                counter <= counter;
            end
          end
          
          //r1 w0 w1
         2:begin
            we <= (pass[0] | pass[1]);
            data <= ~temp;
            if(counter[7:0] == 255 && pass == 2)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 2)
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
          //r1 w0 w1 w0
         3:begin
            we <= (pass[0] | pass[1]);
            data <= ~temp;
            if(counter[7:0] == 255 && pass == 3)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 3)
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
          
         //r0 w1 w0
         4:begin
            we <= (pass[0] | pass[1]);
            data <= temp;
            if(counter[7:0] == 255 && pass == 2)
            begin
                pass <= 0;
                counter <= counter + 1;
            end
            else if(pass == 2)
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