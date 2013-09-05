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

module Alu_tb();

	register_file_if rfif();
	logic [31:0] tb_oprnd1;
	logic [31:0] tb_oprnd2;
	logic [3:0] tb_opcode;
	logic [31:0] tb_result;

	assign rfif.oprnd1 = tb_oprnd1;
	assign rfif.oprnd2 = tb_oprnd2;
	assign rfif.alucode = tb_opcode;
	assign tb_result = rfif.alurst;

	logic caryflag;

	Alu DUT(rfif);

	initial begin

		$monitor("==================
oprnd1:%b
oprnd2:%b
opcode:%b
result:%b
caryflag:%b
==================\n	",
			tb_oprnd1,tb_oprnd2,tb_opcode,tb_result,caryflag);

		tb_oprnd1 = 32'b11111111111111111111111111111110;
		tb_oprnd2 = 32'b11111111111111111111111111111111;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);

		tb_oprnd1 = 32'b11111111111111111111111111111110;
		tb_oprnd2 = 17;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);

		tb_oprnd1 = 17;
		tb_oprnd2 = 32'b11111111111111111111111111111110;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);

		tb_oprnd1 = 32'b11111111111111111111111111111110;
		tb_oprnd2 = 32'b11111111111111111111111111111111;
		tb_opcode = ALU_SLT;
		#(10);

		tb_oprnd1 = 12345;
		tb_oprnd2 = 2;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);

		tb_oprnd1 = 12345;
		tb_oprnd2 = 3;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);

		tb_oprnd1 = 12345;
		tb_oprnd2 = 4;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);

		tb_oprnd1 = 12345;
		tb_oprnd2 = 5;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);

		tb_oprnd1 = 100;
		tb_oprnd2 = 12345;
		tb_opcode = ALU_SLTU;
		caryflag = rfif.cryflg;
		#(10);




	end


endmodule