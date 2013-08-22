module tb_register_file;

	logic [4:0] tb_wsel = 0;
	logic [31:0] tb_wdat = 0;
	logic tb_WEN = 0;
	logic tb_clk = 0;
	logic [4:0] tb_rsel1 = 0;
	logic [4:0] tb_rsel2 = 0;
	logic [31:0] tb_rdat1 = 0;
	logic [31:0] tb_rdat2 = 0;

	register_file tb_register_file(
		tb_wsel,
		tb_wdat,
		tb_WEN,
		tb_clk,
		tb_rsel1,
		tb_rsel2,
		tb_rdat1,
		tb_rdat2
	);

	always begin
		#10ns
		tb_clk = 0;
		#10ns
		tb_clk = 1;
	end
endmodule