import numpy as np
import math
import matplotlib.pyplot as plt

# 绘图参数设置
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False


class THZ:
    def __init__(self, a):
        self.a = a

    # 定义qam调制函数，输入二进制序列，返回正交两路信号
    def qammod(self, bit_seq):

        # 非偶数则补零
        if len(bit_seq) % 2 != 0:
            bit_seq = np.append(bit_seq, 0)

        bit_seq_I = []
        bit_seq_Q = []

        for i in range(round(bit_seq.size/4)):
            i = 4*i
            if bit_seq[i] == 0 and bit_seq[i+1] == 0:
                bit_seq_I.append(-3)
            if bit_seq[i] == 0 and bit_seq[i+1] == 1:
                bit_seq_I.append(-1)
            if bit_seq[i] == 1 and bit_seq[i+1] == 0:
                bit_seq_I.append(1)
            if bit_seq[i] == 1 and bit_seq[i+1] == 1:
                bit_seq_I.append(3)

            if bit_seq[i+2] == 0 and bit_seq[i+3] == 0:
                bit_seq_Q.append(3)
            if bit_seq[i+2] == 0 and bit_seq[i+3] == 1:
                bit_seq_Q.append(1)
            if bit_seq[i+2] == 1 and bit_seq[i+3] == 0:
                bit_seq_Q.append(-1)
            if bit_seq[i+2] == 1 and bit_seq[i+3] == 1:
                bit_seq_Q.append(-3)

            bit_seq_I = np.array(bit_seq_I)
            bit_seq_Q = np.array(bit_seq_Q)

            return [bit_seq_I, bit_seq_Q]

    # 定义MZM（调制器）函数
    def MZM(self, E_in, V_data, V_pi, V_bias, T):
        pi = math.pi
        s = len(E_in)  # 获取长度
        E_out = []  # 输出信号
        I_out = []  # 输出信号功率

        for i in range(s):
            index = math.ceil((i+1)/T)-1
            E_out.append(E_in[i]*np.cos(pi*((V_data[index]+V_bias)/2/V_pi)))
            I_out.append(
                abs(E_in[i])*np.cos(pi*((V_data[index]+V_bias)/2/V_pi)))

        return [E_out, I_out]

    def UTC_PD(self, E_in1, I_in1, E_in2, fc1, fc2, phy1, phy2, t, R):
        # 变量说明：
        # E_in1: 输入的第一路波
        # E_in2: 输入的第二路波
        # fc1: 第一路波频率
        # fc2: 第二路波频率
        # phy1: 第一路波相位
        # phy2: 第二路波相位

        Eout = []
        Iout = []

        for i in range(len(E_in1)):
            I1 = I_in1[i]
            I2 = abs(E_in2[i])
            Eout.append(
                2*R*I1*I2*np.cos((2*(pi)*abs(fc1-fc2)*t[i]+abs(phy1-phy2))))
            Iout.append(2*R*I1*I2)

        return [Eout, Iout]


THZ_trans = THZ(a=1)

pi = math.pi  # 常数pi
nanda1 = 1550.18e-9  # 激光器1波长
nanda2 = 1547.38e-9  # 激光器2波长
c = 3e8  # 光速
fc1 = c/nanda1  # 激光器1光载频
fc2 = c/nanda2  # 激光器2光载频
delta_v1 = 1e6  # 激光器线宽
delta_v2 = 1.5e6  # 激光器线宽2
t = np.arange(100000)*1e-14  # 构造时间序列
fs = abs(fc1-fc2)  # 两个激光器差频即太赫兹载波频率
E0 = 0.002  # 两个激光器输出的连续光的幅度
P0 = math.pow(E0, 2)/2  # 激光器的输出光功率
phy1t = [0]  # 激光器1相位
phy2t = [0]  # 激光器2相位
for i in range(len(t)-1):
    phy1t.append(phy1t[i])
    phy2t.append(phy2t[i])
    # phy1t.append(phy1t[i]+random.gauss(0,math.sqrt(delta_v1*5e-12)))
    # phy2t.append(phy2t[i]+random.gauss(0,math.sqrt(delta_v2*5e-12)))
E1t = [E0*np.exp(1j*(2*(pi)*fc1*i*1e-15))
       for i in range(len(t))]  # 激光器1的输出连续光波
E2t = [E0*np.exp(1j*(2*(pi)*fc1*i*1e-15))
       for i in range(len(t))]  # 激光器2的输出连续光波

# MZM参数设置
Vpi = 3.5  # 半波电压
Vbias = 3.5  # 偏置电压
fd = 2e6  # 驱动电压频率
T_last = 20  # 码元的宽度，每个码元20个采样值
V_or = np.ceil(np.random.rand(2, 5000)-0.5)  # 这里产生随机0，1信号
V_tr = V_or.reshape(1, 10000)

'''
系统采用16QAM调制的方法,于是要将信号的两个比特编码成四个电平，并且每个码元有两个电平(包含同向的和正交的)
'''
# 编码成-3，-1，1，3电平
length = V_or.shape[1]

V_data = []

for i in range(length):

    if V_or[0][i]*2+V_or[1][i] == 0:
        V_data.append(-3)
    if V_or[0][i]*2+V_or[1][i] == 1:
        V_data.append(-1)
    if V_or[0][i]*2+V_or[1][i] == 2:
        V_data.append(1)
    if V_or[0][i]*2+V_or[1][i] == 3:
        V_data.append(3)

V_data = np.asarray(V_data)

[Eout, Iout] = THZ_trans.MZM(E1t, V_data, Vpi, Vbias, T_last)  # 调用函数输出MZM的结果

R = 0.5  # UTC_PD的响应度(单独放在这里好丑陋)
[EThz, IThz] = THZ_trans.UTC_PD(
    Eout, Iout, E2t, fc1, fc2, 0, 0, t, R)  # 调用UTC-PD函数
