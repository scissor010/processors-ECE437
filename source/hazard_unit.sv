module hazard_unit(
	input logic CLK , nRST,
	register_file_if.hu rfif);

	logic imemREN_nxt , dmemREN_nxt , dmmeWEN_nxt;
	assign imemREN_nxt = ~rfif.ihit;


	logic instEN_nxt;

	always_comb begin
		if(rfif.ihit)begin
			instEN_nxt = 1;
		end else begin
			instEN_nxt  =0;
		end
	end
	assign rfif.instEN = rfif.ihit/*&(~(rfif.cu_dmemWEN|rfif.cu_dmemREN)) | rfif.dhit*/;

	logic dfin;

	always_ff@(posedge CLK or negedge nRST) begin : proc_
		if(~nRST) begin
			rfif.imemREN	= 0;
			rfif.dmemREN	= 0;
			rfif.dmemWEN	= 0;
			//rfif.instEN		= 0;
			dfin = 0;
		end else begin
			rfif.imemREN = 1;
			//rfif.instEN = ilast&(~(rfif.cu_dmemWEN|rfif.cu_dmemREN)) | rfif.dhit;
			if(!rfif.halt)begin
			//	rfif.imemREN	= ~(rfif.cu_dmemREN | rfif.cu_dmemWEN);
				rfif.dmemREN	= rfif.cu_dmemREN & !dfin;
				rfif.dmemWEN	= rfif.cu_dmemWEN & !dfin;
				//rfif.instEN		= 0;
				if(rfif.ihit)begin      // instruction done
					//rfif.instEN	= 1;
					if(rfif.cu_dmemREN)begin
						rfif.dmemREN = 1;
					end else if(rfif.cu_dmemWEN)begin
						rfif.dmemWEN = 1;
					end
					dfin = 0;
				end else if(rfif.dhit)begin
					dfin = 1;
					rfif.dmemREN = 0;
					rfif.dmemWEN = 0;
					rfif.imemREN = 1;
				end
			end else begin
				rfif.imemREN = 0;
				rfif.dmemREN = 0;
				rfif.dmemWEN = 0;
				//rfif.instEN  = 0;
			end
		end
	end
endmodule

