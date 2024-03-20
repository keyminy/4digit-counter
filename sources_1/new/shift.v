`timescale 1ns / 1ps

module shift(input clk,
             input sw,
             output reg [3:0] mode_out,
             output reg [6:0] seg_out);
    
    
    always @(posedge clk or sw) begin
        if (sw) begin
            mode_out <= {mode_out[2:0], mode_out[3]}; // Shift operation
        end
		else begin
			mode_out <= 4'b0001;
            seg_out <= 7'b0000001; // Reset state for seg_out(= 0)
		end
    end
    
    always @(*) begin
        case (mode_out)
            4'b0001: seg_out <= 7'b0000001;//0
            4'b0010: seg_out <= 7'b0000001;//0
            4'b0100: seg_out <= 7'b0000001;//0
            4'b1000: seg_out <= 7'b0000001;//0
            default: seg_out <= 7'b0000001;//0
        endcase
    end
endmodule
