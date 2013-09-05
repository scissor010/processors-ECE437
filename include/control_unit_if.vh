/*
	Mingfei Huang

	interface of control unit level for blocks:
		register file
		control unit
		hazard unit
		alu
*/

`ifndef CU_IF_VH
`define CU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface cu_if;
	// import types
	import cpu_types_pkg::*;

	//alu part
	word_t oprnd1 , oprnd2 , alurst;
	logic [3:0] opcode;

	modport alu(
		input oprnd1 , oprnd2 , opcode,
		output alurst
	)

	// control unit ports
	modport cu(
		input word_t inst,	// from memory
		input rdat1, rdat2,	// from reg file
		output rWEN , wsel , rsel1 , rsel2 , wdat,	// to register file
		output oprnd1 , oprnd2 , opcode		// to alu
	);

	// register file ports
	modport rf (
		input   rWEN, wsel, rsel1, rsel2, wdat,
		output  rdat1, rdat2
	);
endinterface

`endif //REGISTER_FILE_IF_VH
