`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module IF(clk, reset, Branch,Jump, IFWrite, JumpAddr,Instruction_if,PC,IF_flush);
    input clk;
    input reset;
    input Branch;
    input Jump;
    input IFWrite;
    input [31:0] JumpAddr;
    output [31:0] Instruction_if;
    output [31:0] PC;
    output IF_flush;

    wire [5:0] addr;        //PC的前6位
    wire [31:0] MuxOut;     //指令指针选择器的结果
    wire [31:0] NextPC_if;  //PC+4的结果

    reg [31:0] PC;

    assign IF_flush = Jump || Branch;
    assign addr = PC[7:2];

    InstructionROM ins(
        .addr(addr), 
        .dout(Instruction_if)
    ); 

    adder_32bits adder(
        .a(PC), 
        .b(32'd4), 
        .ci(1'b0), 
        .s(NextPC_if), 
        .co()
    );

    mux_2to1 #(.n(32)) mux(
        .in0(NextPC_if), 
        .in1(JumpAddr), 
        .addr(IF_flush), 
        .out(MuxOut)
    );
    // PC寄存器
    always @(posedge clk) begin
        if (reset) begin
            PC <= 0;
        end
        else if(IFWrite) begin
            PC <= MuxOut;
        end
        else PC <= PC;
    end
endmodule
