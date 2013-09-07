
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
32'h00:{op,rs,rt,rd,sa,spe}=32'h241D0FFC;
32'h04:{op,rs,rt,rd,sa,spe}=32'h0C00000A;
32'h08:{op,rs,rt,rd,sa,spe}=32'h24010011;
32'h0C:{op,rs,rt,rd,sa,spe}=32'h27BDFFFC;
32'h10:{op,rs,rt,rd,sa,spe}=32'hAFA10000;
32'h14:{op,rs,rt,rd,sa,spe}=32'h24010003;
32'h18:{op,rs,rt,rd,sa,spe}=32'h27BDFFFC;
32'h1C:{op,rs,rt,rd,sa,spe}=32'hAFA10000;
32'h20:{op,rs,rt,rd,sa,spe}=32'h0C00000A;
32'h24:{op,rs,rt,rd,sa,spe}=32'hFFFFFFFF;
32'h28:{op,rs,rt,rd,sa,spe}=32'h27A10000;
32'h2C:{op,rs,rt,rd,sa,spe}=32'h27BDFFFC;
32'h30:{op,rs,rt,rd,sa,spe}=32'hAFBF0000;
32'h34:{op,rs,rt,rd,sa,spe}=32'h27BDFFFC;
32'h38:{op,rs,rt,rd,sa,spe}=32'hAFA20000;
32'h3C:{op,rs,rt,rd,sa,spe}=32'h27BDFFFC;
32'h40:{op,rs,rt,rd,sa,spe}=32'hAFA30000;
32'h44:{op,rs,rt,rd,sa,spe}=32'h27BDFFFC;
32'h48:{op,rs,rt,rd,sa,spe}=32'hAFA40000;
32'h4C:{op,rs,rt,rd,sa,spe}=32'h27BDFFFC;
32'h50:{op,rs,rt,rd,sa,spe}=32'hAFA50000;
32'h54:{op,rs,rt,rd,sa,spe}=32'h8C220000;
32'h58:{op,rs,rt,rd,sa,spe}=32'h8C230004;
32'h5C:{op,rs,rt,rd,sa,spe}=32'h00052824;
32'h60:{op,rs,rt,rd,sa,spe}=32'h30640001;
32'h64:{op,rs,rt,rd,sa,spe}=32'h10800001;
32'h68:{op,rs,rt,rd,sa,spe}=32'h00A22821;
32'h6C:{op,rs,rt,rd,sa,spe}=32'h00401040;
32'h70:{op,rs,rt,rd,sa,spe}=32'h00601842;
32'h74:{op,rs,rt,rd,sa,spe}=32'h1403FFFA;
32'h78:{op,rs,rt,rd,sa,spe}=32'hAC250004;
32'h7C:{op,rs,rt,rd,sa,spe}=32'h8FA50000;
32'h80:{op,rs,rt,rd,sa,spe}=32'h27BD0004;
32'h84:{op,rs,rt,rd,sa,spe}=32'h8FA40000;
32'h88:{op,rs,rt,rd,sa,spe}=32'h27BD0004;
32'h8C:{op,rs,rt,rd,sa,spe}=32'h8FA30000;
32'h90:{op,rs,rt,rd,sa,spe}=32'h27BD0004;
32'h94:{op,rs,rt,rd,sa,spe}=32'h8FA20000;
32'h98:{op,rs,rt,rd,sa,spe}=32'h27BD0004;
32'h9C:{op,rs,rt,rd,sa,spe}=32'h8FBF0000;
32'hA0:{op,rs,rt,rd,sa,spe}=32'h27BD0004;
32'hA4:{op,rs,rt,rd,sa,spe}=32'h03E00008;
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