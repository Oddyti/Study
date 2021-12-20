module dffr (
    d,
    r,
    clk,
    q
);
   input d;
   input r, clk;
   reg output q;

   always @(posedge clk) begin
       if (clk) begin
           q <= d;
       end
   end 
endmodule