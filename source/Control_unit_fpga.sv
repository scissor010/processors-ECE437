// interface
`include "register_file_if.vh"

module register_file_fpga (
	input logic CLOCK_50,
	input logic [3:0] KEY,
	input logic [17:0] SW,
	output logic [17:0] LEDR,
	output logic [17:0] LEDG,
	output logic [6:0] HEX0
);

	// interface
	register_file_if rfif();//CLOCK_50, KEY[2]);

	// components
	register_file RF(rfif , CLOCK_50 , KEY[0]);
	Control_unit CU(rfif);
	Alu alu(rfif);

	assign rfif.inst[25:06] = SW[17:0];


	assign LEDR[8:5] = rfif.rdat1[3:0];
	assign LEDR[13:10] = rfif.rdat2[3:0];

endmodule
