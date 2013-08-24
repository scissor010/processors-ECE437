/*
	Eric Villasenor
	evillase@gmail.com

	register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

	parameter PERIOD = 10;

	logic CLK = 0, nRST = 0;

	// test vars
	int v1 = 1;
	int v2 = 4721;
	int v3 = 25119;

	// clock
	always #(PERIOD/2) CLK++;

	// interface
	register_file_if rfif ();
	// DUT
`ifndef MAPPED
	register_file DUT(CLK, nRST, rfif);
`else
	register_file DUT(
		.\rfif.rdat2 (rfif.rdat2),
		.\rfif.rdat1 (rfif.rdat1),
		.\rfif.wdat (rfif.wdat),
		.\rfif.rsel2 (rfif.rsel2),
		.\rfif.rsel1 (rfif.rsel1),
		.\rfif.wsel (rfif.wsel),
		.\rfif.WEN (rfif.WEN),
		.\nRST (nRST),
		.\CLK (CLK)
	);
`endif

always begin
			$monitor("
				clk=%d\n
				wsel=%d\n
				wdat=%d\n
				WEN=%d\n
				rsel1=%d\n
				rsel2=%d\n
				\trdat1=%d\n
				\trdat2=%d\n\n"
		,CLK
		,rfif.wsel
		,rfif.wdat
		,rfif.WEN
		,rfif.rsel1
		,rfif.rsel2
		,rfif.rdat1
		,rfif.rdat2);

			$display("\n---------------reset---------------\n\n");
			nRST = 0;
			#(PERIOD/2)
			nRST = 1;
			$display("\n---------------reset---------------\n\n");



	#(PERIOD*2)
	rfif.wsel = 0;
	rfif.WEN = 0;
	rfif.wdat = 0;
	rfif.rsel1 = 0;
	rfif.rsel2 = 0;

	$display("write to $0");
	#(PERIOD*2)// write to $0
	rfif.wsel = 0;
	rfif.WEN = 1;
	rfif.wdat = 99;
	rfif.rsel1 = 1;
	rfif.rsel2 = 0;

	$display("write to $2");
	#(PERIOD*2)// write to $2
	rfif.wsel = 2;
	rfif.WEN = 1;
	rfif.wdat = 99;
	rfif.rsel1 = 2;
	rfif.rsel2 = 0;

	$display("write to $17");
	#(PERIOD*2)// write to $17
	rfif.wsel = 17;
	rfif.WEN = 1;
	rfif.wdat = 12345;
	rfif.rsel1 = 2;
	rfif.rsel2 = 17;

	$display("WEN is 0");
	#(PERIOD*2)// WEN is 0
	rfif.wsel = 31;
	rfif.WEN = 0;
	rfif.wdat = 54321;
	rfif.rsel1 = 2;
	rfif.rsel2 = 31;
end


endmodule
