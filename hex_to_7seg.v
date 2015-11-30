`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   hex_to_7seg.v
// Project:     Lab 7
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date: 9/23 - Created the hex to 7 segment display module by creating a case
//					 to declare what happens with each combination on the display (0-F)
//
// Purpose:     This module converts a hexadecimal value so that it can be
//					 displayed on a 7 segment display by asserting and deasserting
//					 the active low components of the display (a-g).
//////////////////////////////////////////////////////////////////////////////////
module hex_to_7seg( hex, hex_out);
  
	//input declaration 
	input  [3:0] hex;
	
	//output declaration
   output [6:0] hex_out;
	reg    [6:0] hex_out;
	
	always @ ( hex )
		case ( hex )             //abcdefg
			4'b0000: {hex_out} = 7'b0000001; //7 segment display for 0
			4'b0001: {hex_out} = 7'b1001111; //7 segment display for 1
			4'b0010: {hex_out} = 7'b0010010; //7 segment display for 2
			4'b0011: {hex_out} = 7'b0000110; //7 segment display for 3
			4'b0100: {hex_out} = 7'b1001100; //7 segment display for 4
			4'b0101: {hex_out} = 7'b0100100; //7 segment display for 5
			4'b0110: {hex_out} = 7'b0100000; //7 segment display for 6
			4'b0111: {hex_out} = 7'b0001111; //7 segment display for 7
			4'b1000: {hex_out} = 7'b0000000; //7 segment display for 8
			4'b1001: {hex_out} = 7'b0000100; //7 segment display for 9
			4'b1010: {hex_out} = 7'b0001000; //7 segment display for A
			4'b1011: {hex_out} = 7'b1100000; //7 segment display for b
			4'b1100: {hex_out} = 7'b0110001; //7 segment display for C
			4'b1101: {hex_out} = 7'b1000010; //7 segment display for d
			4'b1110: {hex_out} = 7'b0110000; //7 segment display for E
			4'b1111: {hex_out} = 7'b0111000; //7 segment display for F
			default: {hex_out} = 7'b1111111; //default is blank display
		endcase
	
endmodule 