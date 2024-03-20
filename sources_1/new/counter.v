`timescale 1ns / 1ps

module counter(
    input wire clk,
    input wire sw,
    output wire [6:0] led,
    output wire[3:0] mode_out,
    output wire clk5MHz,
    output wire clk2Hz
);
    wire [6:0] seg_thous, seg_hunds, seg_tens, seg_units;
    integer my_count = 0; integer tmp = 0;
    reg [3:0] thousand,hundred,tens,units;
    reg [3:0] mode_tmp;
    reg [6:0] seg_tmp;
    
    assign led = seg_tmp;
    assign mode_out = mode_tmp;

    //instantiate
    clk_wiz_0 wizclk(
        .clk_out1(clk5MHz),
        .clk_in1(clk)
    );
    //5MHz to 2Hz
    clkDiv wantedClk(
        .i_clk(clk5MHz),
        .clk_div(clk2Hz)
    );
    
     // 2Hz clock신호로 1000의자리, 100의자리, 10의자리 ,1의자리 구하는 로직    
    always @(posedge clk2Hz) begin
        if(sw) begin
			my_count = my_count + 1;
			//Assuming my_count = 3956, this results in thousand = 3, tmp = 956
			thousand = (my_count - (my_count%1000)) / 1000; tmp = my_count % 1000;
			//tmp = 956 , hundred = 9 , tmp = 56
			hundred = (tmp - (tmp%100)) / 100; tmp = my_count % 100;
			//tmp = 56, tens = 5, tmp = 6(=units)
			tens = (tmp - (tmp%10)) / 10; tmp = my_count % 10;
			//units = 6
			units = tmp % 10;            
        end
         else if(my_count == 9999) begin
                //initialize the value
                my_count <=0; thousand <= 0; hundred <= 0; tens <= 0; units <=0;
         end
        else begin
            my_count <=0; thousand <= 0; hundred <= 0; tens <= 0; units <=0;
		end
	end
	
    always @(posedge clk5MHz) begin
        if (sw) begin
            mode_tmp <= {mode_out[2:0], mode_out[3]}; // Shift operation
        end
		else begin
			mode_tmp <= 4'b0001;
			//I think.. This was the cause of the error.
//            led <= 7'b0000001; // Reset state for seg_out(= 0)
		end
    end
	
	always @(posedge clk5MHz) begin
        case (mode_out)
            4'b0001: seg_tmp <= seg_tens;
            4'b0010: seg_tmp <= seg_hunds;
            4'b0100: seg_tmp <= seg_thous;
            4'b1000: seg_tmp <= seg_units;
            default: seg_tmp <= 7'b0000001;
        endcase
    end
	
   seven_segment thous_seg(
        .num(thousand),
        .led(seg_thous)
     );   
     seven_segment hunds_seg(
        .num(hundred),
        .led(seg_hunds)
     );   
     seven_segment tens_seg(
        .num(tens),
        .led(seg_tens)
     );   
     seven_segment units_seg(
        .num(units),
        .led(seg_units)
     );

    
endmodule