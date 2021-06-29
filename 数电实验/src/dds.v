module dds (
    clk, 
    reset, 
    k, 
    sampling_pulse, 
    new_sample_ready, 
    sample
);
    input clk, reset,sampling_pulse;
    input [21:0] k;
    output [15:0] sample;
    output new_sample_ready;
    wire [21:0] raw_addr;
    wire [21:0] s_d;
    wire [9:0] rom_addr;
    wire [15:0] raw_data;
    wire [15:0] data;
    wire area;
    // 实现s_d = k + raw_addr
    full_adder addr(.a(k), .b(raw_addr), .s(s_d), .co());

    //d触发器1
    dffre #(.n(22))d1(.d(s_d), .en(sampling_pulse), .r(reset), .clk(clk), .q(raw_addr));
    
    //地址处理
    assign rom_addr[9:0] = raw_addr[20]?((raw_addr [20:10] == 1024)?1023:(~raw_addr[19:10]+1)):raw_addr[19:10];

    //SineROM
    sine_rom rom(.clk(clk), .addr(rom_addr), .dout(raw_data));

    //d触发器得到area
    dffre #(.n(1))d2(.d(raw_addr[21]), .en(1), .r(0), .clk(clk), .q(area));

    //数据处理
    assign data[15:0] = area?(~raw_data[15:0]+1):raw_data[15:0];

    //d触发器得到sample
    dffre #(.n(16))d3(.d(data), .en(sampling_pulse), .r(0), .clk(clk), .q(sample));

    //d触发器得到
    dffre #(.n(1))d4(.d(sampling_pulse), .en(1), .r(0), .clk(clk), .q(new_sample_ready));
    
endmodule