`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module Alu(
/*	input logic [31:0] oprnd1,
	input logic [31:0] oprnd2,
	input logic [3:0] alucode,
	output logic [31:0] rfif*/
	register_file_if.alu rfif
	);

	logic [31:0] rstand;	// and
	logic [31:0] rstorr;	// or
	logic [31:0] rstxor;	// xor
	logic [31:0] rstnor;	// nor
	logic [31:0] rstadr;	// add / subtract

	assign rstand = rfif.oprnd1 & rfif.oprnd2;	// and
	assign rstorr = rfif.oprnd1 | rfif.oprnd2;	// or
	assign rstxor = (~rstand) & rstorr;	// xor
	assign rstnor = ~rstorr;	// nor

	/*logic vldflg;	// valid flag*/
	/*logic cryflg;	// carry flag*/
	/*logic ngtflg;	// negative flag*/
	/*logic zroflg;	// zero flag*/

	logic unsign;
	assign unsign = (rfif.alucode==ALU_SLTU);	// unsigned operation

	addr32bit Adder // a +- b , oprnd1 +- oprnd2
	(
		.a(rfif.oprnd1),
		.b(rfif.oprnd2),
		.mode((rfif.alucode==ALU_SUB) || (rfif.alucode==ALU_SLT) || (rfif.alucode==ALU_SLTU)),	// 0 for + , 1 for -
		.result(rstadr),
		.vldflg(rfif.vldflg),
		.cryflg(rfif.cryflg),
		.ngtflg(rfif.ngtflg),
		.zroflg(rfif.zroflg)
	);

	always_comb begin : alucode_decoder
		casez(rfif.alucode)
			default:
				rfif.alurst = rfif.oprnd1;
			ALU_SLL:    // rfif.oprnd1 is GPR[rt],rfif.oprnd2 is sa
				casez(rfif.oprnd2)
					default:rfif.alurst=rfif.oprnd1;
					00:rfif.alurst= rfif.oprnd1[31 : 0];
					01:rfif.alurst={rfif.oprnd1[30 : 0] , 01'b0};
					02:rfif.alurst={rfif.oprnd1[29 : 0] , 02'b0};
					03:rfif.alurst={rfif.oprnd1[28 : 0] , 03'b0};
					04:rfif.alurst={rfif.oprnd1[27 : 0] , 04'b0};
					05:rfif.alurst={rfif.oprnd1[26 : 0] , 05'b0};
					06:rfif.alurst={rfif.oprnd1[25 : 0] , 06'b0};
					07:rfif.alurst={rfif.oprnd1[24 : 0] , 07'b0};
					08:rfif.alurst={rfif.oprnd1[23 : 0] , 08'b0};
					09:rfif.alurst={rfif.oprnd1[22 : 0] , 09'b0};
					10:rfif.alurst={rfif.oprnd1[21 : 0] , 10'b0};
					11:rfif.alurst={rfif.oprnd1[20 : 0] , 11'b0};
					12:rfif.alurst={rfif.oprnd1[19 : 0] , 12'b0};
					13:rfif.alurst={rfif.oprnd1[18 : 0] , 13'b0};
					14:rfif.alurst={rfif.oprnd1[17 : 0] , 14'b0};
					15:rfif.alurst={rfif.oprnd1[16 : 0] , 15'b0};
					16:rfif.alurst={rfif.oprnd1[15 : 0] , 16'b0};
					17:rfif.alurst={rfif.oprnd1[14 : 0] , 17'b0};
					18:rfif.alurst={rfif.oprnd1[13 : 0] , 18'b0};
					19:rfif.alurst={rfif.oprnd1[12 : 0] , 19'b0};
					20:rfif.alurst={rfif.oprnd1[11 : 0] , 20'b0};
					21:rfif.alurst={rfif.oprnd1[10 : 0] , 21'b0};
					22:rfif.alurst={rfif.oprnd1[09 : 0] , 22'b0};
					23:rfif.alurst={rfif.oprnd1[08 : 0] , 23'b0};
					24:rfif.alurst={rfif.oprnd1[07 : 0] , 24'b0};
					25:rfif.alurst={rfif.oprnd1[06 : 0] , 25'b0};
					26:rfif.alurst={rfif.oprnd1[05 : 0] , 26'b0};
					27:rfif.alurst={rfif.oprnd1[04 : 0] , 27'b0};
					28:rfif.alurst={rfif.oprnd1[03 : 0] , 28'b0};
					29:rfif.alurst={rfif.oprnd1[02 : 0] , 29'b0};
					30:rfif.alurst={rfif.oprnd1[01 : 0] , 30'b0};
					31:rfif.alurst={rfif.oprnd1[00 : 0] , 31'b0};
				endcase

			ALU_SRL:    // rfif.oprnd1 is GPR[rt],rfif.oprnd2 is sa
				casez(rfif.oprnd2)
					default:rfif.alurst=rfif.oprnd1;
					//00:rfif.alurst=rfif.oprnd1[31 : 0];
					01:rfif.alurst={01'b0 , rfif.oprnd1[31 : 01]};
					02:rfif.alurst={02'b0 , rfif.oprnd1[31 : 02]};
					03:rfif.alurst={03'b0 , rfif.oprnd1[31 : 03]};
					04:rfif.alurst={04'b0 , rfif.oprnd1[31 : 04]};
					05:rfif.alurst={05'b0 , rfif.oprnd1[31 : 05]};
					06:rfif.alurst={06'b0 , rfif.oprnd1[31 : 06]};
					07:rfif.alurst={07'b0 , rfif.oprnd1[31 : 07]};
					08:rfif.alurst={08'b0 , rfif.oprnd1[31 : 08]};
					09:rfif.alurst={09'b0 , rfif.oprnd1[31 : 09]};
					10:rfif.alurst={10'b0 , rfif.oprnd1[31 : 10]};
					11:rfif.alurst={11'b0 , rfif.oprnd1[31 : 11]};
					12:rfif.alurst={12'b0 , rfif.oprnd1[31 : 12]};
					13:rfif.alurst={13'b0 , rfif.oprnd1[31 : 13]};
					14:rfif.alurst={14'b0 , rfif.oprnd1[31 : 14]};
					15:rfif.alurst={15'b0 , rfif.oprnd1[31 : 15]};
					16:rfif.alurst={16'b0 , rfif.oprnd1[31 : 16]};
					17:rfif.alurst={17'b0 , rfif.oprnd1[31 : 17]};
					18:rfif.alurst={18'b0 , rfif.oprnd1[31 : 18]};
					19:rfif.alurst={19'b0 , rfif.oprnd1[31 : 19]};
					20:rfif.alurst={20'b0 , rfif.oprnd1[31 : 20]};
					21:rfif.alurst={21'b0 , rfif.oprnd1[31 : 21]};
					22:rfif.alurst={22'b0 , rfif.oprnd1[31 : 22]};
					23:rfif.alurst={23'b0 , rfif.oprnd1[31 : 23]};
					24:rfif.alurst={24'b0 , rfif.oprnd1[31 : 24]};
					25:rfif.alurst={25'b0 , rfif.oprnd1[31 : 25]};
					26:rfif.alurst={26'b0 , rfif.oprnd1[31 : 26]};
					27:rfif.alurst={27'b0 , rfif.oprnd1[31 : 27]};
					28:rfif.alurst={28'b0 , rfif.oprnd1[31 : 28]};
					29:rfif.alurst={29'b0 , rfif.oprnd1[31 : 29]};
					30:rfif.alurst={30'b0 , rfif.oprnd1[31 : 30]};
					31:rfif.alurst={31'b0 , rfif.oprnd1[31 : 31]};
				endcase

			ALU_AND:
				rfif.alurst = rstand;
			ALU_OR:
				rfif.alurst = rstorr;
			ALU_XOR:
				rfif.alurst = rstxor;
			ALU_NOR:
				rfif.alurst = rstnor;
			ALU_ADD:
				rfif.alurst = rstadr;
			ALU_SUB:
				rfif.alurst = rstadr;
			ALU_SLT:
				rfif.alurst = rfif.ngtflg ^ rfif.vldflg;
			ALU_SLTU:
				rfif.alurst = {31'b0 , (rfif.ngtflg | ((~rfif.vldflg)) & (~rfif.ngtflg)) & rfif.cryflg & (~rfif.zroflg)};		// truth table
		endcase
	end


endmodule