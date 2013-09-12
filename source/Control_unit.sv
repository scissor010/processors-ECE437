
// cpu instructions
`include "cpu_types_pkg.vh"

// mapped needs this
`include "register_file_if.vh"

// control signal selects
`include "control_sel_pkg.vh"
import control_sel_pkg::*;
import cpu_types_pkg::*;
module Control_unit(register_file_if.cu rfif);

logic [5:0] opcode;
logic [5:0] rcode;

assign opcode		 = dpif.imemload[31:26];
assign rcode		 = dpif.imemload[5:0];

// instruction decode
	always_comb begin
		rfif.halt = 0;
		rfif.PC4EN	 = 1;
		rfif.cu_rWEN	 = 'd0;
		rfif.alucode	 = 'dx;
		rfif.cu_dmemREN	 = 'd0;
		rfif.cu_dmemWEN	 = 'd0;
		rfif.op2sel		 = 'dx;
		rfif.extmode	 = 'dx;
		rfif.wseles		 = 'dx;
		rfif.wdat_sel	 = 'dx;
		rfif.PCsel	 = 'dx;
		casez(opcode)
		// alu r type instructions
		RTYPE:begin
			rfif.halt = 0;
			rfif.PC4EN		 = 1;
			rfif.cu_rWEN		 = 'd0;
			rfif.alucode	 = 'dx;
			rfif.cu_dmemREN	 = 'd0;
			rfif.cu_dmemWEN	 = 'd0;
			rfif.op2sel		 = 'dx;
			rfif.extmode	 = 'dx;
			rfif.wseles		 = 'dx;
			rfif.wdat_sel	 = 'dx;
			rfif.PCsel		 = 'dx;
			casez(rcode)
				SLL:begin		// GPR[rd] ← GPR[rs] << sa , // oprnd1 is GPR[rs],oprnd2 is sa
					rfif.alucode = ALU_SLL;
					rfif.op2sel = OP2_SA;
					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				SRL:begin		// GPR[rd] ← GPR[rs] >> sa , // oprnd1 is GPR[rs],oprnd2 is sa
					rfif.alucode = ALU_SRL;
					rfif.op2sel = OP2_SA;

					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				JR:begin
					rfif.PC4EN = 0;
					rfif.PCsel = PC_JR;
				end
				ADDU:begin 		// GPR[rd] ← GPR[rs] + GPR[rt]
					rfif.alucode = ALU_ADD;
					rfif.op2sel = OP2_RDAT;

					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				SUBU:begin		// GPR[rd] ← GPR[rs] − GPR[rt] , oprnd1 +- oprnd2
					rfif.alucode = ALU_SUB;
					rfif.op2sel = OP2_RDAT;

					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				AND:begin		// GPR[rd] ← GPR[rs] and GPR[rt]
					rfif.alucode = ALU_AND;
					rfif.op2sel = OP2_RDAT;

					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				OR:begin
					rfif.alucode = ALU_OR;
					rfif.op2sel = OP2_RDAT;
					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				XOR:begin		// GPR[rd] ← GPR[rs] XOR GPR[rt]
					rfif.alucode = ALU_XOR;
					rfif.op2sel = OP2_RDAT;

					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				NOR:begin		// GPR[rd] ← GPR[rs] nor GPR[rt]
					rfif.alucode = ALU_NOR;
					rfif.op2sel = OP2_RDAT;

					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				SLT:begin		// GPR[rd] ← (GPR[rs] < GPR[rt]) , oprnd1 < oprnd2
					rfif.alucode = ALU_SLT;
					rfif.op2sel = OP2_RDAT;

					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				SLTU:begin		// GPR[rd] ← (GPR[rs] < GPR[rt])
					rfif.alucode = ALU_SLTU;
					rfif.op2sel = OP2_RDAT;
					rfif.wseles = WSEL_RD;
					rfif.wdat_sel = WDAT_ALU;
					rfif.cu_rWEN = 1;
				end
				default:begin
					rfif.halt = 0;
					rfif.PC4EN		 = 1;
					rfif.cu_rWEN		 = 'd0;
					rfif.alucode	 = 'dx;
					rfif.cu_dmemREN	 = 'd0;
					rfif.cu_dmemWEN	 = 'd0;
					rfif.op2sel		 = 'dx;
					rfif.extmode	 = 'dx;
					rfif.wseles		 = 'dx;
					rfif.wdat_sel	 = 'dx;
					rfif.PCsel		 = 'dx;
				end
			endcase
		end
		// not alu insts
			SW:begin
				rfif.alucode = ALU_ADD;
				rfif.extmode = EXT_SIGN;
				rfif.op2sel = OP2_IMM;
				rfif.cu_dmemWEN = 1;
			end
			LW:begin

				rfif.alucode = ALU_ADD;
				rfif.op2sel = OP2_IMM;
				rfif.wdat_sel = WDAT_MEM;
				rfif.extmode = EXT_SIGN;
				rfif.cu_rWEN = 1;
				rfif.cu_dmemREN = 1;
				rfif.wseles = WSEL_RT;
			end
			LUI:begin		// GPR[rt] ← immediate || 0*16
				rfif.wseles = WSEL_RT;
				rfif.cu_rWEN = 1;
				rfif.wdat_sel = WDAT_LUI;
			end
			J:begin
				rfif.PCsel = PC_JI;
				rfif.PC4EN = 0;
			end
			JAL:begin		// R[31] <= npc; PC <= JumpAddr
				rfif.PCsel = PC_JI;
				rfif.PC4EN = 0;

				rfif.wseles = 31;
				rfif.cu_rWEN = 1;
				rfif.wdat_sel = WDAT_PC4;
			end
		// alu i type
			ANDI:begin		// GPR[rt] ← GPR[rs] AND immediate
				rfif.op2sel = OP2_IMM;
				rfif.alucode = ALU_AND;
				rfif.extmode = EXT_ZERO;
				rfif.wseles = WSEL_RT;
				rfif.cu_rWEN = 1;
				rfif.wdat_sel = WDAT_ALU;
			end
			ORI:begin		// GPR[rt] ← GPR[rs] or immediate
				rfif.op2sel = OP2_IMM;
				rfif.alucode = ALU_OR;
				rfif.extmode = EXT_ZERO;
				rfif.wseles = WSEL_RT;
				rfif.cu_rWEN = 1;
				rfif.wdat_sel = WDAT_ALU;
			end
			XORI:begin		// R[rt] <= R[rs] XOR ZeroExtImm
				rfif.op2sel = OP2_IMM;

				rfif.alucode = ALU_XOR;
				rfif.extmode = EXT_ZERO;
				rfif.wseles = WSEL_RT;
				rfif.cu_rWEN = 1;
				rfif.wdat_sel = WDAT_ALU;
			end
			ADDIU:begin		// GPR[rt] ← GPR[rs] + sign_extend(immediate)
				rfif.op2sel = OP2_IMM;
				rfif.alucode = ALU_ADD;
				rfif.wseles = WSEL_RT;
				rfif.cu_rWEN = 1;
				rfif.wdat_sel = WDAT_ALU;
				rfif.extmode = EXT_SIGN;
			end
			BEQ:begin		// PC <= (R[rs] == R[rt]) ? npc+BranchAddr : npc

				rfif.op2sel = OP2_RDAT;
				rfif.alucode = ALU_SUB;
				if(rfif.zroflg)begin
					rfif.PC4EN = 0;
					rfif.PCsel = PC_BR;
					rfif.extmode = EXT_SIGN;
				end else begin
					rfif.PC4EN = 1;
				end
			end
			BNE:begin		// PC <= (R[rs] != R[rt]) ? npc+BranchAddr : npc
				rfif.op2sel = OP2_RDAT;
				rfif.alucode = ALU_SUB;
				if(!rfif.zroflg)begin
					rfif.PC4EN = 0;
					rfif.PCsel = PC_BR;
					rfif.extmode = EXT_SIGN;
				end else begin
					rfif.PC4EN = 1;
				end
			end
			SLTI:begin		// GPR[rt] ← (GPR[rs] < imm) , oprnd1 < oprnd2
				rfif.op2sel = OP2_IMM;
				rfif.extmode = EXT_SIGN;
				rfif.alucode = ALU_SLT;
				rfif.wseles = WSEL_RT;
				rfif.wdat_sel = WDAT_ALU;
				rfif.cu_rWEN = 1;
			end
			SLTIU:begin		// GPR[rt] ← (GPR[rs] < GPR[rt]) , oprnd1 < oprnd2
				rfif.op2sel = OP2_IMM;
				rfif.extmode = EXT_SIGN;
				rfif.alucode = ALU_SLTU;
				rfif.wseles = WSEL_RT;
				rfif.wdat_sel = WDAT_ALU;
				rfif.cu_rWEN = 1;
			end
			HALT:begin		// trapped
				rfif.PC4EN = 0;
				rfif.halt = 1;
			end
			default:begin
				rfif.halt = 0;
				rfif.PC4EN		 = 1;
				rfif.cu_rWEN		 = 'dx;
				rfif.alucode	 = 'dx;
				rfif.cu_dmemREN	 = 'd0;
				rfif.cu_dmemWEN	 = 'd0;
				rfif.op2sel	 	 = 'dx;
				rfif.extmode	 = 'dx;
				rfif.wseles		 = 'dx;
				rfif.wdat_sel	 = 'dx;
				rfif.PCsel		 = 'dx;
			end
		endcase
	end
endmodule