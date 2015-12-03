`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   Mem_DumpCounter.v
// Project:     Lab 8
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:11/28 - Created the memory dump counter.
//
// Purpose:     16-bit counter used to view the contents of memory by being sent 
//					 into a multiplexer for the memeory address.
//////////////////////////////////////////////////////////////////////////////////
module Mem_DumpCounter(clk, reset, mem_counter);
	
	//input declarations
	input 				clk, reset;
	
	//output declarations
	output reg [15:0] mem_counter;
	
	
	always @ (posedge clk, posedge reset)
		if(reset == 1'b1)
			mem_counter = 16'h0000;
		else
			mem_counter = mem_counter + 16'b1;

endmodule
