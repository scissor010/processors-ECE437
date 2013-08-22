module Mux(
    input logic [4:0] rsel,
    input logic [31:0] data [31:0],
    output logic [31:0] rdat
    );

    always_comb begin
        casez(rsel)
            00: rdat = data[00];
            01: rdat = data[01];
            02: rdat = data[02];
            03: rdat = data[03];
            04: rdat = data[04];
            05: rdat = data[05];
            06: rdat = data[06];
            07: rdat = data[07];
            08: rdat = data[08];
            09: rdat = data[09];
            10: rdat = data[10];
            11: rdat = data[11];
            12: rdat = data[12];
            13: rdat = data[13];
            14: rdat = data[14];
            15: rdat = data[15];
            16: rdat = data[16];
            17: rdat = data[17];
            18: rdat = data[18];
            19: rdat = data[19];
            20: rdat = data[20];
            21: rdat = data[21];
            22: rdat = data[22];
            23: rdat = data[23];
            24: rdat = data[24];
            25: rdat = data[25];
            26: rdat = data[26];
            27: rdat = data[27];
            28: rdat = data[28];
            29: rdat = data[29];
            30: rdat = data[30];
            31: rdat = data[31];
            default:rdat = 0;
        endcase
    end
endmodule
