`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:49 11/30/2015 
// Design Name: 
// Module Name:    ram 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ram_md(clk, we, addr, D_in, D_out);
	
	input 		clk, we;
	input [ 7:0] addr;
	input [15:0] D_in;
	
	output [15:0] D_out;
	
	
	ram ram256x16(
						.clka(clk), 	// input clka
						.wea(we), 		// input [0 : 0] wea
						.addra(addr), 	// input [7 : 0] addra
						.dina(D_in), 	// input [15 : 0] dina
						.douta(D_out) 	// output [15 : 0] douta
					);

endmodule
