`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   dec_3to8.v
// Project:     Lab 7
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:11/12 - Created the instruction register to hold 16-bits of information.
//
// Purpose:     Register that takes in a 16-bit command from external memory to
//					 tell the IDP what operations to perfrom.
//////////////////////////////////////////////////////////////////////////////////
module Instruction_Reg( clk, reset, ld, D_in, IR_out );
	input 		  	   clk, reset, ld;
	input  	  [15:0] D_in;
	output reg [15:0] IR_out;
	
	always @ ( posedge clk, posedge reset )
		if ( reset == 1'b1 )
			IR_out <= 16'b0;
		else  begin
			if ( ld == 1'b1 )
				IR_out <= D_in;
			else
				IR_out <= IR_out;
		end
	
endmodule
