`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:31:45 11/29/2015 
// Design Name: 
// Module Name:    top_module 
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
module top_module(clk, reset, step_clk, step_mem, status, dump_mem, an, seg);

	input clk, reset;
	input step_clk, step_mem;
	input dump_mem;
	
	output [7:0] status;
	output [7:0] an;
	output [7:0] seg;
	
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
	assign 				  madr = (dump_mem) ? mem_counter : Address;							  
	

	ram				mem256x16(
									 .clk(clk),
									 .we(mw_en),
									 .addr(madr),
									 .D_in(D_out),
									 .D_out(D_in));
									 
	display_controller  dc( 
								  .clk(clk), 
								  .reset(reset), 
								  .seg_in({8'h00,m_adr,D_in}), 
								  .A(an), 
								  .seg_out(seg));
endmodule
