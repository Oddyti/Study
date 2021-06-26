module over (
    clk,
    duration,
    co,
    out,
    reset
);
    input clk,co,reset;
    input [5:0] duration;
    output reg out;
    parameter RESET = 0, PAUSE = 1, PLAY = 2, END = 3;
    reg [1:0] state = 0,nextstate;

    always @(posedge clk ) begin
        if(reset)
            state = RESET;
        else state = nextstate;
    end

    always @(*) begin
        case(state)
        RESET:
            begin
                out = 1;
                nextstate = PAUSE;
            end
        PAUSE:
            begin
                out = 0;
                if(co||(~duration)) nextstate = PAUSE;
                else nextstate = PLAY;
            end
        PLAY:
            begin
                out = 0;
                if(co||(~duration)) nextstate = END;
                else nextstate = PLAY;
            end
        END:
            begin
                out = 1;
                nextstate = PAUSE;
            end
        default: nextstate = RESET;
        endcase
    end
endmodule


// //判断乐曲是否播放结束模块
// module over (
//     input [5:0] duration ,
//     input reset , clk ,
//     output reg done
// );
//     parameter RESET = 0 , PAUSE = 1 , PLAY = 2 , OUT = 3;
//     reg [1:0] state = 0 , nextstate;

//     always @(posedge clk) begin
//         if(reset) state = RESET;
//         else state = nextstate;
//     end

//     always @(*) begin
//         done = 0;
//         case (state)
//             RESET:begin
//                 done = 1;
//                 nextstate = PAUSE;
//             end 
//             PAUSE:begin
//                 done = 0;
//                 if(duration)begin
//                     nextstate = PLAY;
//                 end
//                 else nextstate = PAUSE;
//             end
//             PLAY:begin
//                 done = 0;
//                 if(duration) nextstate = PLAY;
//                 else nextstate = OUT;
//             end
//             OUT:begin
//                 done = 1;
//                 nextstate = PAUSE;
//             end
//         endcase
//     end
// endmodule