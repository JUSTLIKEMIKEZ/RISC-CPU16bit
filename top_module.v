`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   top_module.v
// Project:     Lab 8
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:11/28 - Created the top level module for a 16-bit RISC Processor with a 
//					 RAM for instructions and a display controller to view the contents.
//
// Purpose:     To allow for the operations of the RISC Processor to be implemented
//					 onto the Nexys 4 board to view the contents of memory and see if the
//					 processor can properly perform the instructions that it is told to do.
//////////////////////////////////////////////////////////////////////////////////
module top_module(clk, reset, step_clk, step_mem, status, dump_mem, an, seg);
	
	//input declarations
	input clk, reset;
	input step_clk, step_mem;
	input dump_mem;
	
	//output declarations
	output [7:0] status;
	output [7:0] an;
	output [6:0] seg;
	
	//internal wire declarations
	wire [15:0] Address, mem_counter, D_out, D_in;
	wire [ 7:0] madr;
	wire			mw_en, step_clk_d, step_mem_d;

	debounce_md			  db0(
								  .clk(clk), 
								  .reset(reset), 
								  .D_in(step_clk), 
								  .D_out(step_clk_d)),
								  
							  db1(
								  .clk(clk), 
								  .reset(reset), 
								  .D_in(step_mem), 
								  .D_out(step_mem_d));
								  					
	RISC_Processor 	RISC(
								  .clk(step_clk_d), 
								  .reset(reset), 
								  .Address(Address), 
								  .D_out(D_out), 
								  .D_in(D_in), 
								  .mw_en(mw_en), 
								  .status(status));
	Mem_DumpCounter   mem_d(
								   .clk(step_mem_d),
								   .reset(reset),
								   .mem_counter(mem_counter));
	
	
	//--		2x1 mux that will decide what the address will 
	//--		1 = address from memdump, 0 = address from risc
	assign   madr = (dump_mem) ? mem_counter[7:0] : Address[7:0];							  
	

	ram_md			mem256x16(
									 .clk(clk),
									 .we(mw_en),
									 .addr(madr),
									 .D_in(D_out),
									 .D_out(D_in));
									 
	display_controller   dc( 
								   .clk(clk), 
								   .reset(reset), 
								   .seg_in({{8{1'b0}},madr,D_in}), 
								   .A(an), 
								   .seg_out(seg));
endmodule
