`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name:   CPU_EU.v
// Project:     Lab 7
//
// Designer:    Steven Le
//					 Michael Handria
//
// Email:       lesteven224@yahoo.com 
//					 michaelhandria@gmail.com
//
// Date:11/12 - Created the CPU execution unit module by connecting the integer
//					 datapath with a program counter, an instruction register and a
//					 address multiplexer.
//
// Purpose:     Execution unit of a CPU that runs instructions based on the values
//					 that go into the instruction register.
//////////////////////////////////////////////////////////////////////////////////
module CPU_EU( //clk, reset declaration
					clk, reset, 
					
					//Integer Datapath
					W_En, 
					W_Adr, S_Adr, R_Adr,
					D_Out, C, N, Z, sel,
					alu_op,
					
					//adr_mux
					adr_sel, Address,
					
				   //pc counter
					ld_en, pc_inc, pc_sel, 
					
					//IR
					ir_en, D_in, IR_Out);


	//clk and reset decleration
	input 		clk, reset;
	
	
	//IDP IO declaration
	input [2:0]  W_Adr, R_Adr, S_Adr;
	input			 W_En;
	input 		 sel;
	input	[3:0]  alu_op;
	
	output [15:0]  D_Out;
	output 		  C, N, Z;
	
	//PC IO declaration
	input			 pc_sel;
	input 		 ld_en, pc_inc;
	
	//IR IO declaration
	input 		  ir_en;
	input  [15:0] D_in;
	output [15:0] IR_Out;
	
	//adr_mux
	input			adr_sel;
	output 		[15:0] Address;
	
	//internal wire declaration
	wire [15:0]  Reg_Out, Alu_Out, pc_out, pc_outmux,
					 pc_in, addr_in;

	
	
	//Integer Datapath that includes:
	//									Register File
	//									2x1 Mux
	//									ALU(arithmatic logic unit)
	Integer_Datapath    ID(.clk(clk),   
								  .reset(reset),   
								  .W_En(W_En),  
								  .W_Adr(W_Adr), 
								  .S_Adr(S_Adr),   
								  .DS(D_in),
								  .S_Sel(sel), 
								  .R_Adr(R_Adr),
								  .Alu_Op(alu_op),   
								  .Reg_Out(Reg_Out), 
								  .Alu_Out(D_Out), 
								  .C(C), .N(N), .Z(Z)
								  );
								  
	//pc_mux
	assign 				  pc_outmux = (pc_sel) ? D_Out : pc_in;
	
	//program counter that will increment and load							  
	Program_Counter	  PC( .clk(clk), 
									.reset(reset), 
									.ld_en(ld_en), 
									.pc_load(pc_outmux), 
									.pc_inc(pc_inc), 
									.pc_out(pc_out));
	
	
	//register that will hold the instructions for the next 
	//clock cycle 
	Instruction_Reg	  IR( .clk(clk), 
									.reset(reset),
									.ld(ir_en),
									.D_in(D_in),
									.IR_out(IR_Out));
									
	//SignExt
	assign 				  addr_in = {{8{IR_Out[7]}}, IR_Out[7:0]};
	
	//16-bit add
	assign 				  pc_in = pc_out + addr_in;
									
	//address mux
	//if adr_sel == 1, use Reg_Out, else use pc_out
	assign 				  Address = (adr_sel) ? Reg_Out : pc_out;
	
endmodule
