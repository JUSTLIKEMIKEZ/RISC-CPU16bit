`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:11 11/28/2015 
// Design Name: 
// Module Name:    RISC_Processor 
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
module RISC_Processor(clk, reset, Address, D_out, D_in, mw_en, status );
	
	//input declaration
	input 			clk, reset;
	input  [15:0]  D_in;
	
	
	//output declaration
	output [15:0]  D_Out;
	output [15:0]  Address;
	output 		   mw_en;
	output [ 7:0]  status;

	
	//internal wire declaration
	wire 			rw_en, C, N, Z, sel, adr_sel, ir_ld,
					pc_ld, pc_sel, pc_inc;
	wire [ 2:0] W_Adr, S_Adr, R_Adr;
	wire [ 3:0] alu_op;
	wire [15:0] IR;
	
	
	CPU_EU 	execution_unit( 
									//clk, reset declaration
									.clk(clk), .reset(reset), 
					
									//Integer Datapath
									.W_En(rw_en),
									.W_Adr(W_Adr), .S_Adr(S_Adr), .R_Adr(R_Adr),
									.D_Out(D_Out), .C(C), 
									.N(N), .Z(Z), .sel(sel),
									.alu_op(alu_op),
					
									//adr_mux
									.adr_sel(adr_sel), .Address(Address),
							
									//pc counter
									.ld_en(pc_ld), .pc_inc(pc_inc), .pc_sel(pc_sel), 
					
									//IR
									.ir_en(ir_ld), .D_in(D_in), .IR_Out(IR));
					
					
					
	 CU		control_unit(	
									//clk and reset declaration
									.clk(clk), .reset(reset), 
						
							////**************************************************************
								.IR(IR), .N(N), .Z(Z), .C(C), 						 //control unit inputs
								.W_Adr(W_Adr), .S_Adr(S_Adr), .R_Adr(R_Adr),		 //these are
								.adr_sel(adr_sel), .s_sel(sel), 						 //the control
								.pc_ld(pc_ld), .pc_inc(pc_inc), .pc_sel(pc_sel), 
								.ir_ld(ir_ld),   											 //word output
								.mw_en(mw_en), .rw_en(rw_en), .alu_op(alu_op), 	 //fields
								.status(status));			
							////***************************************************************


endmodule
