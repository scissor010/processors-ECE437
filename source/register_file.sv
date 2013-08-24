`include "register_file_if.vh"
//import register_file_if::*;

module register_file
(
	register_file_if.rf rfif,
	input logic CLK,
	input logic nRST
);

	logic [31:0] en;
	logic [31:0] data [31:0];

	Decoder decoder(
		rfif.wsel,
		rfif.WEN,
		en
	);

	Allregs allregs(
		rfif.wdat,
		en,
		nRST,
		CLK,
		data
	);

	Mux mux1(
		rfif.rsel1,
		data,
		rfif.rdat1
	);
	Mux mux2(
		rfif.rsel2,
		data,
		rfif.rdat2
	);
endmodule
