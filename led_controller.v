`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Filename:   led_controller.v 
//
// Author:     Steven Le
//			   	Michael Handria
//
// Email:     lesteven224@yahoo.com
//				  michaelhandria@gmail.com
//
//
// Date:9/23 -file created 
//
// Notes:     This module is the LED controller that must decide which annode
//				  will turn on and what will be displayed on the annode
//
// Dependency: clk_500Hz.v (this will refresh the display every 20ms making
//								    the display apprear to be all on at the same 
//								    time)
// 
//////////////////////////////////////////////////////////////////////////////////
module led_controller( clk, reset, anodes, seg_sel );
	
	//input declaration
	input        clk, reset;
	
	//output declaration
	output [7:0] anodes;
	output [2:0] seg_sel;
	
	reg    [7:0] anodes;
	reg	 [2:0] seg_sel;
	
	reg 	 [2:0] PS, NS;
	
/*********************************************************/
/*                  Next State Logic                     */
/*********************************************************/

	always @ ( PS )
		case ( PS )
			3'b000 : NS = 3'b001;
			3'b001 : NS = 3'b010;
			3'b010 : NS = 3'b011;
			3'b011 : NS = 3'b100;
			3'b100 : NS = 3'b101;
			3'b101 : NS = 3'b110;
			3'b110 : NS = 3'b111;
			3'b111 : NS = 3'b000;
			default: NS = 3'b000;
		endcase




		
/*********************************************************/
/*                     State Register                    */
/*********************************************************/

	always @ ( posedge clk, posedge reset )
		if ( reset == 1'b1 )
			PS = 3'b000;
		else
			PS = NS;
			
/*********************************************************/
/*                    Output Logic                       */
/*********************************************************/

	always @ ( PS )
		case ( PS )
			3'b000 : { anodes, seg_sel } = 11'b11111110_000;
			3'b001 : { anodes, seg_sel } = 11'b11111101_001;
			3'b010 : { anodes, seg_sel } = 11'b11111011_010;
			3'b011 : { anodes, seg_sel } = 11'b11110111_011;
			3'b100 : { anodes, seg_sel } = 11'b11101111_100;
			3'b101 : { anodes, seg_sel } = 11'b11011111_101;
			3'b110 : { anodes, seg_sel } = 11'b10111111_110;
			3'b111 : { anodes, seg_sel } = 11'b01111111_111;
			default: { anodes, seg_sel } = 11'b11111111_000;
		endcase
		
endmodule 