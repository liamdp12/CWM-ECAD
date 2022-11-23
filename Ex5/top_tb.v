//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Liam Perreault
// Date: Nov 22 2022
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb ();
    // parameters
    parameter CLK_PERIOD = 10;

    // wires and registers
    reg clk;
    reg [4:0] temperature;
    reg [4:0] temp_at_clk;
    wire heating;
    wire cooling;
    reg prev_heating;
    reg prev_cooling;
    reg err;

    // clock generation and initializing values
    initial
    begin
        clk = 1'b0;      
        forever
        begin
            # (CLK_PERIOD / 2) clk = ~clk;
        end
    end

    // get temperature input at clk edge
    always @(posedge clk)
    begin
        temp_at_clk <= temperature;
    end

    // drive logic
    initial
    begin
        temperature = 15;
        prev_heating = heating;
        prev_cooling = cooling;
        err = 0;
        #10
        while (temperature <= 24) begin
            temperature = temperature + 1;
            #10;
        end
        while (temperature >= 16) begin
            temperature = temperature - 1;
            #5;
        end
        temperature = 15;
        while (temperature <= 24) begin
            temperature = temperature + 2;
            #30;
        end
        while (temperature > 16) begin
            temperature = temperature - 2;
            #30;
        end
        #20
        if (err == 0)
            $display("TEST PASSED");
        $finish;
    end

    // check logic is working properly
    always @(negedge clk)
    begin
        if (heating && cooling) begin
            $display("TEST FAILED! Both heating and cooling on at the same time");
            err = 1;
        end 
        else if (~heating && ((temp_at_clk < 20 && prev_heating) || (temp_at_clk <= 18 && ~prev_heating && ~prev_cooling))) begin
            $display("TEST FAILED! Heating not turned on when supposed to");
            err = 1;
        end
        else if (~(~heating && ~cooling) && ((temp_at_clk >= 20 && prev_heating) || (temp_at_clk <= 20 && prev_cooling) || (temp_at_clk > 18 && temp_at_clk < 22 && ~prev_heating && ~prev_cooling))) begin
            $display("TEST FAILED! State not in idle when supposed to");
            err = 1;
        end
        else if (~cooling && ((temp_at_clk >= 22 && ~prev_heating) || (temp_at_clk > 20 && prev_cooling))) begin
            $display("TEST FAILED! State not cooling when supposed to");
            err = 1;
        end
        prev_cooling <= cooling;
        prev_heating <= heating;
    end
 
    // initialize aircon module
    aircon top (
        .clk(clk),
        .temperature(temperature),
        .heating(heating),
        .cooling(cooling)
    );

endmodule
