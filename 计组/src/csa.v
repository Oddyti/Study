module csa (
    a,
    b,
    ci,
    s,
    co
);
    input [3:0] a;
    input [3:0] b;
    input ci;
    output reg [3:0] s;
    output co;
    wire [1:0] c;
    wire [3:0] s0;
    wire [3:0] s1;

    adder_4bits adder_1(
        .a(a[3:0]),
        .b(b[3:0]),
        .ci(1),
        .s(s1),
        .co(c[1])
    );

    adder_4bits adder_0(
        .a(a[3:0]),
        .b(b[3:0]),
        .ci(0),
        .s(s0),
        .co(c[0])
    );
    // 进位
    assign co = c[0] | (ci & c[1]);
    // MUX
    always @(*) begin
        if (ci) begin
            s = s1;
        end
        else begin
            s = s0;
        end
    end

endmodule