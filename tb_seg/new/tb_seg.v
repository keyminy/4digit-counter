`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/20 13:47:03
// Design Name: 
// Module Name: tb_seg
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


module tb_seg;

    reg clk;
    reg sw;
    wire [6:0] seg_thous, seg_hunds, seg_tens, seg_units;
    integer my_count = 0; integer tmp = 0;
    reg [3:0] thousand,hundred,tens,units;
    
    //generating clock
	always
		#5 clk = ~clk;
	initial begin
		clk = 0;
		sw = 0;
	end
    initial
    begin
        #0 sw = 0;
        # 5 sw = 1;
        # 20 sw = 0;
        # 100 sw = 0;
        # 200 sw = 1;
		#3000 $finish;
    end
    
     // 2Hz clock신호로 1000의자리, 100의자리, 10의자리 ,1의자리 구하는 로직    
    always @(posedge clk or posedge sw) begin
		if(sw) begin
			my_count = my_count + 1;
			//Assuming my_count = 3956, this results in thousand = 3, tmp = 956
			thousand <= (my_count - (my_count%1000)) / 1000; tmp = my_count % 1000;
			//tmp = 956 , hundred = 9 , tmp = 56
			hundred <= (tmp - (tmp%100)) / 100; tmp = my_count % 100;
			//tmp = 56, tens = 5, tmp = 6(=units)
			tens <= (tmp - (tmp%10)) / 10; tmp = my_count % 10;
			//units = 6
			units <= tmp % 10;
		end
		else begin
			//initialize the value
			my_count <=0; thousand <= 0; hundred <= 0; tens <= 0; units <=0;
		end
		if(my_count == 9999) begin
			//initialize the value
			my_count <=0; thousand <= 0; hundred <= 0; tens <= 0; units <=0;
		end
	end
	
     seven_segment thousand_seg (
        .num(thousand),
        .clk(clk),
        .sw(sw),
        .led(seg_thous)
    ); //1000의자리수 세븐세그먼트 
    seven_segment hunds_seg (
        .num(hundred),
        .clk(clk),
        .sw(sw),
        .led(seg_hunds)
    ); //100의자리수 세븐세그먼트 
    seven_segment tens_seg (
        .num(tens),
        .clk(clk),
        .sw(sw),
        .led(seg_tens)
    ); //10의자리수 세븐세그먼트 
    seven_segment units_seg (
        .num(units),
        .clk(clk),
        .sw(sw),
        .led(seg_units)
    ); //1의자리수 세븐세그먼트 
    
    
endmodule
