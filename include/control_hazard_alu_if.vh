/*
	Mingfei Huang

	Control unit
	Hazard unit
	Alu

	CHA interface
*/

`ifndef CONTROL_HAZARD_ALU_if
`define CONTROL_HAZARD_ALU_if

// all types
`include "cpu_types_pkg.vh"

interface control_hazard_alu_if;
	// import types
	import cpu_types_pkg::*;

	logic     rWEN;		// register write enable
	logic 	  cu_rWEN;
	regbits_t wsel, rsel1, rsel2;
	word_t    wdat, rdat1, rdat2;

	word_t inst;	// one line of instruction read from memory by PC

	//word_t PC;
	word_t dmemREN;
	word_t dmemWEN;
	word_t cu_dmemREN;
	word_t cu_dmemWEN;/*
	word_t dmemstore;
	word_t dmemaddr;
	word_t dmemload;
	word_t PCnxt;*/

	word_t imemload;
	//alu part
	word_t oprnd1 , oprnd2 , alurst;
	logic [3:0] alucode;
	logic vldflg , cryflg , ngtflg , zroflg;
	logic PC4EN;
	logic [1:0] op2sel;
	logic [1:0] extmode;
	logic [1:0] wseles;
	logic [1:0] wdat_sel;
	logic [1:0] PCsel;
	logic ilast;

	modport alu(
		input oprnd1 , oprnd2 , alucode,
		output alurst , vldflg , cryflg , ngtflg , zroflg
	);

	// register file ports
	modport rf (
		input   rWEN, wsel, rsel1, rsel2, wdat,
		output  rdat1, rdat2
	);


	// control unit ports
	modport cu(
		input inst,								// from memory
		zroflg,							 		// alu flags
		imemload,
		output
		cu_rWEN,									//	 to register file
		alucode,								// to alu
		cu_dmemREN, cu_dmemWEN,						// to memory enables
		op2sel,extmode,wseles,wdat_sel,			// source selects
		PC4EN , PCsel,
		halt
	);

	logic ihit , dhit , halt , imemREN , instEN;
	// hazard unit
	modport hu(
		input ihit , dhit, cu_dmemWEN  , cu_dmemREN, halt,
		output imemREN, dmemREN, dmemWEN , instEN , ilast
	);
	word_t PC;
	// fake inst mem
	modport fi(
		input PC,
		output imemload
	);

endinterface

`endif













