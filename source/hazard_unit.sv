module hazard_unit(
	input logic CLK , nRST,
	register_file_if.hu rfif);

	//assign rfif.dmemREN = rfif.cu_dmemREN;
	//assign rfif.dmemWEN = rfif.cu_dmemWEN;
	//assign rfif.imemREN = 1;	//rfif.cu_imemREN;
//	assign rfif.instEN = 1;

	logic imemREN_nxt , dmemREN_nxt , dmmeWEN_nxt;
	assign imemREN_nxt = ~rfif.ihit;

	/*always_ff@(negedge CLK or negedge nRST) begin : proc_
	//	rfif.imemREN = 1;
		rfif.dmemREN = 0;
		rfif.dmemWEN = 0;
		if(~nRST)begin
			rfif.imemREN = 0;
			rfif.dmemREN = 0;
			rfif.dmemWEN = 0;
/*		end else if(rfif.ihit)begin
			rfif.imemREN = 0;
		end else begin
			rfif.imemREN = 1;
		end
		end else begin
			rfif.imemREN = imemREN_nxt;
		end
	end*/
	logic instEN_nxt;

	always_comb begin
		if(rfif.ihit)begin
			instEN_nxt = 1;
		end else begin
			instEN_nxt  =0;
		end
	end

	always_ff@(posedge CLK or negedge nRST) begin : proc_
		if(~nRST) begin
			/*rfif.imemREN	= 1;
			rfif.dmemREN	= 0;
			rfif.dmemWEN	= 0;
			rfif.instEN		= 1;*/
			rfif.imemREN	= 0;
			rfif.dmemREN	= 0;
			rfif.dmemWEN	= 0;
			rfif.instEN		= 0;
		end else begin/*
			if((rfif.cu_dmemREN | rfif.cu_dmemWEN) & !rfif.dhit)begin
				rfif.instEN = 0;
			end else begin
				rfif.instEN = instEN_nxt;
			end*/
			if(!rfif.halt)begin
				rfif.imemREN	= ~(rfif.cu_dmemREN | rfif.cu_dmemWEN);
				rfif.dmemREN	= rfif.cu_dmemREN;
				rfif.dmemWEN	= rfif.cu_dmemWEN;
				rfif.instEN		= 0;
				if(rfif.ihit)begin      // instruction done
				//	rfif.imemREN = 0;
					rfif.instEN	= 1;
					if(rfif.cu_dmemREN)begin
						rfif.dmemREN = 1;
					end else if(rfif.cu_dmemWEN)begin
						rfif.dmemWEN = 1;
					end
				end else if(rfif.dhit)begin
					//rfif.instEN	= 1;
					rfif.dmemREN = 0;
					//if(rfif.cu_imemREN)begin
					//		rfif.imemREN = 1;
					//	rfif.instEN = 1;
					//end
				end
			end else begin
				rfif.imemREN = 0;
				rfif.dmemREN = 0;
				rfif.dmemWEN = 0;
				rfif.instEN  = 0;
			end
		end
	end
/*		rfif.imemREN	= 1;
		rfif.dmemREN	= 0;
		rfif.dmemWEN	= 0;
		rfif.instEN		= 1;
		if(rfif.ihit)begin      // instruction done
			rfif.imemREN = 0;
			if(rfif.cu_dmemREN)begin
				rfif.dmemREN = 1;
			end else if(rfif.cu_dmemWEN)begin
				rfif.dmemWEN = 1;
			end
		end else if(rfif.dhit)begin
			rfif.dmemREN = 0;
			if(rfif.cu_imemREN)begin
				rfif.imemREN = 1;
				rfif.instEN = 1;
			end
		end
	end*/
endmodule

