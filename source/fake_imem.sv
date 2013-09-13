
// cpu instructions
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped needs this
`include "control_hazard_alu_if.vh"


module fake_imem(control_hazard_alu_if.fi chaif);


	always_comb begin
		casez(chaif.PC)
32'h0*4:chaif.imemload=32'h0010220003C7;
32'h1*4:chaif.imemload=32'h0014220002C3;
32'h2*4:chaif.imemload=32'h00FFFFFFFFFE;
32'h3*4:chaif.imemload=32'h0000400008B1;
32'h4*4:chaif.imemload=32'h0008000005EB;
32'h5*4:chaif.imemload=32'h000C000007E4;
32'h6*4:chaif.imemload=32'h0008000005E9;
32'h7*4:chaif.imemload=32'h00AC24000322;
32'h8*4:chaif.imemload=32'h008C43000322;
32'h9*4:chaif.imemload=32'h00AC24000320;
32'hA*4:chaif.imemload=32'h00FFFFFFFFF6;


/*32'h00:chaif.imemload=32'h24030017;
32'h04:chaif.imemload=32'h24010071;
32'h08:chaif.imemload=32'h00611021;
32'h0C:chaif.imemload=32'h00611024;
32'h10:chaif.imemload=32'h00611027;
32'h14:chaif.imemload=32'h00611025;
32'h18:chaif.imemload=32'h0061102A;
32'h1C:chaif.imemload=32'h0061102B;
32'h20:chaif.imemload=32'h006010C0;
32'h24:chaif.imemload=32'h006010C2;
32'h28:chaif.imemload=32'h00611023;
32'h2C:chaif.imemload=32'h00611026;
32'h30:chaif.imemload=32'h24620017;
32'h34:chaif.imemload=32'h30620017;
32'h38:chaif.imemload=32'h3C020017;
32'h3C:chaif.imemload=32'h34620017;
32'h40:chaif.imemload=32'h28620017;
32'h44:chaif.imemload=32'h2C620017;
32'h48:chaif.imemload=32'h38620017;
32'h4C:chaif.imemload=32'hFFFFFFFF;
32'h50:chaif.imemload=32'h10220005;
32'h54:chaif.imemload=32'h14220004;
32'h58:chaif.imemload=32'h0800001A;
32'h5C:chaif.imemload=32'h0C00001A;
32'h60:chaif.imemload=32'hFFFFFFFF;
32'h64:chaif.imemload=32'h00400008;
32'h68:chaif.imemload=32'hFFFFFFFF;*/
default:chaif.imemload=32'hFFFFFFFF;
		endcase
		/*casez(chaif.imemaddr)
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