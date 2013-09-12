/*
	hazard unit
	Mingfei Huang
	huang243@purdue.edu

*/
// mapped needs this
`include "control_hazard_alu_if.vh"

module hazard_unit(
	input logic CLK , nRST,
	control_hazard_alu_if.hu chaif);

	logic imemREN_nxt , dmemREN_nxt , dmmeWEN_nxt;
	assign imemREN_nxt = ~chaif.ihit;


	logic instEN_nxt;

	always_comb begin
		if(chaif.ihit)begin
			instEN_nxt = 1;
		end else begin
			instEN_nxt  =0;
		end
	end
	assign chaif.instEN = chaif.ihit/*&(~(chaif.cu_dmemWEN|chaif.cu_dmemREN)) | chaif.dhit*/;

	logic dfin;

	always_ff@(posedge CLK or negedge nRST) begin : proc_
		if(~nRST) begin
			chaif.imemREN	= 0;
			chaif.dmemREN	= 0;
			chaif.dmemWEN	= 0;
			//chaif.instEN		= 0;
			dfin = 0;
			chaif.ilast = 0;
		end else begin
			chaif.ilast = 0;
			chaif.imemREN = 1;
			//chaif.instEN = ilast&(~(chaif.cu_dmemWEN|chaif.cu_dmemREN)) | chaif.dhit;
			if(!chaif.halt)begin
			//	chaif.imemREN	= ~(chaif.cu_dmemREN | chaif.cu_dmemWEN);
				chaif.dmemREN	= chaif.cu_dmemREN & !dfin;
				chaif.dmemWEN	= chaif.cu_dmemWEN & !dfin;
				//chaif.instEN		= 0;
				if(chaif.ihit)begin      // instruction done
					//chaif.instEN	= 1;
					chaif.ilast = 1;
					if(chaif.cu_dmemREN)begin
						chaif.dmemREN = 1;
					end else if(chaif.cu_dmemWEN)begin
						chaif.dmemWEN = 1;
					end
					dfin = 0;
				end else if(chaif.dhit)begin
					dfin = 1;
					chaif.dmemREN = 0;
					chaif.dmemWEN = 0;
					chaif.imemREN = 1;
				end
			end else begin
				chaif.imemREN = 0;
				chaif.dmemREN = 0;
				chaif.dmemWEN = 0;
				//chaif.instEN  = 0;
			end
		end
	end
endmodule

