`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module Risc5CPU(clk, reset, JumpFlag, Instruction_id, ALU_A, 
                     ALU_B, ALUResult_ex, PC, MemDout_mem,Stall);
    input clk;
    input reset;
    output[1:0] JumpFlag;
    output [31:0] Instruction_id;
    output [31:0] ALU_A;
    output [31:0] ALU_B;
    output [31:0] ALUResult_ex;
    output [31:0] PC;
    output [31:0] MemDout_mem;
    output Stall;

    // 自定义变量
        // IF
        wire IFWrite, IF_flush;
        wire [31:0] JumpAddr, Instruction_if;
        // IF_ID
        wire [31:0] PC_id;
        // ID
        wire RegWrite_wb, MemRead_ex, RegWrite_id, MemWrite_id, MemRead_id, ALUSrcA_id;
        wire [4:0] rdAddr_wb, rdAddr_ex, rs1Addr_id, rs2Addr_id, rdAddr_id;
        wire [31:0] RegWriteData_wb, Imm_id, rs1Data_id, rs2Data_id;
        wire [3:0] ALUCode_id;
        wire [1:0] ALUSrcB_id;
        // ID_EX
        

    // IF
    IF IF1(
        .clk(clk), 
        .reset(reset), 
        .Branch(JumpFlag[0]),
        .Jump(JumpFlag[1]), 
        .IFWrite(IFWrite), 
        .JumpAddr(JumpAddr),
        .Instruction_if(Instruction_if),
        .PC(PC),
        .IF_flush(IF_flush)
    );
    // IF_ID
    IF_ID IF_ID1(
        .clk(clk), 
        .EN(IFWrite), 
        .R(IF_flush), 
        .PC_if(PC), 
        .Instruction_if(Instruction_if), 
        // output
        .PC_id(PC_id), 
        .Instruction_id(Instruction_id)
    );

    // ID
    ID ID1(
        // input
        .clk(clk),
        .Instruction_id(Instruction_id), 
        .PC_id(PC_id), 
        .RegWrite_wb(RegWrite_wb), 
        .rdAddr_wb(rdAddr_wb), 
        .RegWriteData_wb(RegWriteData_wb), 
        .MemRead_ex(MemRead_ex), 
        .rdAddr_ex(rdAddr_ex), 
        // output
        .MemtoReg_id(MemtoReg_id), 
        .RegWrite_id(RegWrite_id), 
        .MemWrite_id(MemWrite_id), 
        .MemRead_id(MemRead_id), 
        .ALUCode_id(ALUCode_id), 
        .ALUSrcA_id(ALUSrcA_id), 
        .ALUSrcB_id(ALUSrcB_id),  
        .Stall(Stall), 
        .Branch(JumpFlag[0]), 
        .Jump(JumpFlag[1]), 
        .IFWrite(IFWrite),  
        .JumpAddr(JumpAddr), 
        .Imm_id(Imm_id),
        .rs1Data_id(rs1Data_id), 
        .rs2Data_id(rs2Data_id),
        .rs1Addr_id(rs1Addr_id),
        .rs2Addr_id(rs2Addr_id),
        .rdAddr_id(rdAddr_id)
    );
    // ID_EX
    ID_EX ID_EX1(
        //input
        .clk(clk), 
        .R(Stall|reset), 
        .MemtoReg_id(MemtoReg_id), 
        .RegWrite_id(RegWrite_id), 
        .MemWrite_id(MemWrite_id), 
        .MemRead_id(MemRead_id), 
        .ALUCode_id(ALUCode_id), 
        .ALUSrcA_id(ALUSrcA_id), 
        .ALUSrcB_id(ALUSrcB_id), 
        .PC_id(PC_id), 
        .Imm_id(Imm_id), 
        .rdAddr_id(rdAddr_id), 
        .rs1Addr_id(rs1Addr_id), 
        .rs2Addr_id(rs2Addr_id), 
        .rs1Data_id(rs1Data_id), 
        .rs2Data_id(rs2Data_id),
        //output
        .MemtoReg_ex(MemtoReg_ex), 
        .RegWrite_ex(RegWrite_ex), 
        .MemWrite_ex(MemWrite_ex), 
        .MemRead_ex(MemRead_ex), 
        .ALUCode_ex(ALUCode_ex), 
        .ALUSrcA_ex(ALUSrcA_ex), 
        .ALUSrcB_ex(ALUSrcB_ex), 
        .PC_ex(PC_ex), 
        .Imm_ex(Imm_ex), 
        .rdAddr_ex(rdAddr_ex), 
        .rs1Addr_ex(rs1Addr_ex), 
        .rs2Addr_ex(rs2Addr_ex), 
        .rs1Data_ex(rs1Data_ex), 
        .rs2Data_ex(rs2Data_ex)
    );
    // EX
    EX EX(
        //input
        .ALUCode_ex(ALUCode_ex), 
        .ALUSrcA_ex(ALUSrcA_ex), 
        .ALUSrcB_ex(ALUSrcB_ex),
        .Imm_ex(Imm_ex), 
        .rs1Addr_ex(rs1Addr_ex), 
        .rs2Addr_ex(rs2Addr_ex), 
        .rs1Data_ex(rs1Data_ex), 
        .rs2Data_ex(rs2Data_ex), 
        .PC_ex(PC_ex), 
        .RegWriteData_wb(RegWriteData_wb), 
        .ALUResult_mem(ALUResult_mem),
        .rdAddr_mem(rdAddr_mem), 
        .rdAddr_wb(rdAddr_wb), 
		.RegWrite_mem(RegWrite_mem), 
        .RegWrite_wb(RegWrite_wb), 
        //output
        .ALUResult_ex(ALUResult_ex), 
        .MemWriteData_ex(MemWriteData_ex), 
        .ALU_A(ALU_A), 
        .ALU_B(ALU_B)
    );
    // EX_MEM
    EX_MEM EX_MEM_1(
        //input
        .clk(clk),
        .MemtoReg_ex(MemtoReg_ex), 
        .RegWrite_ex(RegWrite_ex), 
        .MemWrite_ex(MemWrite_ex), 
        .ALUResult_ex(ALUResult_ex), 
        .MemWriteData_ex(MemWriteData_ex), 
        .rdAddr_ex(rdAddr_ex),
        //output
        .MemtoReg_mem(MemtoReg_mem), 
        .RegWrite_mem(RegWrite_mem), 
        .MemWrite_mem(MemWrite_mem), 
        .ALUResult_mem(ALUResult_mem), 
        .MemWriteData_mem(MemWriteData_mem), 
        .rdAddr_mem(rdAddr_mem)
    );
    // DataRAM
    DataRAM DataRAM_1(
        //input
        .a(ALUResult_mem[7:2]),
        .d(MemWriteData_mem),
        .clk(clk),
        .we(MemWrite_mem),
        //output
        .spo(MemDout_mem)
    );
    // MEM_WB
    MEM_WB MEM_WB_1(
        //input
        .clk(clk),
        .MemtoReg_mem(MemtoReg_mem), 
        .RegWrite_mem(RegWrite_mem), 
        .MemDout_mem(MemDout_mem), 
        .ALUResult_mem(ALUResult_mem), 
        .rdAddr_mem(rdAddr_mem),
        //output
        .MemtoReg_wb(MemtoReg_wb), 
        .RegWrite_wb(RegWrite_wb), 
        .MemDout_wb(MemDout_wb), 
        .ALUResult_wb(ALUResult_wb), 
        .rdAddr_wb(rdAddr_wb)
    );
    // WB
    mux_2to1 mux(
        .in0(ALUResult_wb),
        .in1(MemDout_wb),
        .addr(MemtoReg_wb),
        .out(RegWriteData_wb)
    );

endmodule
