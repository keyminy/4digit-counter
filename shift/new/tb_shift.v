`timescale 1ns / 1ps

module tb_shift;
reg clk;
reg sw;

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
		#1000 $finish;
    end

	//instantiation
    shift my_shift(
        .clk(clk),
        .sw(sw)
    );

endmodule
