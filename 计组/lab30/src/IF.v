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
    assign IF_flush = Jump|Branch;
    assign addr = PC[5:0];
    InstructionROM ins(.addr(addr), .dout(Instruction_if));  
    adder_32bits adder(.a(PC), .b(32'h4), .ci(), .s(NextPC_if), .co());
    dffr dffr1(.d(MuxOut), .r(IFWrite), .clk(clk), .q(PC));
    mux2 mux(.a(NextPC_if), .b(JumpAddr), .addr(IF_flush), .dout(MuxOut))
endmodule
