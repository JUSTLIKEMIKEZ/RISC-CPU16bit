`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   RISC_Processor.v
// Project:     Lab 8
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:11/30 - Created the processor by adding a control unit to function with 
//					 an execution unit.
//
// Purpose:     16-bit RISC Processor that takes instructions from memory with the
//					 control unit and executes them in the execution unit.
//////////////////////////////////////////////////////////////////////////////////
module RISC_Processor(clk, reset, Address, D_out, D_in, mw_en, status /*Reg_Out*/ );
	
	//input declaration
	input 			clk, reset;
	input  [15:0]  D_in;
	
	
	//output declaration
	output [15:0]  D_out;
	output [15:0]  Address; // Reg_Out;
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
									.D_Out(D_out), //.Reg_Out(Reg_Out),
									.C(C), .N(N), .Z(Z), 
									.sel(sel),
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
