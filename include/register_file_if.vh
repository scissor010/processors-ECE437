/*
	Mingfei Huang

	at this time this is not only register file interface but interface for all four models at level of
		register file
		control unit
		hazard unit
		alu
*/

`ifndef REGISTER_FILE_IF_VH
`define REGISTER_FILE_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface register_file_if;
	// import types
	import cpu_types_pkg::*;

	logic     rWEN;		// register write enable
	regbits_t wsel, rsel1, rsel2;
	word_t    wdat, rdat1, rdat2;

	word_t inst;	// one line of instruction read from memory by PC

	word_t imemREN;
	word_t PC;
	word_t dmemREN;
	word_t dmemWEN;
	word_t dmemstore;
	word_t dmemaddr;
	word_t imemload;
	word_t dmemload;


	//alu part
	word_t oprnd1 , oprnd2 , alurst;
	logic [3:0] alucode;
	logic vldflg , cryflg , ngtflg , zroflg;

	modport fi(
		input PC,
		output imemload
	);

	modport alu(
		input oprnd1 , oprnd2 , alucode,
		output alurst , vldflg , cryflg , ngtflg , zroflg
	);

	// control unit ports
	modport cu(
		input inst,	// from memory
		rdat1, rdat2,	// from reg file
		alurst,		// from alu
		vldflg , cryflg , ngtflg , zroflg, // alu flags
		imemload, dmemload,		// from datapath/memory
		output rWEN , wsel , rsel1 , rsel2 , wdat,	// to register file
		oprnd1 , oprnd2 , alucode,		// to alu
		imemREN, dmemREN, dmemWEN, dmemstore, PC, dmemaddr	// to datapath/memory
	);

	// register file ports
	modport rf (
		input   rWEN, wsel, rsel1, rsel2, wdat,
		output  rdat1, rdat2
	);
endinterface

`endif //REGISTER_FILE_IF_VH
