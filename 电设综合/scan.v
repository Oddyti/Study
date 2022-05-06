module scan();

    //elk为低频时钟源如128Hz 
    always @(posedge elk or negedge reset) begin
        if(reset==O) begin 
            scanvalue<=l; //scanvalue记录扫描数据
            led<=5'b 11111; //5位led的亮灭显示对应所按 下的键；其值为0时有效， LED发亮
            combvalue<=O; //combvalue为行扫描和列 扫描的组合值
        end
        else begin //每若干ms进行一次键盘扫描
            key_ out<=scanvalue;//输出扫描值；
            case(scanvalue)
                4'b0001: scanvalue<=4'b0010; 
                4'b0010: scanvalue<=4'b0100; 
                4'b0100: scanvalue<=4'b 1000; 
                4'b 1000: scanvalue<=4'b0001; 
                default: scanvalue<=4'b0001;  
            endcase 
            combvalue <= {key—in,key_out}; //key_in对应 column列 
            case(combvalue) 
                8'b00010001: led<=5'b11110; //对应键盘“1"
                8'b00100001: led<=5'b11101; //对应键盘”2"
                8'b01000001: led<=5'b11100; //对应键盘“3"
                8'b10000001: led<=5'b11011; //对应键盘”X"
                8'b00010010: led<=5'b11010; //对应键盘”4"
                8'b00100010: led<=5'b11001; //对应键盘”5"
                8'b01000010: led<=5'b11000; //对应键盘”6"
                8'b10000010: led<=5'b10111; //对应键盘”Y"
                8'b00010100: led<=5'b10110; //对应键盘”7"
                8'b00100100: led<=5'b10101; //对应键盘“8"
                8'b01000100: led<=5'b10100; //对应键盘“9"
                8'b10000100: led<=5'b10011; //对应键盘”Z"
                8'b00011000: led<=5'b10010; //对应键盘“O"
                8'b00101000: led<=5'b10001; //对应键盘+＂
                8'b01001000: led<=5'b10000; //对应键盘”-“
                8'b10001000: led<=5'b01111; //对应键盘”="
                default: led<=5'b 11111; //无键盘按下，全部LED灯都不亮
            endcase 
        end
    end
endmodule