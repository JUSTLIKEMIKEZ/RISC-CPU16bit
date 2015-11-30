`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:03:07 11/28/2015 
// Design Name: 
// Module Name:    CU 
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

//*****************************************************************
module CU(clk, reset, IR, N, Z, C, 			//control unit inputs
		  	 W_Adr, R_Adr, S_Adr, 	  			//these are
			 adr_sel, s_sel, 						//the control
			 pc_ld, pc_inc, pc_sel, ir_ld,   //word output
			 mw_en, rw_en, alu_op, 				//fields
			 status);								//LED outputs
//*****************************************************************

	input		     	  clk, reset;					//clk and reset
	input reg [15:0] IR;								//instruction register input
	input 			  N, Z, C;						//datapath status inputs
	
	
	/**************************************
	*		Data Structures & Outputs		  *	
	**************************************/
	
	//--        these 12 make up the control word of the control unit        --//
	output reg [2:0] W_Adr, R_Adr, S_Adr;		//register file address outputs
	output reg		  adr_sel, s_sel;				//mux select outputs
	output reg 		  pc_ld, pc_inc;				//pc_load, pcinc, pc select, ir load
	output reg       pc_sel, ir_ld;				
	output reg 		  mw_en, rw_en;				//memory_write, register_file write
	output reg [3:0] alu_op;						//ALU opcode output
	//-- ******************************************************************* --//
	
	
	output reg [7:0] status;						//8 LED outputs tCyrus Koronio display current state

	reg [4:0] state;									//preset state register
	reg [4:0] nextstate;								//next state register
	reg 		 ps_N, ps_Z, ps_C;					//LED status/state outputs
	reg 		 ns_N, ns_Z, ns_C;					//next state flags register
	
	prameter RESET = 0, FETCH = 1, DECODE = 2,
				ADD = 3, SUB = 4, CMP = 5, MOV = 6,
				INC = 7, DEC = 8, SHL = 9, SHR = 10,
				LD = 11, STO = 12, LDI = 13, 
				JE = 14, JNE = 15, JC = 16, JMP = 17,
				HALT = 18,
				ILLEGAL_OP = 31;
	
	/**************************************
	*		301 Control Unit Sequencer	     *
	**************************************/	

	//synchronous state register assignment
	always @ (posedge clk, posedge reset)
		if(reset == 1'b1)
			state = RESET;
		else
			state = nextstate;
	
	
	//synchronous flags register assignment
	always @ (posedge clk, posedge reset)
		if(reset == 1'b1)
			{ps_N, ps_Z, ps_C} = 3'b0;
		else
			{ps_N, ps_Z, ps_C} = {ns_N, ns_Z, ns_C};
	
	
	//combinational logic section for both next state logic
	//and control word outputs for cpu_execution_unit and memory
	always @ (state)
		case (state)
		
		
		RESET:	begin
			W_Adr = 3'b000; 	R_Adr = 3'b000; 	S_Adr = 3'b000;
			adr_sel = 1'b0; 	s_sel = 1'b0; 
			pc_ld = 1'b0; 		pc_inc = 1'b0; 	pc_sel = 1'b0; 	ir_ld = 1'b0;
			mw_en = 1'b0; 		rw_en = 1'b0; 		alu_op = 4'b0000;
			{ns_N, ns_Z, ns_C} = 3'b0;
			status = 8'hFF;
			nextstate = FETCH;
		end
		
		FETCH:	begin
			W_Adr = 3'b000; 	R_Adr = 3'b000; 	S_Adr = 3'b000;
			adr_sel = 1'b0; 	s_sel = 1'b0; 
			pc_ld = 1'b0; 		pc_inc = 1'b1;		pc_sel = 1'b0; 	ir_ld = 1'b1;
			mw_en = 1'b0; 		rw_en = 1'b0; 		alu_op = 4'b0000;
			{ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C};
			status = 8'h80;
			nextstate = DECODE;
		end
		
		DECODE: begin
			W_Adr = 3'b000;	R_Adr = 3'b000;	S_Adr = 3'b000;
			adr_sel = 1'b0;	s_sel = 1'b0;
			pc_ld = 1'b0;		pc_inc = 1'b0;	pc_sel = 1'b0;		ir_ld = 1'b0;
			mw_en = 1'b0;		rw_en = 1'b0; 		alu_op = 4'b0000;
			{ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C};
			status = 8'hC0;
			case (IR[15:9])
				7'h70: 	nextstate = ADD;
				7'h71: 	nextstate = SUB;
				7'h72: 	nextstate = CMP;
				7'h73: 	nextstate = MOV;
				7'h74: 	nextstate = SHL;
				7'h75: 	nextstate = SHR;
				7'h76: 	nextstate = INC;
				7'h77: 	nextstate = DEC;
				7'h78: 	nextstate = LD;
				7'h79: 	nextstate = STO;
				7'h7a: 	nextstate = LDI;
				7'h7b: 	nextstate = HALT;
				7'h7c: 	nextstate = JE;
				7'h7d: 	nextstate = JNE;
				7'h7e: 	nextstate = JC;
				7'h7f: 	nextstate = JMP;
				default: nextstate = ILLEGAL_OP;
			endcase
		end
		
		ADD: 	begin
			
			nextstate = FETCH;
		end
		
		
		SUB:	begin
			
			nextstate = FETCH;
		end
		
		CMP:	begin
			
			nextstate = FETCH;
		end
		
		MOV:	begin
			
			nextstate = FETCH;
		end
		
		SHL: 	begin
			
			nextstate = FETCH;
		end
		
		SHR: 	begin
			
			nextstate = FETCH;
		end
		
		INC: 	begin
			
			nextstate = FETCH;
		end
		
		DEC: 	begin
			
			nextstate = FETCH;
		end
		
		LD: 	begin
			
			nextstate = FETCH;
		end
		
		STO: 	begin
			
			nextstate = FETCH;
		end
		
		LDI: 	begin
			
			nextstate = FETCH;
		end
		
		HALT: 	begin
			
			nextstate = FETCH;
		end
		
		JE: 	begin
			
			nextstate = FETCH;
		end
		
		JNE: 	begin
			
			nextstate = FETCH;
		end
		
		JC: 	begin
			
			nextstate = FETCH;
		end
		
		JMP: 	begin
			
			nextstate = FETCH;
		end
		
		ILLEGAL_OP:	 begin
		
			nextstate = FETCH;
		end 
	endcase
	
endmodule
