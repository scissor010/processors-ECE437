/*
	Mingfei Huang
	datapath testbench
*/

// cpu instructions
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;
// mapped needs this
`include "register_file_if.vh"
// data path interface
`include "datapath_cache_if.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module datapath_tb;

	logic CLK , nRST;

	datapath_cache_if dpif();

	datapath DP_DUT(CLK , nRST , dpif);

	// fake stuff
	fake_imem FI_DUT(dpif);

	// not used
	assign dpif.ihit = 1'b0;
	assign dpif.dhit = 1'b0;
/*
	logic [5:0] op;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [4:0] sa;
	logic [5:0] spe;
*/
//	assign imm = {rd , sa , spe};

//	assign dpif.imemload = {op , rs , rt , rd , sa , spe};

	parameter PERIOD = 10;

	always begin : proc_
		#(PERIOD/2);
		CLK = 0;
		#(PERIOD/2);
		CLK = 1;
	end

	initial begin
		nRST = 0;
		#PERIOD;
		nRST = 1;
	end

	initial begin
		//#(PERIOD);
		$monitor("
PC:%d
reg%d:  %d:%b
reg%d:  %d:%b
reg%d:  %d:%b
reg%d:  %d:%b
reg%d:  %d:%b
reg%d:  %d:%b
dmemstore=%b
dmemaddr= %b
imemREN = %b
dmemREN = %b
dmemWEN = %b"
, dpif.imemaddr
, 00 , DP_DUT.regfile.data[00] , DP_DUT.regfile.data[00]
, 01 , DP_DUT.regfile.data[01] , DP_DUT.regfile.data[01]
, 02 , DP_DUT.regfile.data[02] , DP_DUT.regfile.data[02]
, 03 , DP_DUT.regfile.data[03] , DP_DUT.regfile.data[03]
, 04 , DP_DUT.regfile.data[04] , DP_DUT.regfile.data[04]
, 05 , DP_DUT.regfile.data[05] , DP_DUT.regfile.data[05]
/*
, 06 , DP_DUT.regfile.data[06] , DP_DUT.regfile.data[06]
, 07 , DP_DUT.regfile.data[07] , DP_DUT.regfile.data[07]
, 08 , DP_DUT.regfile.data[08] , DP_DUT.regfile.data[08]
, 09 , DP_DUT.regfile.data[09] , DP_DUT.regfile.data[09]
, 10 , DP_DUT.regfile.data[10] , DP_DUT.regfile.data[10]
, 11 , DP_DUT.regfile.data[11] , DP_DUT.regfile.data[11]
, 12 , DP_DUT.regfile.data[12] , DP_DUT.regfile.data[12]
, 13 , DP_DUT.regfile.data[13] , DP_DUT.regfile.data[13]
, 14 , DP_DUT.regfile.data[14] , DP_DUT.regfile.data[14]
, 15 , DP_DUT.regfile.data[15] , DP_DUT.regfile.data[15]
, 16 , DP_DUT.regfile.data[16] , DP_DUT.regfile.data[16]
, 17 , DP_DUT.regfile.data[17] , DP_DUT.regfile.data[17]
, 18 , DP_DUT.regfile.data[18] , DP_DUT.regfile.data[18]
, 19 , DP_DUT.regfile.data[19] , DP_DUT.regfile.data[19]
, 20 , DP_DUT.regfile.data[20] , DP_DUT.regfile.data[20]
, 21 , DP_DUT.regfile.data[21] , DP_DUT.regfile.data[21]
, 22 , DP_DUT.regfile.data[22] , DP_DUT.regfile.data[22]
, 23 , DP_DUT.regfile.data[23] , DP_DUT.regfile.data[23]
, 24 , DP_DUT.regfile.data[24] , DP_DUT.regfile.data[24]
, 25 , DP_DUT.regfile.data[25] , DP_DUT.regfile.data[25]
, 26 , DP_DUT.regfile.data[26] , DP_DUT.regfile.data[26]
, 27 , DP_DUT.regfile.data[27] , DP_DUT.regfile.data[27]
, 28 , DP_DUT.regfile.data[28] , DP_DUT.regfile.data[28]
, 29 , DP_DUT.regfile.data[29] , DP_DUT.regfile.data[29]
, 30 , DP_DUT.regfile.data[30] , DP_DUT.regfile.data[30]
, 31 , DP_DUT.regfile.data[31] , DP_DUT.regfile.data[31]*/
, dpif.dmemstore
, dpif.dmemaddr
, dpif.imemREN
, dpif.dmemREN
, dpif.dmemWEN);

