module bijiao(
    input wire [7:0]in,
    input wire en,
    output reg [3:0]out1,
    output reg [3:0]out2,
    output reg [3:0]out3,
    output reg [3:0]out4
);

    always @ (in) begin
        if (en) begin
            if (in == 9'd0) begin
                out1 = 4'd0;
                out2 = 4'd0;
                out3 = 4'd0;
                out4 = 4'd0;
            end
            if (in == 9'd1) begin
                out1 = 4'd9;
                out2 = 4'd1;
                out3 = 4'd0;
                out4 = 4'd0;
            end
            if (in == 9'd2) begin
                out1 = 4'd9;
                out2 = 4'd3;
                out3 = 4'd0;
                out4 = 4'd0;
            end
            if (in == 9'd3) begin
                out1 = 4'd8;
                out2 = 4'd5;
                out3 = 4'd0;
                out4 = 4'd0;
            end
            if (in == 9'd4) begin
                out1 = 4'd8;
                out2 = 4'd7;
                out3 = 4'd0;
                out4 = 4'd0;
            end
            if (in == 9'd5) begin
                out1 = 4'd7;
                out2 = 4'd9;
                out3 = 4'd0;
                out4 = 4'd0;
            end
            if (in == 9'd6) begin
                out1 = 4'd7;
                out2 = 4'd1;
                out3 = 4'd1;
                out4 = 4'd0;
            end
            if (in == 9'd7) begin
                out1 = 4'd6;
                out2 = 4'd3;
                out3 = 4'd1;
                out4 = 4'd0;
            end
            if (in == 9'd8) begin
                out1 = 4'd6;
                out2 = 4'd5;
                out3 = 4'd1;
                out4 = 4'd0;
            end
            if (in == 9'd9) begin
                out1 = 4'd5;
                out2 = 4'd7;
                out3 = 4'd1;
                out4 = 4'd0;
            end
            if (in == 9'd10) begin
                out1 = 4'd5;
                out2 = 4'd9;
                out3 = 4'd1;
                out4 = 4'd0;
            end
            if (in == 9'd11) begin
                out1 = 4'd4;
                out2 = 4'd1;
                out3 = 4'd2;
                out4 = 4'd0;
            end
            if (in == 9'd12) begin
                out1 = 4'd4;
                out2 = 4'd3;
                out3 = 4'd2;
                out4 = 4'd0;
            end
            if (in == 9'd13) begin
                out1 = 4'd3;
                out2 = 4'd5;
                out3 = 4'd2;
                out4 = 4'd0;
            end
            if (in == 9'd14) begin
                out1 = 4'd3;
                out2 = 4'd7;
                out3 = 4'd2;
                out4 = 4'd0;
            end
            if (in == 9'd15) begin
                out1 = 4'd2;
                out2 = 4'd9;
                out3 = 4'd2;
                out4 = 4'd0;
            end
            if (in == 9'd16) begin
                out1 = 4'd2;
                out2 = 4'd1;
                out3 = 4'd3;
                out4 = 4'd0;
            end
            if (in == 9'd17) begin
                out1 = 4'd2;
                out2 = 4'd3;
                out3 = 4'd3;
                out4 = 4'd0;
            end
            if (in == 9'd18) begin
                out1 = 4'd1;
                out2 = 4'd5;
                out3 = 4'd3;
                out4 = 4'd0;
            end
            if (in == 9'd19) begin
                out1 = 4'd1;
                out2 = 4'd7;
                out3 = 4'd3;
                out4 = 4'd0;
            end
            if (in == 9'd20) begin
                out1 = 4'd0;
                out2 = 4'd9;
                out3 = 4'd3;
                out4 = 4'd0;
            end
            if (in == 9'd21) begin
                out1 = 4'd0;
                out2 = 4'd1;
                out3 = 4'd4;
                out4 = 4'd0;
            end
            if (in == 9'd22) begin
                out1 = 4'd9;
                out2 = 4'd2;
                out3 = 4'd4;
                out4 = 4'd0;
            end
            if (in == 9'd23) begin
                out1 = 4'd9;
                out2 = 4'd4;
                out3 = 4'd4;
                out4 = 4'd0;
            end
            if (in == 9'd24) begin
                out1 = 4'd8;
                out2 = 4'd6;
                out3 = 4'd4;
                out4 = 4'd0;
            end
            if (in == 9'd25) begin
                out1 = 4'd8;
                out2 = 4'd8;
                out3 = 4'd4;
                out4 = 4'd0;
            end
            if (in == 9'd26) begin
                out1 = 4'd7;
                out2 = 4'd0;
                out3 = 4'd5;
                out4 = 4'd0;
            end
            if (in == 9'd27) begin
                out1 = 4'd7;
                out2 = 4'd2;
                out3 = 4'd5;
                out4 = 4'd0;
            end
            if (in == 9'd28) begin
                out1 = 4'd6;
                out2 = 4'd4;
                out3 = 4'd5;
                out4 = 4'd0;
            end
            if (in == 9'd29) begin
                out1 = 4'd6;
                out2 = 4'd6;
                out3 = 4'd5;
                out4 = 4'd0;
            end
            if (in == 9'd30) begin
                out1 = 4'd5;
                out2 = 4'd8;
                out3 = 4'd5;
                out4 = 4'd0;
            end
            if (in == 9'd31) begin
                out1 = 4'd5;
                out2 = 4'd0;
                out3 = 4'd6;
                out4 = 4'd0;
            end
            if (in == 9'd32) begin
                out1 = 4'd5;
                out2 = 4'd2;
                out3 = 4'd6;
                out4 = 4'd0;
            end
            if (in == 9'd33) begin
                out1 = 4'd4;
                out2 = 4'd4;
                out3 = 4'd6;
                out4 = 4'd0;
            end
            if (in == 9'd34) begin
                out1 = 4'd4;
                out2 = 4'd6;
                out3 = 4'd6;
                out4 = 4'd0;
            end
            if (in == 9'd35) begin
                out1 = 4'd3;
                out2 = 4'd8;
                out3 = 4'd6;
                out4 = 4'd0;
            end
            if (in == 9'd36) begin
                out1 = 4'd3;
                out2 = 4'd0;
                out3 = 4'd7;
                out4 = 4'd0;
            end
            if (in == 9'd37) begin
                out1 = 4'd2;
                out2 = 4'd2;
                out3 = 4'd7;
                out4 = 4'd0;
            end
            if (in == 9'd38) begin
                out1 = 4'd2;
                out2 = 4'd4;
                out3 = 4'd7;
                out4 = 4'd0;
            end
            if (in == 9'd39) begin
                out1 = 4'd1;
                out2 = 4'd6;
                out3 = 4'd7;
                out4 = 4'd0;
            end
            if (in == 9'd40) begin
                out1 = 4'd1;
                out2 = 4'd8;
                out3 = 4'd7;
                out4 = 4'd0;
            end
            if (in == 9'd41) begin
                out1 = 4'd0;
                out2 = 4'd0;
                out3 = 4'd8;
                out4 = 4'd0;
            end
            if (in == 9'd42) begin
                out1 = 4'd0;
                out2 = 4'd2;
                out3 = 4'd8;
                out4 = 4'd0;
            end
            if (in == 9'd43) begin
                out1 = 4'd9;
                out2 = 4'd3;
                out3 = 4'd8;
                out4 = 4'd0;
            end
            if (in == 9'd44) begin
                out1 = 4'd9;
                out2 = 4'd5;
                out3 = 4'd8;
                out4 = 4'd0;
            end
            if (in == 9'd45) begin
                out1 = 4'd8;
                out2 = 4'd7;
                out3 = 4'd8;
                out4 = 4'd0;
            end
            if (in == 9'd46) begin
                out1 = 4'd8;
                out2 = 4'd9;
                out3 = 4'd8;
                out4 = 4'd0;
            end
            if (in == 9'd47) begin
                out1 = 4'd7;
                out2 = 4'd1;
                out3 = 4'd9;
                out4 = 4'd0;
            end
            if (in == 9'd48) begin
                out1 = 4'd7;
                out2 = 4'd3;
                out3 = 4'd9;
                out4 = 4'd0;
            end
            if (in == 9'd49) begin
                out1 = 4'd7;
                out2 = 4'd5;
                out3 = 4'd9;
                out4 = 4'd0;
            end
            if (in == 9'd50) begin
                out1 = 4'd6;
                out2 = 4'd7;
                out3 = 4'd9;
                out4 = 4'd0;
            end
            if (in == 9'd51) begin
                out1 = 4'd6;
                out2 = 4'd9;
                out3 = 4'd9;
                out4 = 4'd0;
            end
            if (in == 9'd52) begin
                out1 = 4'd5;
                out2 = 4'd1;
                out3 = 4'd0;
                out4 = 4'd1;
            end
            if (in == 9'd53) begin
                out1 = 4'd5;
                out2 = 4'd3;
                out3 = 4'd0;
                out4 = 4'd1;
            end
            if (in == 9'd54) begin
                out1 = 4'd4;
                out2 = 4'd5;
                out3 = 4'd0;
                out4 = 4'd1;
            end
            if (in == 9'd55) begin
                out1 = 4'd4;
                out2 = 4'd7;
                out3 = 4'd0;
                out4 = 4'd1;
            end
            if (in == 9'd56) begin
                out1 = 4'd3;
                out2 = 4'd9;
                out3 = 4'd0;
                out4 = 4'd1;
            end
            if (in == 9'd57) begin
                out1 = 4'd3;
                out2 = 4'd1;
                out3 = 4'd1;
                out4 = 4'd1;
            end
            if (in == 9'd58) begin
                out1 = 4'd2;
                out2 = 4'd3;
                out3 = 4'd1;
                out4 = 4'd1;
            end
            if (in == 9'd59) begin
                out1 = 4'd2;
                out2 = 4'd5;
                out3 = 4'd1;
                out4 = 4'd1;
            end
            if (in == 9'd60) begin
                out1 = 4'd1;
                out2 = 4'd7;
                out3 = 4'd1;
                out4 = 4'd1;
            end
            if (in == 9'd61) begin
                out1 = 4'd1;
                out2 = 4'd9;
                out3 = 4'd1;
                out4 = 4'd1;
            end
            if (in == 9'd62) begin
                out1 = 4'd0;
                out2 = 4'd1;
                out3 = 4'd2;
                out4 = 4'd1;
            end
            if (in == 9'd63) begin
                out1 = 4'd0;
                out2 = 4'd3;
                out3 = 4'd2;
                out4 = 4'd1;
            end
            if (in == 9'd64) begin
                out1 = 4'd0;
                out2 = 4'd5;
                out3 = 4'd2;
                out4 = 4'd1;
            end
            if (in == 9'd65) begin
                out1 = 4'd9;
                out2 = 4'd6;
                out3 = 4'd2;
                out4 = 4'd1;
            end
            if (in == 9'd66) begin
                out1 = 4'd9;
                out2 = 4'd8;
                out3 = 4'd2;
                out4 = 4'd1;
            end
            if (in == 9'd67) begin
                out1 = 4'd8;
                out2 = 4'd0;
                out3 = 4'd3;
                out4 = 4'd1;
            end
            if (in == 9'd68) begin
                out1 = 4'd8;
                out2 = 4'd2;
                out3 = 4'd3;
                out4 = 4'd1;
            end
            if (in == 9'd69) begin
                out1 = 4'd7;
                out2 = 4'd4;
                out3 = 4'd3;
                out4 = 4'd1;
            end
            if (in == 9'd70) begin
                out1 = 4'd7;
                out2 = 4'd6;
                out3 = 4'd3;
                out4 = 4'd1;
            end
            if (in == 9'd71) begin
                out1 = 4'd6;
                out2 = 4'd8;
                out3 = 4'd3;
                out4 = 4'd1;
            end
            if (in == 9'd72) begin
                out1 = 4'd6;
                out2 = 4'd0;
                out3 = 4'd4;
                out4 = 4'd1;
            end
            if (in == 9'd73) begin
                out1 = 4'd5;
                out2 = 4'd2;
                out3 = 4'd4;
                out4 = 4'd1;
            end
            if (in == 9'd74) begin
                out1 = 4'd5;
                out2 = 4'd4;
                out3 = 4'd4;
                out4 = 4'd1;
            end
            if (in == 9'd75) begin
                out1 = 4'd4;
                out2 = 4'd6;
                out3 = 4'd4;
                out4 = 4'd1;
            end
            if (in == 9'd76) begin
                out1 = 4'd4;
                out2 = 4'd8;
                out3 = 4'd4;
                out4 = 4'd1;
            end
            if (in == 9'd77) begin
                out1 = 4'd3;
                out2 = 4'd0;
                out3 = 4'd5;
                out4 = 4'd1;
            end
            if (in == 9'd78) begin
                out1 = 4'd3;
                out2 = 4'd2;
                out3 = 4'd5;
                out4 = 4'd1;
            end
            if (in == 9'd79) begin
                out1 = 4'd2;
                out2 = 4'd4;
                out3 = 4'd5;
                out4 = 4'd1;
            end
            if (in == 9'd80) begin
                out1 = 4'd2;
                out2 = 4'd6;
                out3 = 4'd5;
                out4 = 4'd1;
            end
            if (in == 9'd81) begin
                out1 = 4'd2;
                out2 = 4'd8;
                out3 = 4'd5;
                out4 = 4'd1;
            end
            if (in == 9'd82) begin
                out1 = 4'd1;
                out2 = 4'd0;
                out3 = 4'd6;
                out4 = 4'd1;
            end
            if (in == 9'd83) begin
                out1 = 4'd1;
                out2 = 4'd2;
                out3 = 4'd6;
                out4 = 4'd1;
            end
            if (in == 9'd84) begin
                out1 = 4'd0;
                out2 = 4'd4;
                out3 = 4'd6;
                out4 = 4'd1;
            end
            if (in == 9'd85) begin
                out1 = 4'd0;
                out2 = 4'd6;
                out3 = 4'd6;
                out4 = 4'd1;
            end
            if (in == 9'd86) begin
                out1 = 4'd9;
                out2 = 4'd7;
                out3 = 4'd6;
                out4 = 4'd1;
            end
            if (in == 9'd87) begin
                out1 = 4'd9;
                out2 = 4'd9;
                out3 = 4'd6;
                out4 = 4'd1;
            end
            if (in == 9'd88) begin
                out1 = 4'd8;
                out2 = 4'd1;
                out3 = 4'd7;
                out4 = 4'd1;
            end
            if (in == 9'd89) begin
                out1 = 4'd8;
                out2 = 4'd3;
                out3 = 4'd7;
                out4 = 4'd1;
            end
            if (in == 9'd90) begin
                out1 = 4'd7;
                out2 = 4'd5;
                out3 = 4'd7;
                out4 = 4'd1;
            end
            if (in == 9'd91) begin
                out1 = 4'd7;
                out2 = 4'd7;
                out3 = 4'd7;
                out4 = 4'd1;
            end
            if (in == 9'd92) begin
                out1 = 4'd6;
                out2 = 4'd9;
                out3 = 4'd7;
                out4 = 4'd1;
            end
            if (in == 9'd93) begin
                out1 = 4'd6;
                out2 = 4'd1;
                out3 = 4'd8;
                out4 = 4'd1;
            end
            if (in == 9'd94) begin
                out1 = 4'd5;
                out2 = 4'd3;
                out3 = 4'd8;
                out4 = 4'd1;
            end
            if (in == 9'd95) begin
                out1 = 4'd5;
                out2 = 4'd5;
                out3 = 4'd8;
                out4 = 4'd1;
            end
            if (in == 9'd96) begin
                out1 = 4'd5;
                out2 = 4'd7;
                out3 = 4'd8;
                out4 = 4'd1;
            end
            if (in == 9'd97) begin
                out1 = 4'd4;
                out2 = 4'd9;
                out3 = 4'd8;
                out4 = 4'd1;
            end
            if (in == 9'd98) begin
                out1 = 4'd4;
                out2 = 4'd1;
                out3 = 4'd9;
                out4 = 4'd1;
            end
            if (in == 9'd99) begin
                out1 = 4'd3;
                out2 = 4'd3;
                out3 = 4'd9;
                out4 = 4'd1;
            end
            if (in == 9'd100) begin
                out1 = 4'd3;
                out2 = 4'd5;
                out3 = 4'd9;
                out4 = 4'd1;
            end
            if (in == 9'd101) begin
                out1 = 4'd2;
                out2 = 4'd7;
                out3 = 4'd9;
                out4 = 4'd1;
            end
            if (in == 9'd102) begin
                out1 = 4'd2;
                out2 = 4'd9;
                out3 = 4'd9;
                out4 = 4'd1;
            end
            if (in == 9'd103) begin
                out1 = 4'd1;
                out2 = 4'd1;
                out3 = 4'd0;
                out4 = 4'd2;
            end
            if (in == 9'd104) begin
                out1 = 4'd1;
                out2 = 4'd3;
                out3 = 4'd0;
                out4 = 4'd2;
            end
            if (in == 9'd105) begin
                out1 = 4'd0;
                out2 = 4'd5;
                out3 = 4'd0;
                out4 = 4'd2;
            end
            if (in == 9'd106) begin
                out1 = 4'd0;
                out2 = 4'd7;
                out3 = 4'd0;
                out4 = 4'd2;
            end
            if (in == 9'd107) begin
                out1 = 4'd9;
                out2 = 4'd8;
                out3 = 4'd0;
                out4 = 4'd2;
            end
            if (in == 9'd108) begin
                out1 = 4'd9;
                out2 = 4'd0;
                out3 = 4'd1;
                out4 = 4'd2;
            end
            if (in == 9'd109) begin
                out1 = 4'd8;
                out2 = 4'd2;
                out3 = 4'd1;
                out4 = 4'd2;
            end
            if (in == 9'd110) begin
                out1 = 4'd8;
                out2 = 4'd4;
                out3 = 4'd1;
                out4 = 4'd2;
            end
            if (in == 9'd111) begin
                out1 = 4'd7;
                out2 = 4'd6;
                out3 = 4'd1;
                out4 = 4'd2;
            end
            if (in == 9'd112) begin
                out1 = 4'd7;
                out2 = 4'd8;
                out3 = 4'd1;
                out4 = 4'd2;
            end
            if (in == 9'd113) begin
                out1 = 4'd7;
                out2 = 4'd0;
                out3 = 4'd2;
                out4 = 4'd2;
            end
            if (in == 9'd114) begin
                out1 = 4'd6;
                out2 = 4'd2;
                out3 = 4'd2;
                out4 = 4'd2;
            end
            if (in == 9'd115) begin
                out1 = 4'd6;
                out2 = 4'd4;
                out3 = 4'd2;
                out4 = 4'd2;
            end
            if (in == 9'd116) begin
                out1 = 4'd5;
                out2 = 4'd6;
                out3 = 4'd2;
                out4 = 4'd2;
            end
            if (in == 9'd117) begin
                out1 = 4'd5;
                out2 = 4'd8;
                out3 = 4'd2;
                out4 = 4'd2;
            end
            if (in == 9'd118) begin
                out1 = 4'd4;
                out2 = 4'd0;
                out3 = 4'd3;
                out4 = 4'd2;
            end
            if (in == 9'd119) begin
                out1 = 4'd4;
                out2 = 4'd2;
                out3 = 4'd3;
                out4 = 4'd2;
            end
            if (in == 9'd120) begin
                out1 = 4'd3;
                out2 = 4'd4;
                out3 = 4'd3;
                out4 = 4'd2;
            end
            if (in == 9'd121) begin
                out1 = 4'd3;
                out2 = 4'd6;
                out3 = 4'd3;
                out4 = 4'd2;
            end
            if (in == 9'd122) begin
                out1 = 4'd2;
                out2 = 4'd8;
                out3 = 4'd3;
                out4 = 4'd2;
            end
            if (in == 9'd123) begin
                out1 = 4'd2;
                out2 = 4'd0;
                out3 = 4'd4;
                out4 = 4'd2;
            end
            if (in == 9'd124) begin
                out1 = 4'd1;
                out2 = 4'd2;
                out3 = 4'd4;
                out4 = 4'd2;
            end
            if (in == 9'd125) begin
                out1 = 4'd1;
                out2 = 4'd4;
                out3 = 4'd4;
                out4 = 4'd2;
            end
            if (in == 9'd126) begin
                out1 = 4'd0;
                out2 = 4'd6;
                out3 = 4'd4;
                out4 = 4'd2;
            end
            if (in == 9'd127) begin
                out1 = 4'd0;
                out2 = 4'd8;
                out3 = 4'd4;
                out4 = 4'd2;
            end
            if (in == 9'd128) begin
                out1 = 4'd0;
                out2 = 4'd0;
                out3 = 4'd5;
                out4 = 4'd2;
            end
            if (in == 9'd129) begin
                out1 = 4'd9;
                out2 = 4'd1;
                out3 = 4'd5;
                out4 = 4'd2;
            end
            if (in == 9'd130) begin
                out1 = 4'd9;
                out2 = 4'd3;
                out3 = 4'd5;
                out4 = 4'd2;
            end
            if (in == 9'd131) begin
                out1 = 4'd8;
                out2 = 4'd5;
                out3 = 4'd5;
                out4 = 4'd2;
            end
            if (in == 9'd132) begin
                out1 = 4'd8;
                out2 = 4'd7;
                out3 = 4'd5;
                out4 = 4'd2;
            end
            if (in == 9'd133) begin
                out1 = 4'd7;
                out2 = 4'd9;
                out3 = 4'd5;
                out4 = 4'd2;
            end
            if (in == 9'd134) begin
                out1 = 4'd7;
                out2 = 4'd1;
                out3 = 4'd6;
                out4 = 4'd2;
            end
            if (in == 9'd135) begin
                out1 = 4'd6;
                out2 = 4'd3;
                out3 = 4'd6;
                out4 = 4'd2;
            end
            if (in == 9'd136) begin
                out1 = 4'd6;
                out2 = 4'd5;
                out3 = 4'd6;
                out4 = 4'd2;
            end
            if (in == 9'd137) begin
                out1 = 4'd5;
                out2 = 4'd7;
                out3 = 4'd6;
                out4 = 4'd2;
            end
            if (in == 9'd138) begin
                out1 = 4'd5;
                out2 = 4'd9;
                out3 = 4'd6;
                out4 = 4'd2;
            end
            if (in == 9'd139) begin
                out1 = 4'd4;
                out2 = 4'd1;
                out3 = 4'd7;
                out4 = 4'd2;
            end
            if (in == 9'd140) begin
                out1 = 4'd4;
                out2 = 4'd3;
                out3 = 4'd7;
                out4 = 4'd2;
            end
            if (in == 9'd141) begin
                out1 = 4'd3;
                out2 = 4'd5;
                out3 = 4'd7;
                out4 = 4'd2;
            end
            if (in == 9'd142) begin
                out1 = 4'd3;
                out2 = 4'd7;
                out3 = 4'd7;
                out4 = 4'd2;
            end
            if (in == 9'd143) begin
                out1 = 4'd2;
                out2 = 4'd9;
                out3 = 4'd7;
                out4 = 4'd2;
            end
            if (in == 9'd144) begin
                out1 = 4'd2;
                out2 = 4'd1;
                out3 = 4'd8;
                out4 = 4'd2;
            end
            if (in == 9'd145) begin
                out1 = 4'd2;
                out2 = 4'd3;
                out3 = 4'd8;
                out4 = 4'd2;
            end
            if (in == 9'd146) begin
                out1 = 4'd1;
                out2 = 4'd5;
                out3 = 4'd8;
                out4 = 4'd2;
            end
            if (in == 9'd147) begin
                out1 = 4'd1;
                out2 = 4'd7;
                out3 = 4'd8;
                out4 = 4'd2;
            end
            if (in == 9'd148) begin
                out1 = 4'd0;
                out2 = 4'd9;
                out3 = 4'd8;
                out4 = 4'd2;
            end
            if (in == 9'd149) begin
                out1 = 4'd0;
                out2 = 4'd1;
                out3 = 4'd9;
                out4 = 4'd2;
            end
            if (in == 9'd150) begin
                out1 = 4'd9;
                out2 = 4'd2;
                out3 = 4'd9;
                out4 = 4'd2;
            end
            if (in == 9'd151) begin
                out1 = 4'd9;
                out2 = 4'd4;
                out3 = 4'd9;
                out4 = 4'd2;
            end
            if (in == 9'd152) begin
                out1 = 4'd8;
                out2 = 4'd6;
                out3 = 4'd9;
                out4 = 4'd2;
            end
            if (in == 9'd153) begin
                out1 = 4'd8;
                out2 = 4'd8;
                out3 = 4'd9;
                out4 = 4'd2;
            end
            if (in == 9'd154) begin
                out1 = 4'd7;
                out2 = 4'd0;
                out3 = 4'd0;
                out4 = 4'd3;
            end
            if (in == 9'd155) begin
                out1 = 4'd7;
                out2 = 4'd2;
                out3 = 4'd0;
                out4 = 4'd3;
            end
            if (in == 9'd156) begin
                out1 = 4'd6;
                out2 = 4'd4;
                out3 = 4'd0;
                out4 = 4'd3;
            end
            if (in == 9'd157) begin
                out1 = 4'd6;
                out2 = 4'd6;
                out3 = 4'd0;
                out4 = 4'd3;
            end
            if (in == 9'd158) begin
                out1 = 4'd5;
                out2 = 4'd8;
                out3 = 4'd0;
                out4 = 4'd3;
            end
            if (in == 9'd159) begin
                out1 = 4'd5;
                out2 = 4'd0;
                out3 = 4'd1;
                out4 = 4'd3;
            end
            if (in == 9'd160) begin
                out1 = 4'd5;
                out2 = 4'd2;
                out3 = 4'd1;
                out4 = 4'd3;
            end
            if (in == 9'd161) begin
                out1 = 4'd4;
                out2 = 4'd4;
                out3 = 4'd1;
                out4 = 4'd3;
            end
            if (in == 9'd162) begin
                out1 = 4'd4;
                out2 = 4'd6;
                out3 = 4'd1;
                out4 = 4'd3;
            end
            if (in == 9'd163) begin
                out1 = 4'd3;
                out2 = 4'd8;
                out3 = 4'd1;
                out4 = 4'd3;
            end
            if (in == 9'd164) begin
                out1 = 4'd3;
                out2 = 4'd0;
                out3 = 4'd2;
                out4 = 4'd3;
            end
            if (in == 9'd165) begin
                out1 = 4'd2;
                out2 = 4'd2;
                out3 = 4'd2;
                out4 = 4'd3;
            end
            if (in == 9'd166) begin
                out1 = 4'd2;
                out2 = 4'd4;
                out3 = 4'd2;
                out4 = 4'd3;
            end
            if (in == 9'd167) begin
                out1 = 4'd1;
                out2 = 4'd6;
                out3 = 4'd2;
                out4 = 4'd3;
            end
            if (in == 9'd168) begin
                out1 = 4'd1;
                out2 = 4'd8;
                out3 = 4'd2;
                out4 = 4'd3;
            end
            if (in == 9'd169) begin
                out1 = 4'd0;
                out2 = 4'd0;
                out3 = 4'd3;
                out4 = 4'd3;
            end
            if (in == 9'd170) begin
                out1 = 4'd0;
                out2 = 4'd2;
                out3 = 4'd3;
                out4 = 4'd3;
            end
            if (in == 9'd171) begin
                out1 = 4'd9;
                out2 = 4'd3;
                out3 = 4'd3;
                out4 = 4'd3;
            end
            if (in == 9'd172) begin
                out1 = 4'd9;
                out2 = 4'd5;
                out3 = 4'd3;
                out4 = 4'd3;
            end
            if (in == 9'd173) begin
                out1 = 4'd8;
                out2 = 4'd7;
                out3 = 4'd3;
                out4 = 4'd3;
            end
            if (in == 9'd174) begin
                out1 = 4'd8;
                out2 = 4'd9;
                out3 = 4'd3;
                out4 = 4'd3;
            end
            if (in == 9'd175) begin
                out1 = 4'd7;
                out2 = 4'd1;
                out3 = 4'd4;
                out4 = 4'd3;
            end
            if (in == 9'd176) begin
                out1 = 4'd7;
                out2 = 4'd3;
                out3 = 4'd4;
                out4 = 4'd3;
            end
            if (in == 9'd177) begin
                out1 = 4'd7;
                out2 = 4'd5;
                out3 = 4'd4;
                out4 = 4'd3;
            end
            if (in == 9'd178) begin
                out1 = 4'd6;
                out2 = 4'd7;
                out3 = 4'd4;
                out4 = 4'd3;
            end
            if (in == 9'd179) begin
                out1 = 4'd6;
                out2 = 4'd9;
                out3 = 4'd4;
                out4 = 4'd3;
            end
            if (in == 9'd180) begin
                out1 = 4'd5;
                out2 = 4'd1;
                out3 = 4'd5;
                out4 = 4'd3;
            end
            if (in == 9'd181) begin
                out1 = 4'd5;
                out2 = 4'd3;
                out3 = 4'd5;
                out4 = 4'd3;
            end
            if (in == 9'd182) begin
                out1 = 4'd4;
                out2 = 4'd5;
                out3 = 4'd5;
                out4 = 4'd3;
            end
            if (in == 9'd183) begin
                out1 = 4'd4;
                out2 = 4'd7;
                out3 = 4'd5;
                out4 = 4'd3;
            end
            if (in == 9'd184) begin
                out1 = 4'd3;
                out2 = 4'd9;
                out3 = 4'd5;
                out4 = 4'd3;
            end
            if (in == 9'd185) begin
                out1 = 4'd3;
                out2 = 4'd1;
                out3 = 4'd6;
                out4 = 4'd3;
            end
            if (in == 9'd186) begin
                out1 = 4'd2;
                out2 = 4'd3;
                out3 = 4'd6;
                out4 = 4'd3;
            end
            if (in == 9'd187) begin
                out1 = 4'd2;
                out2 = 4'd5;
                out3 = 4'd6;
                out4 = 4'd3;
            end
            if (in == 9'd188) begin
                out1 = 4'd1;
                out2 = 4'd7;
                out3 = 4'd6;
                out4 = 4'd3;
            end
            if (in == 9'd189) begin
                out1 = 4'd1;
                out2 = 4'd9;
                out3 = 4'd6;
                out4 = 4'd3;
            end
            if (in == 9'd190) begin
                out1 = 4'd0;
                out2 = 4'd1;
                out3 = 4'd7;
                out4 = 4'd3;
            end
            if (in == 9'd191) begin
                out1 = 4'd0;
                out2 = 4'd3;
                out3 = 4'd7;
                out4 = 4'd3;
            end
            if (in == 9'd192) begin
                out1 = 4'd0;
                out2 = 4'd5;
                out3 = 4'd7;
                out4 = 4'd3;
            end
            if (in == 9'd193) begin
                out1 = 4'd9;
                out2 = 4'd6;
                out3 = 4'd7;
                out4 = 4'd3;
            end
            if (in == 9'd194) begin
                out1 = 4'd9;
                out2 = 4'd8;
                out3 = 4'd7;
                out4 = 4'd3;
            end
            if (in == 9'd195) begin
                out1 = 4'd8;
                out2 = 4'd0;
                out3 = 4'd8;
                out4 = 4'd3;
            end
            if (in == 9'd196) begin
                out1 = 4'd8;
                out2 = 4'd2;
                out3 = 4'd8;
                out4 = 4'd3;
            end
            if (in == 9'd197) begin
                out1 = 4'd7;
                out2 = 4'd4;
                out3 = 4'd8;
                out4 = 4'd3;
            end
            if (in == 9'd198) begin
                out1 = 4'd7;
                out2 = 4'd6;
                out3 = 4'd8;
                out4 = 4'd3;
            end
            if (in == 9'd199) begin
                out1 = 4'd6;
                out2 = 4'd8;
                out3 = 4'd8;
                out4 = 4'd3;
            end
            if (in == 9'd200) begin
                out1 = 4'd6;
                out2 = 4'd0;
                out3 = 4'd9;
                out4 = 4'd3;
            end
            if (in == 9'd201) begin
                out1 = 4'd5;
                out2 = 4'd2;
                out3 = 4'd9;
                out4 = 4'd3;
            end
            if (in == 9'd202) begin
                out1 = 4'd5;
                out2 = 4'd4;
                out3 = 4'd9;
                out4 = 4'd3;
            end
            if (in == 9'd203) begin
                out1 = 4'd4;
                out2 = 4'd6;
                out3 = 4'd9;
                out4 = 4'd3;
            end
            if (in == 9'd204) begin
                out1 = 4'd4;
                out2 = 4'd8;
                out3 = 4'd9;
                out4 = 4'd3;
            end
            if (in == 9'd205) begin
                out1 = 4'd3;
                out2 = 4'd0;
                out3 = 4'd0;
                out4 = 4'd4;
            end
            if (in == 9'd206) begin
                out1 = 4'd3;
                out2 = 4'd2;
                out3 = 4'd0;
                out4 = 4'd4;
            end
            if (in == 9'd207) begin
                out1 = 4'd2;
                out2 = 4'd4;
                out3 = 4'd0;
                out4 = 4'd4;
            end
            if (in == 9'd208) begin
                out1 = 4'd2;
                out2 = 4'd6;
                out3 = 4'd0;
                out4 = 4'd4;
            end
            if (in == 9'd209) begin
                out1 = 4'd2;
                out2 = 4'd8;
                out3 = 4'd0;
                out4 = 4'd4;
            end
            if (in == 9'd210) begin
                out1 = 4'd1;
                out2 = 4'd0;
                out3 = 4'd1;
                out4 = 4'd4;
            end
            if (in == 9'd211) begin
                out1 = 4'd1;
                out2 = 4'd2;
                out3 = 4'd1;
                out4 = 4'd4;
            end
            if (in == 9'd212) begin
                out1 = 4'd0;
                out2 = 4'd4;
                out3 = 4'd1;
                out4 = 4'd4;
            end
            if (in == 9'd213) begin
                out1 = 4'd0;
                out2 = 4'd6;
                out3 = 4'd1;
                out4 = 4'd4;
            end
            if (in == 9'd214) begin
                out1 = 4'd9;
                out2 = 4'd7;
                out3 = 4'd1;
                out4 = 4'd4;
            end
            if (in == 9'd215) begin
                out1 = 4'd9;
                out2 = 4'd9;
                out3 = 4'd1;
                out4 = 4'd4;
            end
            if (in == 9'd216) begin
                out1 = 4'd8;
                out2 = 4'd1;
                out3 = 4'd2;
                out4 = 4'd4;
            end
            if (in == 9'd217) begin
                out1 = 4'd8;
                out2 = 4'd3;
                out3 = 4'd2;
                out4 = 4'd4;
            end
            if (in == 9'd218) begin
                out1 = 4'd7;
                out2 = 4'd5;
                out3 = 4'd2;
                out4 = 4'd4;
            end
            if (in == 9'd219) begin
                out1 = 4'd7;
                out2 = 4'd7;
                out3 = 4'd2;
                out4 = 4'd4;
            end
            if (in == 9'd220) begin
                out1 = 4'd6;
                out2 = 4'd9;
                out3 = 4'd2;
                out4 = 4'd4;
            end
            if (in == 9'd221) begin
                out1 = 4'd6;
                out2 = 4'd1;
                out3 = 4'd3;
                out4 = 4'd4;
            end
            if (in == 9'd222) begin
                out1 = 4'd5;
                out2 = 4'd3;
                out3 = 4'd3;
                out4 = 4'd4;
            end
            if (in == 9'd223) begin
                out1 = 4'd5;
                out2 = 4'd5;
                out3 = 4'd3;
                out4 = 4'd4;
            end
            if (in == 9'd224) begin
                out1 = 4'd5;
                out2 = 4'd7;
                out3 = 4'd3;
                out4 = 4'd4;
            end
            if (in == 9'd225) begin
                out1 = 4'd4;
                out2 = 4'd9;
                out3 = 4'd3;
                out4 = 4'd4;
            end
            if (in == 9'd226) begin
                out1 = 4'd4;
                out2 = 4'd1;
                out3 = 4'd4;
                out4 = 4'd4;
            end
            if (in == 9'd227) begin
                out1 = 4'd3;
                out2 = 4'd3;
                out3 = 4'd4;
                out4 = 4'd4;
            end
            if (in == 9'd228) begin
                out1 = 4'd3;
                out2 = 4'd5;
                out3 = 4'd4;
                out4 = 4'd4;
            end
            if (in == 9'd229) begin
                out1 = 4'd2;
                out2 = 4'd7;
                out3 = 4'd4;
                out4 = 4'd4;
            end
            if (in == 9'd230) begin
                out1 = 4'd2;
                out2 = 4'd9;
                out3 = 4'd4;
                out4 = 4'd4;
            end
            if (in == 9'd231) begin
                out1 = 4'd1;
                out2 = 4'd1;
                out3 = 4'd5;
                out4 = 4'd4;
            end
            if (in == 9'd232) begin
                out1 = 4'd1;
                out2 = 4'd3;
                out3 = 4'd5;
                out4 = 4'd4;
            end
            if (in == 9'd233) begin
                out1 = 4'd0;
                out2 = 4'd5;
                out3 = 4'd5;
                out4 = 4'd4;
            end
            if (in == 9'd234) begin
                out1 = 4'd0;
                out2 = 4'd7;
                out3 = 4'd5;
                out4 = 4'd4;
            end
            if (in == 9'd235) begin
                out1 = 4'd9;
                out2 = 4'd8;
                out3 = 4'd5;
                out4 = 4'd4;
            end
            if (in == 9'd236) begin
                out1 = 4'd9;
                out2 = 4'd0;
                out3 = 4'd6;
                out4 = 4'd4;
            end
            if (in == 9'd237) begin
                out1 = 4'd8;
                out2 = 4'd2;
                out3 = 4'd6;
                out4 = 4'd4;
            end
            if (in == 9'd238) begin
                out1 = 4'd8;
                out2 = 4'd4;
                out3 = 4'd6;
                out4 = 4'd4;
            end
            if (in == 9'd239) begin
                out1 = 4'd7;
                out2 = 4'd6;
                out3 = 4'd6;
                out4 = 4'd4;
            end
            if (in == 9'd240) begin
                out1 = 4'd7;
                out2 = 4'd8;
                out3 = 4'd6;
                out4 = 4'd4;
            end
            if (in == 9'd241) begin
                out1 = 4'd7;
                out2 = 4'd0;
                out3 = 4'd7;
                out4 = 4'd4;
            end
            if (in == 9'd242) begin
                out1 = 4'd6;
                out2 = 4'd2;
                out3 = 4'd7;
                out4 = 4'd4;
            end
            if (in == 9'd243) begin
                out1 = 4'd6;
                out2 = 4'd4;
                out3 = 4'd7;
                out4 = 4'd4;
            end
            if (in == 9'd244) begin
                out1 = 4'd5;
                out2 = 4'd6;
                out3 = 4'd7;
                out4 = 4'd4;
            end
            if (in == 9'd245) begin
                out1 = 4'd5;
                out2 = 4'd8;
                out3 = 4'd7;
                out4 = 4'd4;
            end
            if (in == 9'd246) begin
                out1 = 4'd4;
                out2 = 4'd0;
                out3 = 4'd8;
                out4 = 4'd4;
            end
            if (in == 9'd247) begin
                out1 = 4'd4;
                out2 = 4'd2;
                out3 = 4'd8;
                out4 = 4'd4;
            end
            if (in == 9'd248) begin
                out1 = 4'd3;
                out2 = 4'd4;
                out3 = 4'd8;
                out4 = 4'd4;
            end
            if (in == 9'd249) begin
                out1 = 4'd3;
                out2 = 4'd6;
                out3 = 4'd8;
                out4 = 4'd4;
            end
            if (in == 9'd250) begin
                out1 = 4'd2;
                out2 = 4'd8;
                out3 = 4'd8;
                out4 = 4'd4;
            end
            if (in == 9'd251) begin
                out1 = 4'd2;
                out2 = 4'd0;
                out3 = 4'd9;
                out4 = 4'd4;
            end
            if (in == 9'd252) begin
                out1 = 4'd1;
                out2 = 4'd2;
                out3 = 4'd9;
                out4 = 4'd4;
            end
            if (in == 9'd253) begin
                out1 = 4'd1;
                out2 = 4'd4;
                out3 = 4'd9;
                out4 = 4'd4;
            end
            if (in == 9'd254) begin
                out1 = 4'd0;
                out2 = 4'd6;
                out3 = 4'd9;
                out4 = 4'd4;
            end
            if (in == 9'd255) begin
                out1 = 4'd0;
                out2 = 4'd8;
                out3 = 4'd9;
                out4 = 4'd4;
            end
        end
    end	

endmodule