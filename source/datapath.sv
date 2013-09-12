/*
	Eric Villasenor
	evillase@gmail.com

	datapath contains register file, control, hazard,
	muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"
// register file interface
`include "register_file_if.vh"
// control unit hazard unit alu interface
`include "control_hazard_alu_if.vh"
// control signal selects
`include "control_sel_pkg.vh"

module datapath (
	input logic CLK, nRST,
	datapath_cache_if.dp dpif
);
	// import types
	import cpu_types_pkg::*;
	import control_sel_pkg::*;

	// pc init
	parameter PC_INIT = 0;

	// start from here is personal code


// downward interfaces
	register_file_if rfif();
	control_hazard_alu_if chaif();
	register_file regfile(
		rfif,
		CLK,
		nRST
	);
	Alu alu(chaif);
	Control_unit CU(chaif);
	hazard_unit HU(CLK , nRST , chaif);

// temp values for easier expression
	logic [5:0] opcode;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [4:0] sa;
	logic [15:0] imm;
	logic [25:0] JumpAddr;
	logic [15:0] offset;
	logic [5:0] rcode;
	logic [31:0] immext;
	assign opcode		 = dpif.imemload[31:26];
	assign rs			 = dpif.imemload[25:21];
	assign rt			 = dpif.imemload[20:16];
	assign rd			 = dpif.imemload[15:11];
	assign sa			 = dpif.imemload[10:06];
	assign imm			 = dpif.imemload[15:0];
	assign JumpAddr		 = dpif.imemload[25:0];
	assign offset		 = dpif.imemload[15:0];
	assign rcode		 = dpif.imemload[5:0];

// PC
	word_t PC;	// pc current state
	assign chaif.PC = PC;
	// program counter stuff
	word_t PCtemp , PCnxt , PC4 , PCelse;
	assign PC4 = PC + 4;
	always_comb begin : PC_next_state
		if(chaif.halt | !chaif.ilast)begin
			PCtemp=PC;
		end else begin
			PCtemp=PCnxt;
		end
	end
//	assign PCtemp = chaif.halt?PC:PCnxt;

	logic tt;

	assign PCnxt = chaif.PC4EN?PC4:PCelse;
	always_ff@(posedge CLK or negedge nRST) begin
		if(~nRST) begin
			PC <= PC_INIT;
			tt<=0;
		end else begin
			PC <= PCtemp;
			tt<=1;
		end
	end

	logic haltff;
	always_ff@(negedge CLK or negedge nRST) begin
		if(~nRST/* & ~chaif.halt*/) begin
				haltff <= 0;
		end else begin if(chaif.halt)begin
				haltff <= 1;
			end
		end
	end

	word_t dmemstore , dmemload , dmemaddr;

	assign dpif.imemaddr = PC;

	assign dmemload	= dpif.dmemload;
	assign chaif.imemload = dpif.imemload;
	assign dpif.imemREN		= chaif.imemREN;

	assign dpif.dmemREN		= chaif.dmemREN;
	assign dpif.dmemWEN		= chaif.dmemWEN;

	assign dpif.dmemstore	= dmemstore;
	assign dpif.dmemaddr	= dmemaddr;


	assign dpif.datomic		= 1'bx;		// to be filled later
	assign dpif.halt		= haltff;// & nRST;

	assign chaif.dhit = dpif.dhit;
	assign chaif.ihit = dpif.ihit;

// datapth muxes
	assign chaif.oprnd1 = rfif.rdat1;
	assign dmemaddr = chaif.alurst;
	assign dmemstore = rfif.rdat2;
	assign rfif.rsel1 = rs;
	assign rfif.rsel2 = rt;
	assign rfif.WEN = chaif.cu_rWEN & (chaif.cu_dmemREN & chaif.dhit) | chaif.cu_rWEN&(!chaif.cu_dmemREN)&chaif.ilast;

	always_comb begin : oprnd2_mux
		if(chaif.op2sel == OP2_RDAT)begin
			chaif.oprnd2  = rfif.rdat2;
		end else if(chaif.op2sel == OP2_SA)begin
			chaif.oprnd2  = sa;
		end else if(chaif.op2sel == OP2_IMM)begin
			chaif.oprnd2  = immext;
		end else begin
			chaif.oprnd2  = 32'dx;
		end
	end

	always_comb begin : imm_extender
		if(chaif.extmode == EXT_ZERO)begin
			immext = {16'b0 , imm};
		end else if(chaif.extmode == EXT_ONE)begin
			immext = {16'hffff , imm};
		end else if(chaif.extmode == EXT_SIGN)begin
			if(imm[15])begin
				immext = {16'hffff , imm};
			end else begin
				immext = {16'b0 , imm};
			end
		end else begin		// impossible case
			immext = 'dx;
		end
	end
	always_comb begin : wsel_select
		if(chaif.wseles == WSEL_RT)begin
			rfif.wsel  = rt;
		end else if(chaif.wseles == WSEL_RD)begin
			rfif.wsel  = rd;
		end else if(chaif.wseles == WSEL_31)begin
			rfif.wsel  = 31;
		end else begin		// impossible case
			rfif.wsel  = 'dx;
		end
	end

	always_comb begin : wdat_select
		if(chaif.wdat_sel == WDAT_ALU)begin
			rfif.wdat  = chaif.alurst;
		end else if(chaif.wdat_sel == WDAT_LUI)begin
			rfif.wdat  = {imm , 16'b0};
		end else if(chaif.wdat_sel == WDAT_MEM)begin
			rfif.wdat  = dmemload;
		end else if(chaif.wdat_sel == WDAT_PC4)begin
			rfif.wdat  = PC4;
		end else begin
			rfif.wdat  = 'bx;
		end
	end

	always_comb begin : PCelse_select
		if(chaif.PCsel == PC_JR)begin
			PCelse =  rfif.rdat1;
		end else if(chaif.PCsel == PC_JI)begin
			PCelse =  {chaif.PC[31:28] , JumpAddr , 2'b00};
		end else if(chaif.PCsel == PC_BR)begin
			PCelse =  PC4+{immext[29:0] , 2'b00};
		end else begin	// halt , not sure for this..
			PCelse =  PC;
		end
	end
endmodule
