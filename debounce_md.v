`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   debounce_md.v
// Project:     Lab 7
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date: 11/1 - created to instantiate a clock divider and a debounce module
//
// Note:		    This module depends on a 500Hz clock so that it can check the
//					 inputs over the period of 20ns and a debounce module that will 
//					 provide a one shot pulse.
//
// Purpose:     to instantiate the debounce module and the clock divider. into 
//					 one whole module
//////////////////////////////////////////////////////////////////////////////////
module debounce_md(clk, reset, D_in, D_out);

	//dbounce_md IO decleration
	input clk, reset;
	input D_in;
	
	output D_out;
	
	//temp wire that will go into the deboune clk.
	wire clk_out;
	
	
	//clk divider that will provide a 20ns clk or 500Hz clk
	clk_500Hz clk_div( .clk_in(clk), .reset(reset), .clk_out(clk_out));
	
	//provides the one shot pulse 
	debounce db( .clk(clk_out), .reset(reset), .D_in(D_in), .D_out(D_out));
	
	

endmodule
