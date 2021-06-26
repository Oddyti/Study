module note_player (
    clk,                //系统时钟信号，外接sys_clk
    reset,              //复位信号，高电平有效，外接mcu模块的reset_ play
    play_enable,        //来自mcu模块的play信号，高电平表示播放
    note_to_load,       //来自song_reader模块的音符标记note，表示需播放的音符
    duration_to_load,   //来自 song _reader模块的音符持续时间duration，表示需播放音符的音长
    load_new_note,      //来自 song_reader模块的new_note信号，一个时钟周期宽度的高电平脉冲，表示新的音符需播放
    note_done,          //给song_reader模块的应答信号，一个时钟周期宽度的高电平脉冲，表示音符播放完毕
    sampling_pulse,     //来自同步化电路模块的ready信号，频率48kHz，一个时钟周期宽度的高电平脉冲，表示索取新的正弦样品
    beat,               //定时基准信号，频率为48Hz脉冲，一个时钟周期宽度的高电平脉冲
    sample,             //正弦样品输出
    sample_ready        //正弦成功输出信号
);
    input clk, reset, play_enable, load_new_note,sampling_pulse,beat;
    input [5:0] note_to_load, duration_to_load;
    output note_done, sample_ready;
    output [15:0] sample;
    wire load;                      //读取新的音符
    wire [5:0] q;                   //FreqROM地址输入
    wire [19:0] dout;               //FreqROM读取的相位增量
    wire timer_clear,timer_done;    //清零信号与定时结束标志

    //D触发器
    dffre #(.n(6)) note_dffre(
        .d(note_to_load),
        .en(load),
        .r(~play_enable||reset),
        .clk(clk),
        .q(q)
    );

    //FreqROM
    frequency_rom FreqROM(
        .clk(clk),
        .dout(dout),
        .addr(q)
    );

    //DDS
    dds note_dds(
        .clk(clk),
        .reset(~play_enable||reset),
        .k({2'b00,dout}),
        .sampling_pulse(sampling_pulse),
        .new_sample_ready(sample_ready),
        .sample(sample)
    );

    //控制器
    note_player_controller note_ctrl(
        .clk(clk),
        .reset(reset),
        .play_enable(play_enable),
        .load_new_note(load_new_note),
        .load(load),
        .note_done(note_done),
        .timer_clear(timer_clear),
        .timer_done(timer_done)
    );

    //音符节拍定时器
    timer note_counter(
        .clk(clk),
        .r(timer_clear),
        .en(beat),
        .n(duration_to_load),
        .done(timer_done)
    );
endmodule