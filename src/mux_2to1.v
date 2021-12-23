module mux_2to1(
    out, in0, in1, addr
);
    parameter n = 4;
    input [n-1:0] in0, in1;
    input addr;
    output reg [n-1:0] out;

    always @(*) begin
        if (addr) begin
            out = in1;
        end
        else begin
            out = in0;
        end
    end
endmodule