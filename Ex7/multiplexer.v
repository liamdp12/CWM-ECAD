//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 - Doorbell Chime
// Student Name: Liam Perreault
// Date: Nov 20 2022
//
//  Description: In this exercise, you need to design a multiplexer that chooses between two sounds, where the  
//  output is delayed by 5 ticks (not clocks!) and acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module multiplexer(
    //Todo: define inputs here
    input wire [23:0] a,
	    input wire [23:0] b,
	    input wire sel,
	    output wire [23:0] out
    );
    
    //Todo: define your logic here                 
	assign out = sel ? b : a; 
endmodule
