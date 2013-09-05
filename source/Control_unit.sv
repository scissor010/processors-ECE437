
// cpu instructions
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped needs this
`include "register_file_if.vh"


module Control_unit(register_file_if.cu rfif);

// temp values for easier expression
	logic [5:0] opcode;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [4:0] sa;
	logic [15:0] imm;
	logic [25:0] JumpAddr;
	logic [15:0] offset;
	logic [5:0] rcode;


	assign opcode = rfif.inst[31:26];
	assign rs = rfif.inst[25:21];
	assign rt = rfif.inst[20:16];
	assign rd = rfif.inst[15:11];
	assign sa = rfif.inst[10:06];
	assign imm = rfif.inst[15:0];
	assign JumpAddr = rfif.inst[25:0];
	assign offset = rfif.inst[15:0];
	assign rcode = rfif.inst[5:0];


	word_t PC4 , PCelse;
	logic PC4EN;
	assign PC4 = rfif.PC + 4;
	assign rfif.PCnxt = (PC4EN)?PC4:PCelse;

// instruction decode
	always_comb begin
		PC4EN = 1;
		PCelse = 'bx;
		rfif.alucode = 'bx;
		rfif.oprnd1 = 'bx;
		rfif.oprnd2 = 'bx;
		rfif.rsel1  = 'bx;
		rfif.rsel2  = 'bx;
		rfif.wsel = 'bx;
		rfif.wdat = 'bx;
		rfif.dmemaddr = 'bx;

		rfif.imemREN = 0;
		rfif.dmemREN = 0;
		rfif.dmemWEN = 0;
		rfif.rWEN = 0;

		rfif.dmemstore = 32'dx;	// only SW uses dememstore
		casez(opcode)
		// alu r type instructions
		RTYPE:
		begin
			rfif.alucode = 'dx;
			rfif.rsel1 = 'dx;
			rfif.rsel2 = 'dx;
			rfif.oprnd1 = 'dx;
			rfif.oprnd2 = 'dx;
			rfif.wsel = 'dx;
			rfif.wdat = 'dx;
			rfif.rWEN = 0;
			casez(rcode)
				SLL:		// GPR[rd] ← GPR[rs] << sa , // oprnd1 is GPR[rs],oprnd2 is sa
				begin
					rfif.alucode = ALU_SLL;
					rfif.rsel1  = rs;	// GPR[rt]
					rfif.oprnd1 = rfif.rdat1;
					rfif.oprnd2 = sa;
					rfif.wsel = rd;		// GPR[rd]
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				SRL:		// GPR[rd] ← GPR[rt] >> sa , // oprnd1 is GPR[rt],oprnd2 is sa
				begin
					rfif.alucode = ALU_SRL;

					rfif.rsel1  = rt;	// GPR[rt]
					rfif.oprnd1 = rfif.rdat1;

					rfif.oprnd2 = sa;

					rfif.wsel = rd;		// GPR[rd]
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				ADDU: 		// GPR[rd] ← GPR[rs] + GPR[rt]
				begin

					rfif.alucode = ALU_ADD;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				SUBU:		// GPR[rd] ← GPR[rs] − GPR[rt] , oprnd1 +- oprnd2
				begin

					rfif.alucode = ALU_SUB;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				AND:		// GPR[rd] ← GPR[rs] and GPR[rt]
				begin
					rfif.alucode = ALU_AND;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				OR:			// GPR[rd] ← GPR[rs] or GPR[rt]
				begin
					rfif.alucode = ALU_OR;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				XOR:		// GPR[rd] ← GPR[rs] XOR GPR[rt]
				begin
					rfif.alucode = ALU_XOR;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				NOR:		// GPR[rd] ← GPR[rs] nor GPR[rt]
				begin
					rfif.alucode = ALU_NOR;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				SLT:		// GPR[rd] ← (GPR[rs] < GPR[rt]) , oprnd1 < oprnd2
				begin

					rfif.alucode = ALU_SLT;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				SLTU:		// GPR[rd] ← (GPR[rs] < GPR[rt])
				begin

					rfif.alucode = ALU_SLTU;

					rfif.rsel1 = rs;
					rfif.oprnd1 = rfif.rdat1;

					rfif.rsel2 = rt;
					rfif.oprnd2 = rfif.rdat2;

					rfif.wsel = rd;
					rfif.wdat = rfif.alurst;
					rfif.rWEN = 1;
				end

				default:
				begin
					rfif.alucode = 'bx;
					rfif.oprnd1 = 'bx;
					rfif.oprnd2 = 'bx;
					rfif.rsel1  = 'bx;
					rfif.rsel2  = 'bx;
					rfif.wsel = 'bx;
					rfif.wdat = 'bx;
					rfif.rWEN = 0;
				end
			endcase
		end

		// not alu insts
			LUI:		// GPR[rt] ← immediate || 0*16
			begin
				rfif.wsel = rt;
				rfif.wdat = {imm , 16'b0};
				rfif.rWEN = 1;
			end

			SW:			// M[R[rs] + SignExtImm] <= R[rt]
			begin
				// read R[rt]
				rfif.rsel1 = rt;
				// read R[rs]
				rfif.rsel2 = rs;

				// use alu to calc address
				rfif.oprnd1 = rfif.rdat2;
				rfif.dmemaddr = rfif.alurst;
				rfif.alucode = ALU_ADD;
				rfif.dmemstore = rfif.rdat1;	// only SW uses dememstore

				if(imm[15] == 1'b1)begin	// sign ext
				//	rfif.dmemaddr = rfif.rdat2 + {16'b1111111111111111 , imm};
				// use alu instead
					rfif.oprnd2 = {16'b1111111111111111 , imm};
				end else begin
				//	rfif.oprnd2 = rfif.rdat2 + {16'b0 , imm};
					rfif.oprnd2 = {16'b0 , imm};
				end
				rfif.dmemWEN = 1;
			end

			LW:			// R[rt] <= M[R[rs] + SignExtImm]
			begin
				// read R[rt] R[rs]
				rfif.rsel1 = rt;
				rfif.rsel2 = rs;

				// use alu to calc address
				rfif.oprnd2 = rfif.rdat2;
				rfif.dmemaddr = rfif.alurst;
				rfif.alucode = ALU_ADD;
				if(imm[15] == 1'b1)begin
					rfif.oprnd1 = {16'b1111111111111111 , imm};
				end else begin
					rfif.oprnd1 = {16'b0 , imm};
				end
				rfif.wdat = rfif.dmemload;
				rfif.rWEN = 1;
				rfif.dmemREN = 1;
			end

			LUI:		// GPR[rt] ← immediate || 0*16
			begin
				rfif.wsel = rt;
				rfif.rWEN = 1;
				rfif.wdat = {imm , 16'b0};
				rfif.dmemWEN = 1;
			end

			J:			// PC <= JumpAddr PC ← PCGPRLEN-1..28 || instr_index || 02
			begin
				PCelse = {rfif.PC[31:28] , JumpAddr , 2'b00};
				PC4EN = 0;
			end

			JR:			//  PC <= R[rs]
			begin
				PC4EN = 0;
				PCelse = rfif.rdat2;
				rfif.rsel2 = rs;
			end

			JAL:		// R[31] <= npc; PC <= JumpAddr
			begin
				PCelse = {rfif.PC[31:28] , JumpAddr , 2'b0};
				PC4EN = 0;

				rfif.wsel = 31;
				rfif.rWEN = 1;
				rfif.wdat = PC4;
			end

		// alu i type
			ANDI:		// GPR[rt] ← GPR[rs] AND immediate
			begin
				rfif.rsel2 = rs;
				rfif.oprnd2 = rfif.rdat2;
				rfif.oprnd1 = {16'b0 , imm};	// zero extend

				rfif.alucode = ALU_AND;

				rfif.wsel = rt;
				rfif.rWEN = 1;
				rfif.wdat = rfif.alurst;
			end

			ORI:		// GPR[rt] ← GPR[rs] or immediate
			begin
				rfif.rsel2 = rs;
				rfif.oprnd2 = rfif.rdat2;
				rfif.oprnd1 = {16'b0 , imm};	// zero extend

				rfif.alucode = ALU_OR;

				rfif.wsel = rt;
				rfif.rWEN = 1;
				rfif.wdat = rfif.alurst;
			end

			XORI:		// R[rt] <= R[rs] XOR ZeroExtImm
			begin
				rfif.rsel2 = rs;
				rfif.oprnd2 = rfif.rdat2;
				rfif.oprnd1 = {16'b0 , imm};	// zero extend

				rfif.alucode = ALU_XOR;

				rfif.wsel = rt;
				rfif.rWEN = 1;
				rfif.wdat = rfif.alurst;
			end

			ADDIU:		// GPR[rt] ← GPR[rs] + sign_extend(immediate)
			begin
				rfif.rsel2 = rs;
				rfif.oprnd2 = rfif.rdat2;
				if(imm[15] == 1'b1)begin
					rfif.oprnd1 = {16'b1111111111111111 , imm};
				end else begin
					rfif.oprnd1 = {16'b0 , imm};
				end
				rfif.alucode = ALU_ADD;
				rfif.wsel = rt;
				rfif.rWEN = 1;
				rfif.wdat = rfif.alurst;
			end

			BEQ:		// PC <= (R[rs] == R[rt]) ? npc+BranchAddr : npc
			begin
				rfif.rsel1  = rs;
				rfif.rsel2  = rt;

				rfif.oprnd1 = rfif.rdat1;
				rfif.oprnd2 = rfif.rdat2;

				rfif.alucode = ALU_SUB;

				if(rfif.zroflg)begin
					PC4EN = 0;
					// sign extend
					if(offset[15])begin
						PCelse = PC4+{14'd11111111111111 , offset , 2'b00};
					end else begin
						PCelse = PC4+{14'b0 , offset , 2'b00};
					end
				end else begin
					PC4EN = 1;
					PCelse = 'bx;
				end
			end

			BNE:		// PC <= (R[rs] != R[rt]) ? npc+BranchAddr : npc
			begin
				rfif.rsel1  = rs;
				rfif.rsel2  = rt;

				rfif.oprnd1 = rfif.rdat1;
				rfif.oprnd2 = rfif.rdat2;

				rfif.alucode = ALU_SUB;

				if(!rfif.zroflg)begin
					PC4EN = 0;
					// sign extend
					if(offset[15])begin
						PCelse = PC4+{14'h3fff , offset , 2'b00};
					end else begin
						PCelse = PC4+{14'b0 , offset , 2'b00};
					end
				end else begin
					PC4EN = 1;
					PCelse = 'bx;
				end
			end

			SLTI:		// GPR[rd] ← (GPR[rs] < GPR[rt]) , oprnd1 < oprnd2
			begin
				if(imm[15])begin
					rfif.oprnd2 = {16'd1 , imm};
				end else begin
					rfif.oprnd2 = {16'b0 , imm};
				end

				rfif.alucode = ALU_SLT;

				rfif.rsel1 = rs;
				rfif.oprnd1 = rfif.rdat1;

				rfif.wsel = rt;
				rfif.wdat = rfif.alurst;
			end

			SLTIU:		// GPR[rd] ← (GPR[rs] < GPR[rt]) , oprnd1 < oprnd2
			begin
				if(imm[15])begin
					rfif.oprnd2 = {16'd1 , imm};
				end else begin
					rfif.oprnd2 = {16'b0 , imm};
				end

				rfif.alucode = ALU_SLTU;

				rfif.rsel1 = rs;
				rfif.oprnd1 = rfif.rdat1;

				rfif.wsel = rt;
				rfif.wdat = rfif.alurst;
			end

			HALT:		// trapped
			begin
				PC4EN = 0;
				PCelse = rfif.PC;
			end

			default:
			begin
				PC4EN = 1;
				PCelse = 'bx;
				rfif.alucode = 'bx;
				rfif.oprnd1 = 'bx;
				rfif.oprnd2 = 'bx;
				rfif.rsel1  = 'bx;
				rfif.rsel2  = 'bx;
				rfif.wsel = 'bx;
				rfif.wdat = 'bx;
				rfif.dmemaddr = 'bx;

				rfif.imemREN = 0;
				rfif.dmemREN = 0;
				rfif.dmemWEN = 0;
				rfif.rWEN = 0;
			end
		endcase
	end



endmodule