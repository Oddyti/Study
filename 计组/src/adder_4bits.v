module adder_4bits (
    a,
    b,
    ci,
    s,
    co
);
    input [3:0] a;
    input [3:0] b;
    input ci;       //最低进位
    output [3:0] s; //求和结果
    output co;      //最高进位
    
    wire [3:0] g,p;

    assign g = a & b;
    assign p = a | b;

    wire [3:0] tC;
    assign tC[0] = g[0] | p[0] & ci;
    assign tC[1] = g[1] | p[1] & g[0] | p[1] & p[0] & ci;
    assign tC[2] = g[2] | p[2] & g[1] | p[2] & p[1] & g[0] | p[2] & p[1] & p[0] & ci;
    assign tC[3] = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0] | p[3] & p[2] & p[1] & p[0] & ci;
    assign co = tC[3];
    wire [3:0] c;
    assign c = {tC[2:0],ci};
    assign s = p & (~g) ^ c;

    
endmodule