module music_player (  
    input clk,              //高电平有效
    input reset,            //复位输入，高电平有效
    input play_pause,       //“播放/暂停”输入，高电平同步脉冲
    input next,             //“下一首”输入，高电平同步脉冲
    input NewFrame,         //高电平非同步脉冲，索取新样品
    output [15:0] sample,   //正弦样品输出
    output play,            //播放状态指示
    output [1:0] song       //曲号指示
);
    parameter sim = 0;

    wire ready;
    wire beat;
    wire song_done;
    wire reset_play;
    wire note_done;
    wire new_note;
    wire [5:0]note;
    wire [5:0]duration;
    wire sample_ready;
    
    //MCU
    mcu mcu1(
        .clk(clk),
        .reset(reset),
        .play_pause(play_pause),
        .next(next),
        .play(play),
        .reset_play(reset_play),
        .song_done(song_done),
        .song(song)
    );
  
    //song_reader
    song_reader song_reader1(
        .song(song),
        .clk(clk),
        .reset(reset_play),
        .note_done(note_done),
        .play(play),
        .song_done(song_done),
        .new_note(new_note),
        .note(note),
        .duration(duration)
    );
    //note_player
    note_player note_player1(
        .clk(clk),
        .reset(reset_play),
        .play_enable(play),
        .note_to_load(note),
        .duration_to_load(duration),
        .load_new_note(new_note),
        .note_done(note_done),
        .sampling_pulse(ready),
        .beat(beat),
        .sample(sample),
        .sample_ready(sample_ready)
    );
    //synchro
    synchro syn1(
        .clk(clk),
        .in(NewFrame),
        .out(ready)
    );
    
    //节拍基准产生器
    counter_n #(.n(sim?64:1000), .counter_bits(sim?6:10)) beatcounter(
        .clk(clk),
        .en(ready),
        .r(0),
        .q(),
        .co(beat)    
    );
endmodule