`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS301
// Engineer: Lopez, Christopher
//				 Sim, David
// Email: 	davidjoshuasim@gmail.com,
//				chrislopezjunior@gmail.com
// 
// Create Date: Aug 26, 2015
// Design Name: Lab_7_CPU_Execution_Unit
// Module Name: clk_500_Hz.v
// Target Devices: Spartan 6 xc6slx
// Tool Versions: Xilinx 14.7
// Descriptions: 
//
// Dependencies: 
// 
// Purpose: A simple 3-to-8 decoder. Input is a 3-bit vector while the outputs
//				are eight separate variables. 
//
// Revisions:  0.1 - created file
//	
// Notes: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder_3to8(in, en,
						  y7, y6, y5, y4, y3, y2, y1, y0);
		input 			en;				  
		input 	[2:0]	in; 
		
		output 	y7, y6, y5, y4, y3, y2, y1, y0;
	
	// Rather than using a case statement, a logical implementation was used. 
	assign {y7, y6, y5, y4, y3, y2, y1, y0} = ({en,in} == 4'b1_000 ) ? 8'b00000001 :
		({en,in} == 4'b1_001) ? 8'b00000010 : 
		({en,in} == 4'b1_010) ? 8'b00000100 :
		({en,in} == 4'b1_011) ? 8'b00001000 :
		({en,in} == 4'b1_100) ? 8'b00010000 :
		({en,in} == 4'b1_101) ? 8'b00100000 :
		({en,in} == 4'b1_110) ? 8'b01000000 : 
		({en,in} == 4'b1_111) ? 8'b10000000 : 8'b00000000;
endmodule
