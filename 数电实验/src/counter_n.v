module counter_n(
    clk,
    en,
    r,
    q,
    co
    );
    parameter  n=2; //参数n表示计数的模   
    parameter  counter_bits=1;//参数counter_bits表示计数的位数 
    input   clk, en, r;
    output  co;
    output [counter_bits:1]  q;
    reg [counter_bits:1]  q=0;
    assign  co=(q==(n-1)) && en;//进位
    always @(posedge clk) 
        begin
            if(r) q=0; //置零
            else if(en)  //en=1,计数；en=0,保持
                begin	 
                        if(q==(n-1))  q=0 ; //q已满，进位
                        else q=q+1;		      //q为满，计数
                end
            else q = q;
        end
endmodule