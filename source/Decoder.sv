module Decoder(
    input logic [4:0] wsel,
    input logic WEN,
    output logic [31:0] en
    );

    always_comb begin
        en = 0;
        if(WEN)begin
            casez(wsel)
                00: en[00] = 2'b1;
                01: en[01] = 2'b1;
                02: en[02] = 2'b1;
                03: en[03] = 2'b1;
                04: en[04] = 2'b1;
                05: en[05] = 2'b1;
                06: en[06] = 2'b1;
                07: en[07] = 2'b1;
                08: en[08] = 2'b1;
                09: en[09] = 2'b1;
                10: en[10] = 2'b1;
                11: en[11] = 2'b1;
                12: en[12] = 2'b1;
                13: en[13] = 2'b1;
                14: en[14] = 2'b1;
                15: en[15] = 2'b1;
                16: en[16] = 2'b1;
                17: en[17] = 2'b1;
                18: en[18] = 2'b1;
                19: en[19] = 2'b1;
                20: en[20] = 2'b1;
                21: en[21] = 2'b1;
                22: en[22] = 2'b1;
                23: en[23] = 2'b1;
                24: en[24] = 2'b1;
                25: en[25] = 2'b1;
                26: en[26] = 2'b1;
                27: en[27] = 2'b1;
                28: en[28] = 2'b1;
                29: en[29] = 2'b1;
                30: en[30] = 2'b1;
                31: en[31] = 2'b1;
                default:en = 0;
            endcase
        end
        else begin
            en = 0;
        end
    end
endmodule
