`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   dec_3to8.v
// Project:     Lab 5
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:10/14 - Created the 3 to 8 decoder using a case statement.
//
// Purpose:     Decoder to select an enable to one of the eight 16-bit registers.
//////////////////////////////////////////////////////////////////////////////////
module dec_3to8(in, en, y);
	
	//input declaration
	input [2:0]	 in;
	input 		 en;
	
	//output declaration
	output [7:0]  y;
	reg 	 [7:0]  y;
	
	always @ (*) begin
		case({en,in})
			4'b1_000: y = 8'b00000001;
			4'b1_001: y = 8'b00000010;
			4'b1_010: y = 8'b00000100;
			4'b1_011: y = 8'b00001000;
			4'b1_100: y = 8'b00010000;
			4'b1_101: y = 8'b00100000;
			4'b1_110: y = 8'b01000000;
			4'b1_111: y = 8'b10000000;
			default: y = 8'h0;
		endcase
	end
			
			
endmodule
