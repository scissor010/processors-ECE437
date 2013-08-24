module Allregs (
        input logic [31:0] wdat,
        input logic [31:0] en,
        input logic nRST,
        input logic CLK,
        output logic [31:0] data [31:0]
    );
    genvar i;
    generate
        for(i = 1; i <= 31; i = i + 1)//skip $0
        begin:blahname
            Regs regs (
                /*rfif.*/wdat,
                en[i],
                /*rfif.*/CLK,
                nRST,
                data[i]
            );
        end
    endgenerate

    assign data[0] = 0; //$0=0

endmodule