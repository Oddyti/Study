module RBWRegisters(
    ReadRegister1,
    ReadRegister2,
    WriteData,    
    WriteRegister,   
    clk,
    RegWrite,     
    ReadData1,
    ReadData2
);
    input clk;
    input[4:0] ReadRegister1, ReadRegister2, WriteRegister; 
    input[31:0] WriteData;
    input RegWrite;
    output[31:0] ReadData1, ReadData2;

    reg [31:0]regs [31:0];//定 32*32 存储器变量
    assign ReadData1= (ReadRegister1 == 5'b0) ? 32'b0 : regs[ReadRegister1];// 口 1 数据读出
    assign ReadData2= (ReadRegister2 == 5'b0) ? 32'b0 : regs[ReadRegister2];// 口 2 数据读出
    always @ (posedge clk) if (RegWrite) regs[WriteRegister] <= WriteData; //数据写入


endmodule