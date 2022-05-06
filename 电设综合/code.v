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