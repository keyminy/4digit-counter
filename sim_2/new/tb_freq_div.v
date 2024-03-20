//`timescale 1ns / 10p/s
`timescale 1us / 1ns

module tb_freq_div;
    reg mclk,rst;
    wire clk_div;

    freq_div dut(
        .mclk(mclk)
        ,.rst(rst)
        ,.clk_div(clk_div)
     );

	initial begin
		mclk = 1'b0;
		repeat(1000000) #0.5 mclk <= ~mclk;
	end
    
    initial begin
        rst = 1'b0;
        #20 rst = 1'b1;
    end

endmodule
