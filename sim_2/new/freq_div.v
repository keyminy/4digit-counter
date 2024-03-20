//`timescale 1ns / 10ps
`timescale 1us / 1ns


module freq_div(mclk,rst,clk_div);
	input mclk,rst;
	output reg clk_div;
	//reg [14:0] cnt;
	reg [3:0] cnt;
	
    always @(posedge mclk or negedge rst) begin
        if (!rst) begin
            // Reset condition
            cnt <= 0;
            clk_div <= 0;
        end
        else begin
            // Increment the counter on each clock cycle
            cnt <= cnt + 1;
            
            // Output the MSB of the counter as the divided clock
            // Modify the counter width and the MSB index as per your desired division ratio
            clk_div <= cnt[3]; // Change 3 to appropriate index for your desired division ratio
        end
    end
endmodule