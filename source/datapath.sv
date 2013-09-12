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

module datapath (
	input logic CLK, nRST,
	datapath_cache_if.dp dpif
);
	// import types
	import cpu_types_pkg::*;

	// pc init
	parameter PC_INIT = 0;

	// start from here is personal code

	register_file_if rfif();
	word_t PC;	// pc current state
	assign rfif.PC = PC;
	// program counter stuff
	word_t PCtemp;
	assign PCtemp = rfif.instEN?rfif.PCnxt:PC;
	always_ff@(posedge CLK or negedge nRST) begin
		if(~nRST) begin
			PC <= PC_INIT;
		end else begin
			PC <= PCtemp;
		end
	end

	logic haltff;
	always_ff@(negedge CLK or negedge nRST) begin
		if(~nRST/* & ~rfif.halt*/) begin
				haltff <= 0;
		end else begin
			if(rfif.halt =='1)begin
				haltff <= 1;
			end
		end
	end
	logic talh;
	always_ff@(posedge CLK or negedge nRST) begin
		if(~nRST) begin
				talh <= 0;
		end else begin
			if(haltff =='1)begin
				talh <= 1;
			end
		end
	end


	register_file regfile(
		rfif,
		CLK,
		nRST
	);
	Alu alu(rfif);
	Control_unit CU(rfif);
	hazard_unit HU(CLK , nRST , rfif);

	assign dpif.imemaddr = PC;

	assign rfif.imemload	= dpif.imemload;
	assign rfif.dmemload	= dpif.dmemload;

	assign dpif.imemREN		= rfif.imemREN;

	assign dpif.dmemREN		= rfif.dmemREN;
	assign dpif.dmemWEN		= rfif.dmemWEN;

	assign dpif.dmemstore	= rfif.dmemstore;
	assign dpif.dmemaddr	= rfif.dmemaddr;


	assign dpif.datomic		= 1'bx;		// to be filled later
	assign dpif.halt		= talh;//haltff & nRST;

	assign rfif.dhit = dpif.dhit;
	assign rfif.ihit = dpif.ihit;
	assign rfif.rWEN = rfif.cu_rWEN & (rfif.cu_dmemREN & rfif.dhit) | rfif.cu_rWEN&(!rfif.cu_dmemREN);
endmodule
