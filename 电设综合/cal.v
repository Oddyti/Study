module cal();

    //clk为系统时钟信号6MHz
    always @(posedge elk or negedge reset) begin 
        if(reset==l'b0) timecnt<=0; 
        //timecnt为分频计数器，用来得到l0ms时钟
        else if(timecnt==29999) begin 
            time 10ms<=~time 10ms; 
            //time 10ms为10ms时钟timecnt<=0; 
        end 
        else timecnt<=timecnt+ 1; 
    end 

    //键盘扫描进程
    always @(posedge timel0ms or negedge reset) begin 
        if(reset==0) begin
            scanvalue<=l;  //scanvalue用于记录扫描数据
            flag_ Data<=0; //flag_ Data为输入数据顺序标志
            flag_ 0ver<=0; //flag—0ver为完成计算标志
            flag_ Cal<=0;  //tlag—Cal用千标记运算方式，l—加法，2—减法
            int—Data0<=0; 
            int—Data1<=0;  //int—Data0和int_Datal为待运算的两个整数
            PointTime<=1; //PointTime为数码管中间的”:＂，在这里用于指示“+”或“-”运算符的输入
            led_int—Data2<=10;
            //led—int—Data2为送去第2个数码管显示的数据， 为10表示正数不显示， 为11表示负数显示 “ -“ int—Data<=0; //int_Data为运算结果
        end
        else begin
            key_out<=scanvalue;//输出扫描值

            case(scanvalue) //扫描值移位
                4'b0001: scanvalue<=4'b0010;
                4'b0010: scanvalue<=4'b0100;
                4'b0100: scanvalue<=4'b1000;
                4'b1000: scanvalue<=4'b0001;
                default: scanvalue<=4'b0001; 
            endcase 

            case({key_in,key_out}) //翻译扫描结果
                8'b00010001: //对应键盘 ” 1" 
                    begin
                        case(flag_ Data) 
                            0: begin led—int—Data2<=10; int_ Data0<=2;int—Data<=2; tlag_ Data<=1; end //第1个数
                            2: begin int_Datal <=2; int_Data<=2; flag_Data<=3; end //第2个数
                            default:; 
                        endcase
                    end
                    
                8'b00100001: //对应键盘” 2"
                    begin
                        case(flag_ Data)
                            0: begin led—int—Data2<=1 0; int_ Data0<=2; int—Data<=2; tlag_ Data<=1; end //第1个数
                            2: begin int_Datal <=2; int_Data<=2; flag_Data<=3; end //第2个数
                            default:;
                        endcase
                    end

                8'b01000001: //对应键盘“3”
                    begin 
                        case(flag_Data) 
                            0: begin led_int_Data2<=10;int_Data0<=3;int_Data<=3;flag_Data<=1; end //第1个数 
                            2: begin int_Datal<=3;int_Data<=3;flag_Data<=3; end //第2个数 
                            default:; 
                        endcase 
                    end

                8'b00010010: //对应键盘“4”
                    begin 
                        case(flag_Data) 
                            0: begin led_int_Data2<=10;int_Data0<=4;int_Data<=4;flag_Data<=1; end //第1个数 
                            2: begin int_Datal<=4;int_Data<=4;flag_Data<=3; end //第2个数 
                            default:; 
                        endcase 
                    end

                8'b00100010: //对应键盘“5”
                    begin 
                        case(flag_Data) 
                            0: begin led_int_Data2<=10;int_Data0<=5;int_Data<=5;flag_Data<=1; end //第1个数 
                            2: begin int_Datal<=5;int_Data<=5;flag_Data<=3; end //第2个数 
                            default:; 
                        endcase 
                    end

                8'b01000010: //对应键盘“6”
                    begin 
                        case(flag_Data) 
                            0: begin led_int_Data2<=10;int_Data0<=6;int_Data<=6;flag_Data<=1; end //第1个数 
                            2: begin int_Datal<=6;int_Data<=6;flag_Data<=3; end //第2个数 
                            default:; 
                        endcase 
                    end

                8'b00010100: //对应键盘“7”
                    begin 
                        case(flag_Data) 
                            0: begin led_int_Data2<=10;int_Data0<=7;int_Data<=7;flag_Data<=1; end //第1个数 
                            2: begin int_Datal<=7;int_Data<=7;flag_Data<=3; end //第2个数 
                            default:; 
                        endcase 
                    end

                8'b00100100: //对应键盘“8”
                    begin 
                        case(flag_Data) 
                            0: begin led_int_Data2<=10;int_Data0<=8;int_Data<=8;flag_Data<=1; end //第1个数 
                            2: begin int_Datal<=8;int_Data<=8;flag_Data<=3; end //第2个数 
                            default:; 
                        endcase 
                    end

                8'b01000100: //对应键盘“9”
                    begin 
                        case(flag_Data) 
                            0: begin led_int_Data2<=10;int_Data0<=9;int_Data<=9;flag_Data<=1; end //第1个数 
                            2: begin int_Datal<=9;int_Data<=9;flag_Data<=3; end //第2个数 
                            default:; 
                        endcase 
                    end
                8'b10000001:; //对应键盘 “X"
                8'b10000010:; //对应键盘 “ Y"
                8'b10000100: //对应键盘 ” Z", 复位
                    begin 
                        flag_ 0ver<=0;
                        flag_ Data<=0;
                        int—Data0<=0;
                        int—Datal<=0;
                        PointTime<= 1;
                        led_int—Data2<=10;
                        int—Data<=0; 
                    end
                8'b00101000: //对应键盘 ”+ ＂ ， 准备做加法
                    begin 
                        if(flag_ Data== 1) begin 
                            flag_ Cal<= 1;
                            PointTime<=0;
                            flag_ Data<=2; 
                        end 
                    end 
                8'b01001000: //对应键盘 ” -“， 准备做减法
                    begin 
                        if(tlag_Data==1) begin 
                            flag_Cal<=2;
                            PointTime<=0;
                            tlag_ Data<=2; 
                        end 
                    end 
                8'b10001000: //对应键盘 ” = ＂ ， 进行运算
                    begin 
                        case(flag—Cal) 
                            1: begin
                                int_ Data<=int_ Data0+int_ Data1;
                                led _int_ Data2<=10; 
                            end 
                            2: begin 
                                if(int—Data0>=int_ Data1) begin 
                                    int_ Data<=int_Data0-int_ Data1;
                                    led_int - Data2<=10; 
                                    //减法，差为正数， 第2个数码管不显示表示正数（为10时设计译码使对应数码管全暗）
                                    end
                                else begin 
                                    int_Data<=int_Datal-int_Data0;
                                    led_int—Data2<=11; 
                                    //减法， 差为负数， 第2个数码管显示“-”号表示负数（为11时设计译码使对应数码管显示“ -”)
                                end
                            end
                            default:;
                        endcase
                    PointTime<=l;
                    flag—Cal<=0;
                    flag—Data<=0; 
                    end 
                default:;//无键盘按下
            endcase 
        end 
    end 
    //给数码管传输数据
    //其中数码管显示译码部分略， 参见实验二中的数码管扫描显示原理
    always @(clk,reset) begin 
        if(reset==0) begin
            led_int—Datal <=0;
            led _int_Data0<=0; //第1个数码管不显示， 第3、 4个数码管为0
        end
    
        else begin
            if (int_Data >9) begin
            led_ int_ Datal <= 1 ;led _int_ Data0<=int_ Data-I 0;//分解成BCD码
            end
            else begin
                led—int—Datal <=10; //第3个数码管不显示 
                led—int—Data0<=int_ Data; 
            end
        end
    end
endmodule