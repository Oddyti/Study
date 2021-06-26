module mcu_controller (
    clk,
    reset,
    play_pause,
    next,
    song_done,
    play,
    reset_play,
    NextSong    
);
    input clk, reset, play_pause, next, song_done;
    output reg play, reset_play, NextSong;
    parameter RESET = 0, PAUSE = 1, PLAY = 2, NEXT = 3;

    reg [1:0] state;        //状态信号
    reg [1:0] nextstate;    //驱动信号

    //状态寄存器
    always @(posedge clk ) begin
        if(reset) state = RESET;
        else state = nextstate;
    end

    //下一状态和输出
    always @(*) begin
        // play = 0;NextSong = 0;reset_play = 0;
        case(state)
            RESET:
                begin 
                    play = 0;
                    NextSong = 0;
                    reset_play = 1;
                    nextstate = PAUSE; 
                end
            PAUSE:
                begin
                    play = 0;
                    NextSong = 0;
                    reset_play = 0;
                    if(play_pause) nextstate = PLAY;
                    else
                        begin
                            if(next) nextstate = NEXT;
                            else nextstate = PAUSE;
                        end 
                end
            PLAY:
                begin
                    play = 1;
                    NextSong = 0;
                    reset_play = 0;
                    if(play_pause) nextstate = PAUSE;
                    else 
                        begin
                            if(next) nextstate = NEXT;
                            else 
                                begin
                                    if(song_done) nextstate = RESET;
                                    else nextstate = PLAY;
                                end
                        end
                end
            NEXT:
                begin 
                    play = 0;
                    NextSong = 1;
                    reset_play = 1;
                    nextstate = PLAY;
                end
            default: nextstate = RESET;
        endcase
    end
endmodule

