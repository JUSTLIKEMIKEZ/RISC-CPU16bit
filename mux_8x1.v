`timescale 1ns / 1ps
 //////////////////////////////////////////////////////////////////////////////////
// File Name:   mux_8x1.v
// Project:     Lab 7
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date: 10/19 - File Created 
//
// Notes:     This module an 8 to 1 mux that will decide which anode will be turned
//				  on and which will be turned off
//
// Dependency: clk_500Hz.v (this will refresh the display every 20ms making
//								    the display apprear to be all on at the same 
//								    time)
//
//////////////////////////////////////////////////////////////////////////////////
module mux_8x1( D, sel, Y );
	
	//input declaration
	input  [31:0] D;
	input  [ 2:0] sel;
	
	//output declaration
	output [ 3:0] Y;
	reg 	 [ 3:0] Y;
	
	//depending on the selects there will be different 
	//outputs to the 
	always @ ( * )
		case ( sel )
			3'b000  : Y = D[ 3: 0];
			3'b001  : Y = D[ 7: 4];
			3'b010  : Y = D[11: 8];
			3'b011  : Y = D[15:12];
			3'b100  : Y = D[19:16];
			3'b101  : Y = D[23:20];
			3'b110  : Y = D[27:24];
			3'b111  : Y = D[31:28];
			default : Y = 4'b0000 ;
		endcase
		
endmodule 
