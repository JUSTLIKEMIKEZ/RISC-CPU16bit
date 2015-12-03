`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   display_controller.v
// Project:     Lab 8
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date: 10/5 - Created the display controller module.
//
// Purpose:     Display controller for the Nexys 4 board to use the eight anodes
//					 to display values based on a hex to seven segment module.
//////////////////////////////////////////////////////////////////////////////////
module display_controller( clk, reset, seg_in, A, seg_out );
	
	//input declaration
	input 		 clk, reset;
	input [31:0] seg_in;
	
	//output declaration
	output [7:0] A;
	output [6:0] seg_out;
	
	//wire declaration
	wire 		  clk_out;
	wire [2:0] seg_sel;
	wire [3:0] hex_in;
	
	//led clk to refresh every 20 ms
	clk_500Hz 			led_clk( .clk_in(clk), .reset(reset), .clk_out(clk_out));
	
	//decides what will be displayed
	mux_8x1				mux( .D(seg_in), .sel(seg_sel), .Y(hex_in));
	
	//controlls how the LED looks like
	led_controller 	led( .clk(clk_out), .reset(reset), 
								  .anodes(A), .seg_sel(seg_sel));
	
	//hex to 7 segment that will display 
	hex_to_7seg			hex( .hex(hex_in), .hex_out(seg_out));
	
endmodule
