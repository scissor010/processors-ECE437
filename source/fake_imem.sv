
// cpu instructions
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped needs this
`include "register_file_if.vh"


module fake_imem(register_file_if.fi rfif);


	always_comb begin
		casez(rfif.PC)
32'h00*4:rfif.imemload = 32'h10220003;
32'h01*4:rfif.imemload = 32'h14220002;
32'h02*4:rfif.imemload = 32'hFFFFFFFF;
32'h03*4:rfif.imemload = 32'h00400008;
32'h04*4:rfif.imemload = 32'h08000005;
32'h05*4:rfif.imemload = 32'h0C000007;
32'h06*4:rfif.imemload = 32'h08000005;
32'h07*4:rfif.imemload = 32'hAC240003;
32'h08*4:rfif.imemload = 32'h8C430003;
32'h09*4:rfif.imemload = 32'hAC240003;
32'h0A*4:rfif.imemload = 32'hFFFFFFFF;

/*32'h00:rfif.imemload=32'h24030017;
32'h04:rfif.imemload=32'h24010071;
32'h08:rfif.imemload=32'h00611021;
32'h0C:rfif.imemload=32'h00611024;
32'h10:rfif.imemload=32'h00611027;
32'h14:rfif.imemload=32'h00611025;
32'h18:rfif.imemload=32'h0061102A;
32'h1C:rfif.imemload=32'h0061102B;
32'h20:rfif.imemload=32'h006010C0;
32'h24:rfif.imemload=32'h006010C2;
32'h28:rfif.imemload=32'h00611023;
32'h2C:rfif.imemload=32'h00611026;
32'h30:rfif.imemload=32'h24620017;
32'h34:rfif.imemload=32'h30620017;
32'h38:rfif.imemload=32'h3C020017;
32'h3C:rfif.imemload=32'h34620017;
32'h40:rfif.imemload=32'h28620017;
32'h44:rfif.imemload=32'h2C620017;
32'h48:rfif.imemload=32'h38620017;
32'h4C:rfif.imemload=32'hFFFFFFFF;
32'h50:rfif.imemload=32'h10220005;
32'h54:rfif.imemload=32'h14220004;
32'h58:rfif.imemload=32'h0800001A;
32'h5C:rfif.imemload=32'h0C00001A;
32'h60:rfif.imemload=32'hFFFFFFFF;
32'h64:rfif.imemload=32'h00400008;
32'h68:rfif.imemload=32'hFFFFFFFF;*/
default:rfif.imemload=32'hFFFFFFFF;
		endcase
		/*casez(rfif.imemaddr)
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