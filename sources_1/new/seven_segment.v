`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/19 15:50:06
// Design Name: 
// Module Name: seven_segment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module seven_segment(input [3:0] num,
                     output reg [6:0] led);
always @(*) begin
        case(num)
            4'b0000:
            led <= 7'b0000001;//0
            4'b0001:
            led <= 7'b1001111;//1
            4'b0010:
            led <= 7'b0010010;//2
            4'b0011:
            led <= 7'b0000110; //3
            4'b0100:
            led <= 7'b1001100; //4
            4'b0101:
            led <= 7'b0100100;//5
            4'b0110:
            led <= 7'b0100000;//6
            4'b0111:
            led <= 7'b0001111; //7
            4'b1000:
            led <= 7'b0000000; //8
            4'b1001:
            led <= 7'b0000100; //9
            default:
            led <= 7'b0000001;//0
        endcase
    end
//    else begin
//        led <= 7'b0000001;//0
//    end
endmodule
