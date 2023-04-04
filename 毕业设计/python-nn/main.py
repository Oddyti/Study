import numpy as np
import math
import scipy.io as scio
import matplotlib.pyplot as plt

# 绘图参数设置
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False


class THZ:
    def __init__(self, a):
        self.a = a

    def load_data(self, data_path, data_type):
        # 用以导入所需要的数据类型
        # 变量说明
        # data_path: 数据路径
        # data_type: 需要导入的数据类型
        # 0: mt
        # 1: prbs
        # 2: mix-prbs
        tx_bit_seq = scio.loadmat(data_path)
        tx_bit_seq.keys()

        if data_type == 0:
            data = np.array(tx_bit_seq['tx_bit_mt'])
        elif data_type == 1:
            data = np.array(tx_bit_seq['tx_bit_prbs'])
        elif data_type == 2:
            data = np.array(tx_bit_seq['tx_bit_mix'])

        return data

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
E1t = [E0*np.exp(1j*(2*(pi)*fc1*i*1e-15))for i in range(len(t))]
E2t = [E0*np.exp(1j*(2*(pi)*fc2*i*1e-15))for i in range(len(t))]

# MZM参数设置
V_pi = 3.5  # 半波电压
V_bias = 3.5  # 偏置电压
fd = 2e6  # 驱动电压频率
T_last = 20  # 码元的宽度，每个码元20个采样值

bit_seq = THZ_trans.load_data('data/tx_bit_seq.mat', 0)
[data_I, data_Q] = THZ_trans.qammod(bit_seq[0:20000])

# MZM调制
[E_out_I, I_out_I] = THZ_trans.MZM(
    E1t, data_I, V_pi, V_bias, T_last)  # 调用函数输出MZM的结果
[E_out_Q, I_out_Q] = THZ_trans.MZM(
    E1t, data_Q, V_pi, V_bias, T_last)  # 调用函数输出MZM的结果

# UTC-PD产生太赫兹波
R = 0.5
[E_Thz_I, I_Thz_I] = THZ_trans.UTC_PD(
    E_out_I, I_out_Q, E2t, fc1, fc2, 0, 0, t, R)  # 调用UTC-PD函数
[E_Thz_Q, I_Thz_Q] = THZ_trans.UTC_PD(
    E_out_Q, I_out_Q, E2t, fc1, fc2, 0, 0, t, R)  # 调用UTC-PD函数

# 引入UTC_PD的噪声
Ip = R*pow(E0, 2)*pow(E0, 2)  # 信号产生的平均光电流
q = 1.6e-19  # 电荷常量
h = 6.63e-34  # 普朗克常量
B = 1e9  # 带宽
Kb = 1.38e-23  # 玻尔兹曼常量
T = 300  # 温度23摄氏度
RL = 50  # 负载50欧姆
Fn = 1  # 噪声系数
# 计算出噪声功率
n_s = 2*q*Ip*B  # 量子噪声功率
n_k = 4*Kb*T*Fn*B/RL  # 热噪声功率
SNR = (sum(pow(np.abs(E_Thz_I), 2))/len(E_Thz_I)/(n_s+n_k))  # 信噪比
noise = np.random.randn(len(E_Thz_I))*np.sqrt(n_s+n_k)  # 构造高斯噪声

E_Thz_I_n = E_Thz_I + noise  # 带噪声的信号
E_Thz_Q_n = E_Thz_Q + noise  # 带噪声的信号

# 下变频
fLO = 12e9  # 本振信号频率
phyLO = 0  # 本振信号初相位
ELO = [E0*np.exp(1j*(2*(pi)*fLO*t[i]+phyLO)) for i in range(len(t))]
G = 24  # 倍频
fLO_G = fLO*G  # 倍频后的频率
ELO_G = [E0*np.exp(1j*(2*(pi)*fLO_G*t[i]+phyLO))
         for i in range(len(t))]  # 倍频后的信号
f_IF = abs(fc1-fc2)-fLO_G  # 产生信号的中频
E_mi = [0.00002*E0*np.exp(1j*(2*(pi)*(fLO_G-f_IF)*t[i]+phyLO))
        for i in range(len(t))]  # 镜像信号产生干扰
# 第一次变频后的信号为
EIFt = [((IThz[i]+noise[i])*E0+E0*0.00002*E0)*np.cos(2*math.pi*f_IF*t[i])
        for i in range(len(t))]


# 第二次下变频
E_mi2 = [0.00001*E0*np.exp(1j*(2*(pi)*(f_IF)*t[i]+phyLO))
         for i in range(len(t))]  # 第二次下变频的镜像信号
E_LAST = [(((IThz[i]+noise[i])*E0+E0*0.00002*E0)*E0+E0*E0 *
           0.00001*E0)*np.exp(1j*0) for i in range(len(t))]
E_LAST = np.asarray(E_LAST)
E_LAST = E_LAST.reshape(2, -1)
E_last = np.zeros((2, 50000))
for i in range(50000):
    E_last[0][i] = E_LAST[0][i] * \
        np.cos(phy1t[i]-phy2t[i])+E_LAST[1][i]*np.sin(phy1t[i]-phy2t[i])
    E_last[1][i] = E_LAST[1][i] * \
        np.cos(phy1t[i]-phy2t[i])-E_LAST[0][i]*np.sin(phy1t[i]-phy2t[i])
E_last = E_last.reshape(1, -1)
# 画出最终的基带信号
E_last = E_last

# 考虑到相位的旋转
E_last = E_last.reshape(2, -1)
E_QAM_1 = [E_last[0][20*(i)+10] for i in range(2500)]
E_QAM_2 = [E_last[1][20*(i)+10] for i in range(2500)]
E_QAM_3 = E_LAST[0][0:2500]
E_QAM_4 = E_LAST[1][0:2500]


plt.figure(8)
for j in range(2500):
    a = E_QAM_1[j]*13.5e10
    b = E_QAM_2[j]*13.5e10
    complexSpot = complex(a, b)
    plt.scatter(a, b, c='pink')
plt.title('接收信号星座')
plt.show()
