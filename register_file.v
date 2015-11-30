`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   register_file.v
// Project:     Lab 7
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//				    michaelhandria@gmail.com
//
// Date: 10/19 - Created register file by tying together three 3 to 8 decoders with
//					  eight 16-bit registers.
//		   10/28 - modified so W will take in 16 bits
//
// Purpose:     Memory module consisting of eight 16-bit registers with tri-state
//					 outputs connected to a data bus that are wired to three decoders 
//					 (one for writing and two for reading).This will allow the registers 
//					 to be written to and also have two different ones be read at the
//					 same time.
//////////////////////////////////////////////////////////////////////////////////
module register_file(clk, reset, W, W_Adr, we_pulse, R_Adr, S_Adr, R, S);
	 
	 input  				clk, reset, we_pulse;
	 input 	[2:0]		W_Adr, R_Adr, S_Adr;
	 input 	[15:0]	W;
	 output	[15:0]	R, S;
	 
	 wire 	[7:0]		ld, oeA, oeB;
	 
	 //--
	 //--		Registers 
	 //--
	reg16  	reg16_7(
					.clk(clk), 
					.reset(reset), 
					.ld(ld[7]), 
					.Din(W)  , 
					.oeA(oeA[7]), 
					.oeB(oeB[7]), 
					.DA(R) , 
					.DB(S) ),
					
				reg16_6( 
					.clk(clk), 
					.reset(reset), 
					.ld(ld[6]), 
					.Din(W)  , 
					.oeA(oeA[6]), 
					.oeB(oeB[6]), 
					.DA(R) , 
					.DB(S)),
					
				reg16_5(
					.clk(clk), 
					.reset(reset), 
					.ld(ld[5]), 
					.Din(W)  , 
					.oeA(oeA[5]), 
					.oeB(oeB[5]), 
					.DA(R) , 
					.DB(S) ),
					
				reg16_4(
					.clk(clk), 
					.reset(reset), 
					.ld(ld[4]), 
					.Din(W)  , 
					.oeA(oeA[4]), 
					.oeB(oeB[4]), 
					.DA(R) , 
					.DB(S) ),
					
				reg16_3(
					.clk(clk), 
					.reset(reset), 
					.ld(ld[3]), 
					.Din(W)  , 
					.oeA(oeA[3]), 
					.oeB(oeB[3]), 
					.DA(R) , 
					.DB(S) ),
					
				reg16_2(
					.clk(clk), 
					.reset(reset), 
					.ld(ld[2]), 
					.Din(W)  , 
					.oeA(oeA[2]), 
					.oeB(oeB[2]), 
					.DA(R) , 
					.DB(S) ),
					
				reg16_1(
					.clk(clk), 
					.reset(reset), 
					.ld(ld[1]), 
					.Din(W)  , 
					.oeA(oeA[1]), 
					.oeB(oeB[1]), 
					.DA(R) , 
					.DB(S) ),
					
				reg16_0(
					.clk(clk), 
					.reset(reset), 
					.ld(ld[0]), 
					.Din(W)  , 
					.oeA(oeA[0]), 
					.oeB(oeB[0]), 
					.DA(R) , 
					.DB(S) );
	
	//--
	//--		Decodes the enables for the reg16
	//--
	dec_3to8
		decW2(.in(W_Adr), .en(we_pulse)  , .y({ld})),
		decR1(.in(R_Adr), .en(1'b1), .y({oeA})),
		decS0(.in(S_Adr), .en(1'b1), .y({oeB}));
		
endmodule
