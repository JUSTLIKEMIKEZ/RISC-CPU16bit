`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   alu.v
// Project:     Lab 7
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:10/25 - Created the arithmetic logic unit using the template online.
//
// Purpose:     Module that performs basic arithmetic functions to the 16-bit pieces
//					 of data that are sent in. There are 13 operations that can be used
//					 based on the Alu_Op input. The module will also tell if the output
//					 is negative, zero, or has a carry via flags.
//
//////////////////////////////////////////////////////////////////////////////////
module alu (R, S, Alu_Op, Y, N, Z, C );

	input [15:0] R, S;
	input [3:0] Alu_Op;
	output reg		 	N, Z, C;
	output reg [15:0] Y;
	
	always @( R or S or Alu_Op) begin
		case (Alu_Op)
			4'b0000:	{C,Y} = {1'b0,S}; 			// pass S
			4'b0001:	{C,Y} = {1'b0,R}; 			// pass R
			4'b0010:	{C,Y} = S + 1'b1; 			// Increment S
			4'b0011:	{C,Y} = S - 1'b1; 			// Decrement S
			4'b0100:	{C,Y} = R + S; 				// add
			4'b0101:	{C,Y} = R - S;					// subtract
			4'b0110:	begin								// right shift S (logic)
							C = S[0];
							Y = S >> 1;
						end
			4'b0111:	begin								// left shift S (logic)
							C = S[15];
							Y = S << 1;
						end
			4'b1000:	{C,Y} = {1'b0, R & S}; 		// logic and
			4'b1001:	{C,Y} = {1'b0, R | S}; 		// logic or
			4'b1010:	{C,Y} = {1'b0, R ^ S};		// logix xor
			4'b1011: {C,Y} = {1'b0,~S};			// logic not S (1's comp)
			4'b1100:	{C,Y} = 1'b0 - S;				// negate S
			default: {C,Y} = {1'b0, S}; 			// pass S for default
		endcase
		
		//handle last two status flags
		N = Y[15];
		if (Y == 16'b0)
			Z = 1'b1;
		else
			Z = 1'b0;
	end // end always
	
endmodule
