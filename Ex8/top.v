//////////////////////////////////////////////////////////////////////////////////
// Exercise #8  - Simple End-to-End Design
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design an air conditioning systems
//
//  inputs:
//           rst_n, clk_n, clk_p, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


module top(
    input rst_n,
    input clk_p,
    input clk_n,
    input wire [4:0] temperature,
    output wire heating,
    output wire cooling
     //Todo: add all other ports besides clk_n and clk_p 
   );
    

   /* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
        
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );

    aircon ac (
        .clk(clk),
        .temperature(temperature),
        .heating(heating),
        .cooling(cooling)
    );

//Add logic here

endmodule
