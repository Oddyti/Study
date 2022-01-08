module CacheController(
    input clk,                  \\ 时钟信号
    input reset,                \\ 复位信号
    input ld,                   \\ 加载请求
    input st,                   \\ 储存请求
    input [31:0] addr,          \\ cache访问地址
    input [20:0] tag_loaded,    \\ cache中存放的date地址
    input valid,                \\ 有效位
    input dirty,                \\ 脏值位
    input l2_ack,               \\ 从L2加载的数据已到达
    input write_done,           \\ 写入L2的数据已完成
    output reg hit,             \\ 是否命中
    output reg miss,            \\ 是否失效
    output reg load_ready,      \\ 数据已成功加载
    output reg write_l1,        \\ 启用L1高速缓存写入
    output reg read_l2,         \\ 加载请求到L2高速缓存
    output reg write_l2,        \\ 启用回写缓冲区
    output state                \\ 状态机状态
);

    // 状态编码
    parameter Idle = 0, CompareTag = 1, WriteBack = 2, Allocate = 3;
    reg [1:0] state, nextstate;

    // 第一段
    always @(posedge clk) begin
        if(reset) state = Idle;
        else state = nextstate;
    end

    // 第二段
    always @(*) begin
        hit = 0 ; miss = 0;
        load_ready = 0 ; write_l1 = 0;
        write_l2 = 0 ;read_l2 = 0;
        case(state)
            Idle: begin
                if(ld | st) begin
                    nextstate = CompareTag;
                end  
                else nextstate = Idle;
            end

            CompareTag: begin
                if(valid && addr[31:11] == tag_loaded) begin
                    hit = 1;
                    miss = 0;
                    if(ld) begin
                        load_ready = 1;                     
                    end
                    else if(st) begin
                        load_ready = 1;                  
                        write_l1 = 1;  
                    end
                    nextstate = Idle;
                end
                else begin
                    miss = 1;
                    hit = 0;
                    if(dirty) begin
                        nextstate = WriteBack;
                    end 
                    else nextstate = Allocate;
                end
            end

            WriteBack: begin
                write_l2 = 1;
                if(write_done) begin
                    write_l2 = 0;
                    nextstate = Allocate;
                end 
                else begin 
                    write_l2 = 1;
                    nextstate = WriteBack;
                end
            end

            Allocate: begin
                read_l2 = 1;
                if(l2_ack) begin
                    read_l2 = 0;
                    nextstate = CompareTag;
                end
                else begin
                    read_l2 = 1;
                    nextstate = Allocate;
                end
            end
        endcase
    end
endmodule 