/*
		op = 0;
		rs = 0;
		rt = 0;
		rd = 0;
		sa = 0;
		spe = 0;
		dpif.dmemload = 0;

		nRST = 0;
		#(PERIOD);
		nRST = 1;

		num = 1;
		op = RTYPE;
		rs = 0;
		rt = 0;
		rd = 1;
		sa = 0;
		spe = NOR;
		dpif.dmemload = 0;

		#(PERIOD);
		num = 2;
		op = RTYPE;
		rs = 1;
		rt = 1;
		rd = 2;
		sa = 5;
		spe = SLL;//GPR[rd] ← GPR[rs] << sa
		dpif.dmemload = 0;

		#(PERIOD);
		num = 3;
		op = RTYPE;
		rs = 1;
		rt = 1;
		rd = 0;
		sa = 5;
		spe = SLL;//GPR[rd] ← GPR[rs] << sa
		dpif.dmemload = 0;

		#(PERIOD);
		num = 4;
		op = RTYPE;
		rs = 1;
		rt = 1;
		rd = 1;
		sa = 5;
		spe = SLL;//GPR[rd] ← GPR[rs] << sa
		dpif.dmemload = 0;

		#(PERIOD);
		num = 5;
		op = RTYPE;
		rs = 2;
		rt = 1;
		rd = 3;
		sa = 17;
		spe = SRL;// R[rd] <= R[rs] >> shamt
		dpif.dmemload = 0;

		#(PERIOD);
		num = 6;
		op = LUI;	// GPR[rt] ← immediate || 016
		rt = 4;
		{rd , sa , spe} = 12345;
		dpif.dmemload = 0;

		#(PERIOD);
		num = 7;
		op = LUI;	// GPR[rt] ← immediate || 016
		rt = 5;
		{rd , sa , spe} = 54321;
		dpif.dmemload = 0;

		#(PERIOD);
		num = 8;
		op = RTYPE;
		rs = 4;
		rt = 5;
		rd = 2;
		sa = 17;
		spe = ADD;// 4+5=2
		dpif.dmemload = 0;

		#(PERIOD);
		num = 9;
		op = LUI;	// GPR[rt] ← immediate || 016
		rt = 1;
		{rd , sa , spe} = 16'b1111111111110111;
		dpif.dmemload = 0;

		#(PERIOD);
		num = 10;
		op = RTYPE;
		rs = 1;
		rt = 2;
		rd = 3;
		sa = 17;
		spe = SUB;// 1-2=3
		dpif.dmemload = 0;

		#(PERIOD);
		num = 11;
		op = LW;
		rs = 1;
		rt = 2;
		{rd , sa , spe} = 16'b1111111111110111;
		dpif.dmemload = 10210;

		#(PERIOD);
		num = 12;
		op = SW;
		rs = 1;
		rt = 4;
		{rd , sa , spe} = 16'b1010010100101101;
		dpif.dmemload = 10210;

		#(PERIOD);
		num = 13;
		op = LUI;	// GPR[rt] ← immediate || 016
		rt = 1;
		{rd , sa , spe} = 16'b0011000000111001;
		dpif.dmemload = 0;

		$display("pc:%d" , dpif.imemaddr);

		#(PERIOD);
		num = 14;
		op = BEQ;
		rs = 1;
		rt = 4;
		{rd , sa , spe} = 2;
		dpif.dmemload = 10210;
		#(PERIOD);
		$display("pc:%d" , dpif.imemaddr);
		#(PERIOD);
		$display("pc:%d" , dpif.imemaddr);
*/
	end

endmodule