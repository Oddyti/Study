module mcu (
    clk,            //100MHz时钟信号
    reset,          //复位信号，高电平有效
    play_pause,     //来自按键处理模块的“播放/暂停”控制信号，一个时钟周期宽度的脉冲
    next,           //来自按键处理模块的“下一曲”控制信号，一个时钟周期宽度的脉冲
    play,           //输出控制信号，高电平表示播放，控制song _reader模块是否要播放
    reset_play,     //时钟周期宽度的高电平复位脉冲reset play，用于同时复位模块song_reader和 note_ player
    song_done,      //song_ reader模块的应答信号，一个时钟周期宽度的高电平脉冲，表示一曲播放结束
    song            //当前播放乐曲的序号
);
    input clk, reset, play_pause, next, song_done;
    output play, reset_play;
    output [1:0] song;
    wire NextSong;

    //mcu控制器
    mcu_controller m_ctrl1 (
        .clk(clk),
        .reset(reset),
        .play_pause(play_pause),
        .next(next),
        .song_done(song_done),
        .play(play),
        .reset_play(reset_play),
        .NextSong(NextSong)
    );

    //2位二进制计数器
    counter_n #(.n(4), .counter_bits(2)) m_counter(
        .clk(clk),
        .en(NextSong),
        .r(reset),
        .q(song),
        .co()
    );

endmodule