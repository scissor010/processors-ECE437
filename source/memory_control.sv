/*
	Eric Villasenor
	evillase@gmail.com

	this block is the coherence protocol
	and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
	input CLK, nRST,
	cache_control_if.cc ccif
);
	// type import
	import cpu_types_pkg::*;

	// number of cpus for cc
//	parameter CPUS = 2;
	parameter CPUS = 1;
 	always_comb begin
 		ccif.iwait = 0;
 		ccif.dwait = 0;
 		casez(ccif.ramstate)
 			FREE:begin
 				ccif.iwait = 0;
 				ccif.dwait = 0;
 			end
			BUSY:begin
				ccif.iwait = 1;
				ccif.dwait = 1;
			end
			ACCESS:begin
				ccif.iwait = ccif.dREN;
			end
			ERROR:begin
	 			ccif.iwait = 1;
	 			ccif.dwait = 1;
			end
		endcase
 	end

 	word_t rdata;
	// single cycle instr saver (for memory ops)
	always_ff @(posedge CLK or negedge nRST)
	begin
		if (!nRST)
		begin
			rdata <= '0;
		end
		else if (!ccif.dwait && (!ccif.iREN || !ccif.dWEN))
		begin
			rdata <= ccif.ramload;
		end
	end
	assign ccif.dload = rdata;
 	always_comb begin
 	//	ccif.dload = ccif.ramload;
 		ccif.iload = ccif.ramload;
 		ccif.ramstore = 'bx;
 		ccif.ramaddr = ccif.iaddr;
 		ccif.ramREN = 0;
 		ccif.ramWEN = 0;
 		if(ccif.dREN)begin
 			//ccif.dload = ccif.ramload;
 			ccif.ramaddr = ccif.daddr;
 			ccif.ramREN = 1;
 		end else if(ccif.dWEN)begin
 			ccif.ramstore = ccif.dstore;
 			ccif.ramaddr = ccif.daddr;
 			ccif.ramWEN = 1;
 		end else if(ccif.iREN)begin
 			ccif.iload = ccif.ramload;
 			ccif.ramaddr = ccif.iaddr;
 			ccif.ramREN = 1;
 		end
 	end

/*

 	// MUXs
	assign ccif.ramaddr = ((ccif.iREN)&&(~ccif.dREN)&&ccif.iaddr) || ((~ccif.iREN)&&(ccif.dREN)&&ccif.daddr);
	assign ccif.iload = ccif.ramload;
	assign ccif.dload = ccif.ramload;
	assign ccif.ramWEN = ccif.dWEN;
	assign ccif.ramREN = (~ccif.dWEN)||ccif.dREN||ccif.iREN;
	assign ccif.ramstore = ccif.dWEN&&ccif.dstore;
*/
endmodule
