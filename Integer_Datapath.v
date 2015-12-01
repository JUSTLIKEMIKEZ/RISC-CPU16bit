`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   Integer_Datapath.v
// Project:     Lab 7
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:10/26 - Created the integer datapath module by connecting the register file,
//					 arithmetic logic unit and a 2 to 1 mux together.
//
// Purpose:     Perform basic arithmetic functions using the data from the register
//					 file or external memory. The result is sent out to external memory
//					 or to rewrite one of the registers in the file.
//////////////////////////////////////////////////////////////////////////////////
module Integer_Datapath( clk, reset, W_En, W_Adr, S_Adr, DS, R_Adr,
								 S_Sel, Alu_Op, Reg_Out, Alu_Out, C, N, Z);
	
	//input declaration
	input 		 clk, reset;
	input 		 W_En;
	input [ 2:0] R_Adr, W_Adr, S_Adr;
	input [15:0] DS;
	input [ 3:0] Alu_Op;
	input 		 S_Sel;
	
	//output decleration
	output [15:0] Reg_Out;
	output [15:0] Alu_Out;
	output 		  C, N, Z;
	
	
	
	//internal wire decleration
	wire [15:0]  s0, S;
	
	
	//register file that includes: 
	//							3x8 decoder 
	//						   16reg module
	register_file  Reg_file( .clk(clk), 
									 .reset(reset), 
									 .W_Adr(W_Adr),  
									 .R_Adr(R_Adr), 
									 .S_Adr(S_Adr), 
									 .we_pulse(W_En), 
									 .W(Alu_Out), 
									 .R(Reg_Out), 
									 .S(s0) );
					  
	
	
	
	
	
	
	//-- Arithmatic Logic Unit that can shift add, and subtract. 
	//-- also includes incrament and decrement 
	alu 				arithmatic_logic( .R(Reg_Out),
												.S(S), 
												.Alu_Op(Alu_Op), 
												.Y(Alu_Out), 
												.N(N), 
												.Z(Z), 
												.C(C) );
												
	//-- 2x1 mux that will select between S and DS
	//-- if sel == 1 choose DS, else choose S
	assign S = (S_Sel == 1'b1) ? DS : s0;
	
	
	
endmodule
