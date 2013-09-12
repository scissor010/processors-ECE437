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

`ifndef MAPPED
	Control_unit CU_DUT(rfif);
	Alu ALU_DUT(rfif);
	register_file REG_DUT(rfif , CLK , nRST);
	fake_imem ram(rfif);
`else
	Control_unit CU_DUT(
		rfif.inst,	// from memory
		rfif.rdat1, rfif.rdat2,	// from reg file
		rfif.alurst,		// from alu
		rfif.vldflg , rfif.cryflg , rfif.ngtflg , rfif.zroflg, // alu flags
		rfif.imemload, rfif.dmemload,		// from datapath/memory
		rfif.PC,						// from datapath/memory
		rfif.rWEN , rfif.wsel , rfif.rsel1 , rfif.rsel2 , rfif.wdat,	//	 to register file
		rfif.oprnd1 , rfif.oprnd2 , rfif.alucode,		// to alu
		rfif.imemREN, rfif.dmemREN, rfif.dmemWEN, rfif.dmemstore, rfif.dmemaddr, rfif.PCnxt	// to datapath/memory
	);
	Alu ALU_DUT(
		rfif.oprnd1 , rfif.oprnd2 , rfif.alucode,
		rfif.alurst , rfif.vldflg , rfif.cryflg , rfif.ngtflg , rfif.zroflg
	);
	register_file REG_DUT(

		rfif.rWEN, rfif.wsel, rfif.rsel1, rfif.rsel2, rfif.wdat,
		rfif.rdat1, rfif.rdat2 , CLK , nRST
	);
	fake_imem FI_DUT(
		rfif.PC,
		rfif.dmemREN,
		rfif.dmemWEN,
		rfif.imemload
	);
`endif


	string spec , opc;

	word_t PC;	// pc current state
	assign rfif.PC = PC;
	// program counter stuff
	always_ff@(posedge CLK or negedge nRST) begin
		if(~nRST) begin
			PC <= 0;
		end else begin
			PC <= rfif.PCnxt;
		end
	end

	logic [5:0] op;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [4:0] sa;
	logic [5:0] spe;

	assign {op , rs , rt , rd , sa , spe} = rfif.imemload;
	assign rfif.inst = rfif.imemload;

	parameter PERIOD = 10;

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

	always @(rfif.PC , rfif.imemload,rfif.dmemstore,rfif.dmemaddr,rfif.imemREN,rfif.dmemREN,rfif.dmemWEN)
	begin
		//#(PERIOD);
		printmsg(spe , op);

		$monitor("
PC:%3d %3h:
%s rs=%d rt=%d rd=%d sa=%d %s
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
reg%2d:  %d:%h:%b
dmemstore=%b
dmemaddr= %b
imemREN = %1b
dmemREN = %1b
dmemWEN = %1b
vldflg cryflg ngtflg zroflg
  %b     %b     %b     %b"
, rfif.PC, rfif.PC
,opc , rs , rt , rd , sa , spec
, 00 , REG_DUT.data[00] , REG_DUT.data[00] , REG_DUT.data[00]
, 01 , REG_DUT.data[01] , REG_DUT.data[01] , REG_DUT.data[01]
, 02 , REG_DUT.data[02] , REG_DUT.data[02] , REG_DUT.data[02]
, 03 , REG_DUT.data[03] , REG_DUT.data[03] , REG_DUT.data[03]
, 04 , REG_DUT.data[04] , REG_DUT.data[04] , REG_DUT.data[04]
, 05 , REG_DUT.data[05] , REG_DUT.data[05] , REG_DUT.data[05]
, 31 , REG_DUT.data[31] , REG_DUT.data[31] , REG_DUT.data[31]
, rfif.dmemstore
, rfif.dmemaddr
, rfif.imemREN
, rfif.dmemREN
, rfif.dmemWEN
, rfif.vldflg , rfif.cryflg , rfif.ngtflg , rfif.zroflg);
end
endmodule