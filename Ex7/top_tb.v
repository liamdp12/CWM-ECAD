//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb () ;
    
    parameter CLK_PERIOD = 10;

    reg clk;
    reg rst;
    reg button;
    reg sel;
    wire [23:0] light;

    initial
    begin
    clk = 0;
    rst = 0;
    button =  0;
    sel = 0;
    forever begin
        # (CLK_PERIOD / 2) clk = ~clk;
    end
    end

    initial
    begin
    #10
    button = 0;
    #20
    button = 1;
    #30
    sel = 1;
    #50
    button = 0;
    #30
    sel = 0;
    #30
    $finish;
    end

    
    // instantiate module
    lights_selector top (
        .clk(clk),
        .sel(sel),
        .rst(rst),
        .button(button),
        .light(light)
    );

endmodule
