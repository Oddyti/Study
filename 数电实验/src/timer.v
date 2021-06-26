module timer (
    clk, r, en, n, done
);
    input clk, r, en;
    input [5:0] n;
    output done;
    reg [5:0] counter;
    assign done = en && (counter == n-1);
    always @(posedge clk) begin
        if(r) counter=0;
        else if(en) 
            counter  = counter+1;
    end
endmodule