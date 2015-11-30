`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   clk_500Hz.v
// Project:     Lab 7
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date: 8/24 - Created the clock divider module.
//
// Purpose:     Divide the clock of the Nexys 4 board down to 500Hz from 50MHz
//
//////////////////////////////////////////////////////////////////////////////////
module clk_500Hz( clk_in, reset, clk_out );

	input   clk_in, reset;
	output  clk_out;
	reg     clk_out;
	integer i; //declare counter for clock

	//****************************************************************
	// The following verilog code will "divide" an incoming clock
	// by the 32-bit decimal value specified in the "if condition"
	//
	// The value of the counter that counts the incoming clock ticks
	// is equal to [ (Incoming Frequency / Outgoing frequency) / 2 ]
	//****************************************************************

	always @ ( posedge clk_in or posedge reset ) begin
		if ( reset == 1'b1 ) begin
			i = 0; 		 //reset counter to 0
			clk_out = 0; //reset clk_out to 0
		end //end if
		
		else begin
			i = i + 1; //increment counter
			if ( i >= 100000 ) begin
				clk_out = ~clk_out; //flip the clock to start another half period cycle
				i = 0; //restart counter to count for this half of the period cycle
			end //end if
		end //end else
	end //end always
	
endmodule
