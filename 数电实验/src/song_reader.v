module song_reader (
    song,           //来自mcu的控制信号，当前播放乐曲的序号
    clk,            //100MHz时钟信号
    reset,          //复位信号，高电平有效
    note_done,      //即模块note player的应答信号，一个时钟周期宽度的脉冲，表示一个音符播放结束并索取新音符
    play,           //来自mcu的控制信号，高电平要求播放
    song_done,      //给mcu 的应答信号，当乐曲播放结束，输出-一个时钟周期宽度的脉冲，表示乐曲播放结束
    new_note,       //给模块note_playe的控制信号，一个时钟周期宽度的高电平脉冲，表示新的音符需播放
    note,           //音符标记
    duration        //音符的持续时间
);
    input clk, reset, play, note_done;
    input [1:0] song;
    output song_done, new_note;
    output [5:0] note, duration;
    wire [4:0] q;   //song_rom的低5位地址
    wire co;        //地址计数器进位

    //地址计数器
    counter_n #(.n(32), .counter_bits(5)) song_counter(
        .clk(clk),
        .en(note_done),
        .r(reset),
        .q(q),
        .co(co)
    );

    //控制器
    song_reader_controller s_ctrl1(
        .clk(clk), 
        .reset(reset), 
        .play(play), 
        .note_done(note_done), 
        .new_note(new_note)
    );

    //结束判断
    over over1(
        .clk(clk), 
        .duration(duration), 
        .co(co), 
        .out(song_done),
        .reset(reset)
    );

    //song_rom
    song_rom songs(
        .clk(clk), 
        .dout({note,duration}), 
        .addr({song,q})
    );


endmodule