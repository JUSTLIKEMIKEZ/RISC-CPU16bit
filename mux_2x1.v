`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////
// File Name:   mux_2x1.v
// Project:     Lab 6
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:10/25 - Created the 2 to 1 mux using a case statement.
//
// Purpose:     2 to 1 multiplexer that takes two 16-bit values and selects one.
//
//////////////////////////////////////////////////////////////////////////////////
module mux_2x1( D, S, Y );
	input 	  [31:0] D;
	input  			   S; //select
	output reg [15:0] Y; //output
	
	always @ ( * ) 
		case( S )
			1'b0   : Y = D[31:16]; //S
			1'b1   : Y = D[15: 0]; //DS
			default: Y = 16'b0;    //default to 0
		endcase
	
endmodule
