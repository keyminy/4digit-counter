`timescale 1ns / 1ns

module tb_counter;
    reg clk;
    reg sw;
   
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial
    begin
        #0 assign sw = 0;
        # 5 assign sw = 1;
        # 20 assign sw = 0;
        # 100 assign sw = 0;
        # 200 assign sw = 1;
    end
   
    //instantiation
    counter my_counter(
        .clk(clk),
        .rst(rst)
    );
endmodule
