//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name: Liam Perreault
// Date: Nov 22 2022
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb ();

// parameters
parameter CLK_PERIOD = 10;
// registers and wires
reg clk;
reg rst;
reg button;
reg button_at_clk;
reg err;
wire [3:0] out;
reg [3:0] out_prev;

// assign initial values and clock generation
initial
begin
    err = 0;
    clk = 1'b0;
    rst = 1'b0;
    button = 1'b0;
    out_prev = out;
    forever
    begin
        #(CLK_PERIOD / 2) clk = ~clk;
    end
end

// drive inputs
initial
begin
    #10
    rst = 0;
    #30;
    rst = 1;
    #40
    button = 1;
    #120
    button = 0;
    #40
    button = 1;
    #30
    rst = 0;
    #40
    if (err == 0)
        $display("TEST PASSED!");
    $finish;
end

// store inputs used at state update
always @(posedge clk)
begin
    button_at_clk <= button;
end

// check correctness of output at negative edge of clock, after outputs have settled
always @(negedge clk)
begin
    if ((out == 3'b000) || (out == 3'b111)) begin
        $display("TEST FAILED! colour in a state that it should not be in.");
        err = 1;
    end else if (~button_at_clk && (out_prev != 3'b000) && (out_prev != 3'b111) && (out != out_prev)) begin
        $display("TEST FAILED! colour changed state when button was not pressed.");
        err = 1;
    end else if (button_at_clk && (out_prev <= 5 && out_prev >= 1) && (out != (out_prev + 1))) begin
        $display("TEST FAILED! colour did not change state when supposed to");
        err = 1;
    end else if (button_at_clk && (out != 3'b001) && (out_prev > 5 || out_prev == 0)) begin
        $display("TEST FAILED! colour did not change state when supposed to");
        err = 1;
    end
    out_prev = out;
end

// initialize module
dynamic_lights top (
    .clk(clk),
    .rst(rst),
    .button(button),
    .colour(out)
);

endmodule
