`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:15 11/29/2015 
// Design Name: 
// Module Name:    Mem_DumpCounter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mem_DumpCounter(clk, reset, mem_counter);
	
	input clk, reset;
	
	output reg [15:0] mem_counter;
	
	
	always @ (posedge clk, posedge reset)
		if(reset == 1'b1)
			mem_counter = 16'h0000;
		else
			mem_counter = mem_counter + 1;

endmodule
