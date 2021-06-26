module note_player_controller (
    clk,
    reset,
    play_enable,
    load_new_note,
    load,
    note_done,
    timer_clear,
    timer_done
);
    input clk, reset, play_enable, timer_done, load_new_note;
    output reg load,timer_clear,note_done;
    parameter RESET = 0, WAIT = 1, DONE = 2, LOAD = 3;
    reg [1:0] state, nextstate;
    //状态
    always @(posedge clk ) begin
        if(reset) state = RESET;
        else state = nextstate;
    end

    //下一状态和输出
    always @(*) begin
        load = 0; timer_clear = 0; note_done = 0;
        case(state)
            RESET:
                begin
                    timer_clear = 1;
                    load = 0;
                    note_done = 0;
                    nextstate = WAIT;
                end
            WAIT:
                begin
                    timer_clear = 0;
                    load = 0;
                    note_done = 0;
                    if(play_enable)
                        begin
                            if(timer_done) nextstate = DONE;
                            else
                                begin
                                    if(load_new_note) nextstate = LOAD;
                                    else nextstate = WAIT;
                                end
                        end
                    else nextstate = RESET;
                end
            DONE:
                begin
                    timer_clear = 1;
                    load = 0;
                    note_done = 1;
                    nextstate = WAIT;
                end
            LOAD:
                begin
                    timer_clear = 1;
                    load = 1;
                    note_done = 0;
                    nextstate = WAIT;
                end
            default: nextstate = RESET;
        endcase
    end
endmodule