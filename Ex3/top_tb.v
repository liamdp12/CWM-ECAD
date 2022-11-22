//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: Nov 21 2022 
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
reg clk;
reg rst;
reg change;
reg on_off;
wire [7:0] out;
reg [7:0] out_prev;

// inputs to counter at clock edge
reg rst_at_clk;
reg change_at_clk;
reg on_off_at_clk;

reg err;
//Todo: Clock generation
initial
begin
	clk = 1'b0;
	forever
	 #(CLK_PERIOD/2) clk = ~clk;
end

//Todo: User logic
//Drive inputs
initial
begin
  rst = 1;
  change =  0;
  on_off = 1;
  err = 0;

  #40
  rst = 0;
  #40
  change = 1;
  #100
  change = 0;
  #40
  change = 1;
  #100
  on_off = 0;  
  #40
  if (err == 0)
    $display("TEST PASSED");
  $finish;
end

// store values input to counter at positive edge of clk
// out will also change at this point
always @(posedge clk)
begin
  rst_at_clk <= rst;
  change_at_clk <= change;
  on_off_at_clk <= on_off;
end

// check outputs on negative edge of clock, after outputs have settled
always @(negedge clk)
begin
if (rst_at_clk && out != 0)
  begin
  $display("TEST FAILED! Reset does not appear to be working. rst=%d, out=%d, previous_out = %d, change=%d, on_off=%d", rst_at_clk, out, out_prev, change_at_clk, on_off_at_clk);
  err = 1;
  end
else if (~rst_at_clk && ~change_at_clk && (out != out_prev))
  begin
  $display("TEST FAILED! Output changed when not supposed to. rst=%d, out=%d, previous_out = %d, change=%d, on_off=%d", rst_at_clk, out, out_prev, change_at_clk, on_off_at_clk);
  err = 1;
  end
else if (~rst_at_clk && change_at_clk && on_off_at_clk && (out != out_prev + 1))
  begin
  $display("TEST FAILED! Output did not increase when supposed to");
  err = 1;
end
else if (~rst_at_clk && change_at_clk && ~on_off_at_clk && (out != out_prev -1 ))
  begin 
  $display("TEST FAILED! Output did not decrease when suposed to");
  err = 1;
end
out_prev = out;
end

//Todo: Finish test, check for success
/*
initial begin
  # 50
  if (err == 0)
    $display("****TEST PASSED***");
  $finish;
  end
*/
//Todo: Instantiate counter module
 monitor top (
.clk(clk),
.rst(rst),
.change(change),
.on_off(on_off),
.counter_out(out)
);
endmodule 
