/*
	Eric Villasenor
	evillase@gmail.com

	register file test bench
*/

// cpu instructions
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module Control_unit_tb;

	logic CLK , nRST;

	register_file_if rfif();


	Control_unit CU_DUT(CLK,nRST,rfif);
	Alu ALU_DUT(rfif);
	register_file REG_DUT(rfif , CLK , nRST);

	fake_imem ram(rfif);


	logic [5:0] op;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [4:0] sa;
	logic [5:0] spe;

	word_t PC;
	assign PC = rfif.PC;


	parameter PERIOD = 100;

	always begin : proc_
		#(PERIOD/2);
		CLK = 0;
		#(PERIOD/2);
		CLK = 1;
	end

	initial begin
		nRST = 0;
		#(PERIOD);
		nRST = 1;
	end

	always begin
		$monitor("
reg%d:	%d:%b
reg%d:	%d:%b
reg%d:	%d:%b
reg%d:	%d:%b
reg%d:	%d:%b
reg%d:	%d:%b"
, 00 , REG_DUT.data[00] , REG_DUT.data[00]
, 01 , REG_DUT.data[01] , REG_DUT.data[01]
, 02 , REG_DUT.data[02] , REG_DUT.data[02]
, 03 , REG_DUT.data[03] , REG_DUT.data[03]
, 04 , REG_DUT.data[04] , REG_DUT.data[04]
, 05 , REG_DUT.data[05] , REG_DUT.data[05]
, 06 , REG_DUT.data[06] , REG_DUT.data[06]);
		#1;
	end


endmodule