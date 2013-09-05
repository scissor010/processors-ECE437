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

	register_file regfile(
		rfif,
		CLK,
		nRST
	);
	Alu alu(rfif);
	Control_unit CU(CLK , nRST , rfif);

	assign dpif.imemaddr = rfif.PC;

	assign rfif.inst		= dpif.imemload;
	assign rfif.dmemload	= dpif.dmemload;

	assign dpif.imemREN		= rfif.imemREN;

	assign dpif.dmemREN		= rfif.dmemREN;
	assign dpif.dmemWEN		= rfif.dmemWEN;

	assign dpif.dmemstore	= rfif.dmemstore;
	assign dpif.dmemaddr	= rfif.dmemaddr;


	assign dpif.datomic		= 1'bx;		// to be filled later
	assign dpif.halt		= 1'bx;



endmodule
