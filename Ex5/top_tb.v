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
    CLK_PERIOD = 10;

    // wires and registers
    reg clk;
    reg [4:0] temperature;
    wire heating;
    wire cooling;
    reg prev_heating;
    reg prev_cooling;
    reg err;

    // clock generation and initializing values
    initial
    begin
        clk = 1'b0;
        temperature = 0;
        prev_heating = heating;
        prev_cooling = cooling; 
        
        forever
        begin
            # (CLK_PERIOD / 2) clk = ~clk;
        end
    end

    // drive logic - TODO

    // check logic is working properly
    always @(negedge clk)
    begin
        if (heating && cooling) begin
            $display("TEST FAILED! Both heating and cooling on at the same time");
            err = 1;
        end else if (~heating || ((temperature < 20 && prev_heating) || (temperature <= 18 && ~prev_heating && ~prev_cooling)) begin
            $display("TEST FAILED! Heating not turned on when supposed to");
            err = 1;
        end else if ((~heating && ~cooling) && ((temp >= 20 && prev_heating) || (temp <= 20 && prev_cooling) || (temp > 18 && temp < 22 && ~prev_heating && ~prev_cooling) begin
            $display("TEST FAILED! State not in idle when supposed to");
            err = 1;
        end else if (~cooling && ((temp >= 22 && ~prev_heating) || (temp > 20 && prev_cooling)) begin
            $display("TEST FAILED! State not cooling when supposed to");
            err = 1;
        end
        prev_cooling <= cooling;
        prev_heating <= heating;
    end
 
    // initialize aircon module
    aircon top (
        .clk(clk),
        .temperature(temperature)
    );

endmodule
