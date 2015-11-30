`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   reg16.v
// Project:     Lab 7
//
// Designer:    Steven Le
//					 Michael Handria
//	
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:10/14 - Created the 16-bit register.
//
// Purpose:     A 16-bit register with tri-state outputs and two different ports
//					 for reading based on enables.
//
//////////////////////////////////////////////////////////////////////////////////
module reg16(clk, reset, ld, Din, DA, DB, oeA, oeB );

	//input declaration
	input  		  clk, reset, ld, oeA, oeB;
	input  [15:0] Din;
	
	//output declaration 
	output [15:0] DA, DB;
	reg 	 [15:0] Dout;
	
	
	//state register
	always @ (posedge clk, posedge reset) begin
		//if reset then initialize everything to 0
		if(reset)
			Dout <= 16'h0;
		else
			if(ld)
				Dout <= Din;
			else
				Dout <= Dout;
	end
	
	//continously assign statement for reading the register
	assign DA = (oeA) ? Dout : 16'hz;
	assign DB = (oeB) ? Dout : 16'hz;
	

endmodule
