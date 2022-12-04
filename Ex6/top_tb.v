//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb ();

parameter CLK_PERIOD = 10;

reg clk;
reg [2:0] colour;
reg enable;
reg [4:0] i;
wire [23:0] rgb;

initial
begin
clk = 0;
colour = 0;
i = 0;
enable = 1;
forever begin
    # (CLK_PERIOD / 2) clk = ~clk;
end
end

initial begin
    #30
    colour = 1;
    #20
    colour = 5;
    #30
    colour = 7;
    #20
   $finish;
end

blk_mem_gen_0 converter (
    .addra(colour),
    .clka(clk),
    .ena(enable),
    .douta(rgb)
);

endmodule
