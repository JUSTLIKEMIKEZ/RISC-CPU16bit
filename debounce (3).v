`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   debounce.v
// Project:     Lab 7
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date: 9/17 - Added documentation to explain how the debouncer works to
//				  	 create a one shot pulse.
//
// Note:		    This module depends on a 500Hz clock so that it can check the
//					 inputs over the period of 20ns.
//
// Purpose:     Wait for the inputs on D_in to stabilize and then create a one
//			  	    shot pulse to clock the sequence detector.
//////////////////////////////////////////////////////////////////////////////////
module debounce( clk, reset, D_in, D_out );
	input  clk, reset, D_in;
	output D_out;
	
	//registers to sample the D_in inputs to watch for stability of inputs
	reg    q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	
	
	always @ ( posedge clk, posedge reset )
		if ( reset == 1'b1 ) //reset all registers to 0
			{ q9, q8, q7, q6, q5, q4, q3, q2, q1, q0 } <= 10'b0;
		else begin
			q9 <= q8;	  //shift the registers every clock tick that isn't a reset
			q8 <= q7;
			q7 <= q6;	  //These registers sample in the D_in input values since
			q6 <= q5;	  //they will not be stable at the press of the "step" button.
			q5 <= q4; 	 
			q4 <= q3;	  //Once the values that are being shifted in have become
			q3 <= q2;	  //stable, the debouncer will output a 1.
			q2 <= q1;     
			q1 <= q0; 	  //Otherwise, the output will remain 0.
			q0 <= D_in;
		end //end else
	
	//Wait for stability of the D_in input and create a one shot pulse.
	//Since the debouncer is looking for when the signal is a consistent 1,
	//using !q9 to check for the last moment of instability (the last 0)
	//will create a one shot pulse when the input has reached stablility.
	assign D_out = !q9 & q8 & q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;
						 
endmodule
