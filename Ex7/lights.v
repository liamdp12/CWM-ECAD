//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name: Liam Perreault
// Date: Nov 22 2022
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////
// rst is never used, although not sure when it should be used, as not specified what to reset to
module dynamic_lights (
    input wire clk,
    input wire rst,
    input wire button,
    output reg [2:0] colour
);

// update to next state at positive edge of clk
always @(posedge clk)
begin
    case (colour)
        1, 2, 3, 4, 5: colour = (button) ? (colour + 1) : colour;
        6: colour = (button) ? 3'b001 : 3'b110;
        default: colour = 1; 
    endcase
end

endmodule
