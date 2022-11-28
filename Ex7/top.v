//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name: Liam Perreault
// Date: Liam Perreault
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////

module lights_selector (
    input wire clk,
    input wire sel,
    input wire rst,
    input wire button,
    output wire [23:0] light
)
;

// instantiate wires and regs
wire [2:0] colour;
wire enable;
wire [23:0] rgb;
wire [23:0] white;

assign enable = 1'b1; // not sure what this value is meant to be - output of dynamic lights?
assign white = 24'hFFFFFF;

dynamic_lights lights (
    .clk(clk),
    .rst(rst),
    .button(button),
    .colour(colour)
);

blk_mem_gen_0 converter (
    .clka(clk),
    .ena(enable),
    .addra(colour),
    .douta(rgb)
);

multiplexer mux (
    .a(white),
    .b(rgb),
    .sel(sel),
    .out(light)
);

endmodule
