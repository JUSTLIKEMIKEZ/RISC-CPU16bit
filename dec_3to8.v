`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:55 11/27/2015 
// Design Name: 
// Module Name:    dec_3to8 
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
module dec_3to8(in, en, y);
	input reg [2:0] in;
	input en;
	output [7:0] y;

	always @ * begin
		case(in)
			3'b000: y = 8'b0000_0001;
			3'b001: y = 8'b0000_0010;
			3'b010: y = 8'b0000_0100;
			3'b011: y = 8'b0000_1000;
			3'b100: y = 8'b0001_0000;
			3'b101: y = 8'b0010_0000;
			3'b110: y = 8'b0100_0000;
			3'b111: y = 8'b1000_0000;
		endcase
	end


endmodule
