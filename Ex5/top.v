//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Liam Perreault
// Date: Nov 22 2022
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////

module aircon (
    input wire clk,
    input wire [4:0] temperature,
    output wire heating,
    output wire cooling
);

// variable to hold state. 1st bit controls heating, 2nd bit controls cooling
reg [1:0] state;

always @(posedge clk)
begin
    if (state == 2'b10 && temperature < 20)
        state = 2'b10;
    else if (state == 2'b00 && temperature <= 18)
        state = 2'b10;
    else if (state == 2'b00 && temperature >= 22)
        state = 2'b01;
    else if (state == 2'b01 && temperature > 20)
        state = 2'b01;
    else
        state = 2'b00;
end

assign heating = state[1];
assign cooling = state[0];

endmodule
