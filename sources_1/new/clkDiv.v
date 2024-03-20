`timescale 1ns / 1ps

module clkDiv(i_clk,clk_div);
	input i_clk;
	output reg clk_div;
	reg [21:0] cnt; //22bits
	
	initial begin
        // Reset condition
         cnt <= 0;
         clk_div <= 0;
     end
     
    always @(posedge i_clk) begin
            // Increment the counter on each clock cycle
            cnt <= cnt + 1;
            // Output the MSB of the counter as the divided clock
            // Modify the counter width and the MSB index as per your desired division ratio
            //50MHz to 2Hz
            clk_div <= cnt[21];
    end
endmodule
