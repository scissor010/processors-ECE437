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

	logic [5:0] op;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [4:0] sa;
	logic [5:0] spe;

	assign {op , rs , rt , rd , sa , spe} = dpif.imemload;

//	assign imm = {rd , sa , spe};

//	assign dpif.imemload = {op , rs , rt , rd , sa , spe};

	parameter PERIOD = 10;

	string opc;
	string spec;

	task printmsg (input [5:0] spe , [5:0] op);
		if(op==0)begin
			case(spe)
				6'b000000:spec="SLL";
				6'b000010:spec="SRL";
				6'b001000:spec="JR";
				6'b100000:spec="ADD";
				6'b100001:spec="ADDU";
				6'b100010:spec="SUB";
				6'b100011:spec="SUBU";
				6'b100100:spec="AND";
				6'b100101:spec="OR";
				6'b100110:spec="XOR";
				6'b100111:spec="NOR";
				6'b101010:spec="SLT";
				6'b101011:spec="SLTU";
				default:spec="UNKNOWN";
			endcase	// alucode print
		end else begin
			$sformat(spec, "%6b", spe);
		end
		case(op)
			6'b000000:opc="RTYPE";
			6'b000010:opc="J";
			6'b000011:opc="JAL";
			6'b000100:opc="BEQ";
			6'b000101:opc="BNE";
			6'b001000:opc="ADDI";
			6'b001001:opc="ADDIU";
			6'b001010:opc="SLTI";
			6'b001011:opc="SLTIU";
			6'b001100:opc="ANDI";
			6'b001101:opc="ORI";
			6'b001110:opc="XORI";
			6'b001111:opc="LUI";
			6'b100011:opc="LW";
			6'b100100:opc="LBU";
			6'b100101:opc="LHU";
			6'b101000:opc="SB";
			6'b101001:opc="SH";
			6'b101011:opc="SW";
			6'b110000:opc="LL";
			6'b111000:opc="SC";
			6'b111111:opc="HALT";
			6'b000000:opc="SLL";
			6'b000010:opc="SRL";
			6'b001000:opc="JR";
			6'b100000:opc="ADD";
			6'b100001:opc="ADDU";
			6'b100010:opc="SUB";
			6'b100011:opc="SUBU";
			6'b100100:opc="AND";
			6'b100101:opc="OR";
			6'b100110:opc="XOR";
			6'b100111:opc="NOR";
			6'b101010:opc="SLT";
			6'b101011:opc="SLTU";
			default:opc="UNKNOWN!!";
		endcase
	endtask

	always begin : clk
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

	always @(dpif.imemaddr , dpif.imemload,dpif.dmemstore,dpif.dmemaddr,dpif.imemREN,dpif.dmemREN,dpif.dmemWEN)
	begin
		//#(PERIOD);
		printmsg(spe , op);

		$monitor("
PC:%d:
%s rs=%d rt=%d rd=%d sa=%d %s
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
dmemstore=%b
dmemaddr= %b
imemREN = %b
dmemREN = %b
dmemWEN = %b"
, dpif.imemaddr
,opc , rs , rt , rd , sa , spec
, 00 , DP_DUT.regfile.data[00] , DP_DUT.regfile.data[00] , DP_DUT.regfile.data[00]
, 01 , DP_DUT.regfile.data[01] , DP_DUT.regfile.data[01] , DP_DUT.regfile.data[01]
, 02 , DP_DUT.regfile.data[02] , DP_DUT.regfile.data[02] , DP_DUT.regfile.data[02]
, 03 , DP_DUT.regfile.data[03] , DP_DUT.regfile.data[03] , DP_DUT.regfile.data[03]
, 04 , DP_DUT.regfile.data[04] , DP_DUT.regfile.data[04] , DP_DUT.regfile.data[04]
, 05 , DP_DUT.regfile.data[05] , DP_DUT.regfile.data[05] , DP_DUT.regfile.data[05]
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
		$display("pc:%d" , dpif.imemaddr);*/
	end

endmodule