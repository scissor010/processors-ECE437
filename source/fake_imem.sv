
// cpu instructions
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped needs this
`include "register_file_if.vh"


module fake_imem(datapath_cache_if.fi dpif);

	logic [5:0] op;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [4:0] sa;
	logic [5:0] spe;

	assign dpif.imemload[31:26] = op;
	assign dpif.imemload[25:21] = rs;
	assign dpif.imemload[20:16] = rt;
	assign dpif.imemload[15:11] = rd;
	assign dpif.imemload[10:06] = sa;
	assign dpif.imemload[05:00] = spe;

	always_comb begin
		op = 0;
		rs = 0;
		rt = 0;
		rd = 0;
		sa = 0;
		spe = 0;

		casez(dpif.imemaddr)
			32'h00:begin{op,rs,rt,rd,sa,spe}=32'h2401000c;end
			32'h04:begin{op,rs,rt,rd,sa,spe}=32'h2421ffff;end
			32'h08:begin{op,rs,rt,rd,sa,spe}=32'h1001fffe;end
			32'h0C:begin{op,rs,rt,rd,sa,spe}=32'hffffffff;end
		endcase
		/*casez(dpif.imemaddr)
			default:begin
				op = 0;
				rs = 0;
				rt = 0;
				rd = 0;
				sa = 0;
				spe = 0;
			end

			0:begin
				op = RTYPE;
				rs = 0;
				rt = 0;
				rd = 1;
				sa = 0;
				spe = NOR;
			end

			4:begin
				op = RTYPE;
				rs = 1;
				rt = 1;
				rd = 2;
				sa = 5;
				spe = SLL;//GPR[rd] ← GPR[rs] << sa
			end

			8:begin
				op = RTYPE;
				rs = 1;
				rt = 1;
				rd = 0;
				sa = 5;
				spe = SLL;//GPR[rd] ← GPR[rs] << sa
			end

			12:begin
				op = RTYPE;
				rs = 1;
				rt = 1;
				rd = 1;
				sa = 5;
				spe = SLL;//GPR[rd] ← GPR[rs] << sa
			end

			16:begin
				op = RTYPE;
				rs = 2;
				rt = 1;
				rd = 3;
				sa = 17;
				spe = SRL;// R[rd] <= R[rs] >> shamt
			end

			20:begin
				op = LUI;   // GPR[rt] ← immediate || 016
				rt = 4;
				{rd , sa , spe} = 12345;
			end

			24:begin
				op = LUI;   // GPR[rt] ← immediate || 016
				rt = 5;
				{rd , sa , spe} = 54321;
			end

			28:begin
				op = RTYPE;
				rs = 4;
				rt = 5;
				rd = 2;
				sa = 17;
				spe = ADD;// 4+5=2
			end

			32:begin
				op = LUI;   // GPR[rt] ← immediate || 016
				rt = 1;
				{rd , sa , spe} = 16'b1111111111110111;
			end

			36:begin
				op = RTYPE;
				rs = 1;
				rt = 2;
				rd = 3;
				sa = 17;
				spe = SUB;// 1-2=3
			end

			40:begin
				op = LW;
				rs = 1;
				rt = 2;
				{rd , sa , spe} = 16'b1111111111110111;
			end

			44:begin
				op = SW;
				rs = 1;
				rt = 4;
				{rd , sa , spe} = 16'b1010010100101101;
			end

			48:begin
				op = LUI;   // GPR[rt] ← immediate || 016
				rt = 1;
				{rd , sa , spe} = 16'b0011000000111001;
			end

			52:begin
				op = BEQ;
				rs = 1;
				rt = 4;
				{rd , sa , spe} = 2;
			end
		endcase*/
	end



endmodule