
# 导入numpy和matplotlib库
import numpy as np
from matplotlib import pyplot as plt

# 定义一个类，表示QAM调制器
class Qam:
    def __init__(self, baud_rate, bits_per_baud, carrier_freq, modulation):
        self.baud_rate = baud_rate # 波特率
        self.bits_per_baud = bits_per_baud # 每个符号的比特数
        self.carrier_freq = carrier_freq # 载波频率
        self.modulation = modulation # 调制方式，如16qam

    # 定义一个方法，生成QAM信号
    def generate_signal(self, data):
        # 将二进制数据转换为整数数组
        data_int = np.array([int(x) for x in data])
        
        # 将整数数组分成I和Q两个向量
        dataI = data_int[slice(0, len(data_int), 2)]
        dataQ = data_int[slice(1, len(data_int), 2)]
        
        # 将I和Q向量映射到QAM符号
        symbolsI = self.modulation[dataI]
        symbolsQ = self.modulation[dataQ]
        
        # 计算符号的持续时间和采样率
        symbol_duration = 1 / self.baud_rate # 符号持续时间
        sampling_rate = 1000 * self.carrier_freq # 采样率
        samples_per_symbol = int(symbol_duration * sampling_rate) # 每个符号的采样数
        
        # 生成载波信号
        t = np.arange(0, symbol_duration * len(symbolsI), 1 / sampling_rate) # 时间向量
        carrierI = np.cos(2 * np.pi * self.carrier_freq * t) # I分量的载波信号
        carrierQ = np.sin(2 * np.pi * self.carrier_freq * t) # Q分量的载波信号
        
        # 将符号与载波相乘，得到调制信号
        signalI = np.repeat(symbolsI, samples_per_symbol) * carrierI # I分量的调制信号
        signalQ = np.repeat(symbolsQ, samples_per_symbol) * carrierQ # Q分量的调制信号
        
        # 将I和Q分量相加，得到最终的QAM信号
        signal = signalI + signalQ
        
        return signal
    
    # 定义一个方法，画出星座图
    def plot_constellation(self):
        plt.scatter(self.modulation, np.zeros(len(self.modulation)), marker='o')
        plt.xlabel('In-phase')
        plt.ylabel('Quadrature')
        plt.title('Constellation diagram')
        plt.grid()
        plt.show()

# 定义16qam的幅度和相位数组
modulation_16qam = np.array([1+1j, 1+3j, 3+1j, 3+3j,
                             -1+1j, -1+3j, -3+1j, -3+3j,
                             1-1j, 1-3j, 3-1j, 3-3j,
                             -1-1j, -1-3j, -3-1j, -3-3j])

# 创建一个16qam调制器对象
qam_16qam = Qam(baud_rate=10,
                bits_per_baud=4,
                carrier_freq=9.9e3,
                modulation=modulation_16qam)

# 生成一个随机的二进制序列
data = np.random.choice(['0', '1'], size=100)

# 调用generate_signal方法，得到16qam信号
signal_16qam = qam_16qam.generate_signal(data)

# 画出信号的时域波形图
plt.plot(signal)