/*`include "register_file_if.vh"

import register_file_if::*;

module register_file
(
	input logic CLK,
	input logic rst_n
	register_file_if rfif,
);*/

module register_file(
input logic [4:0] wsel,
input logic [31:0] wdat,
input logic WEN,
input logic clk,
input logic [4:0] rsel1,
input logic [4:0] rsel2,
input logic nRST,
output logic [31:0] rdat1,
output logic [31:0] rdat2
);

	logic [31:0] en;
	logic [31:0] data [31:0];

	Decoder decoder(
		/*rfif.*/wsel,
		/*rfif.*/WEN,
		en
	);

/*	Regs regs(
		wdat,
		en[0],
		clk,
		nRST,
		data[0]
	);*/

	genvar i;
	generate
		for(i = 0; i <= 31; i = i + 1)
		begin
			Regs regs (
				/*rfif.*/wdat,
				en[i],
				/*rfif.*/clk,
				nRST,
				data[i]
			);
		end
	endgenerate

	Mux mux1(
		/*rfif.*/rsel1,
		data,
		/*rfif.*/rdat1
	);
	Mux mux2(
		/*rfif.*/rsel2,
		data,
		/*rfif.*/rdat2
	);
endmodule