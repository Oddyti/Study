# 此部分为差频产生Thz载波的UTC_PD模块
import numpy as np
import math

# 先定义一些名字，方便后面调用
cos = math.cos

pi = math.pi

exp = np.exp


def UTC_PD(Ein1, Iin1, Ein2, fc1, fc2, phy1, phy2, t, R):
    # 变量说明：
    # Ein1:输入的第一路波,Ein2输入的第二路波
    # fc1：第一路波频率,fc2：第二路波频率
    # phy1：第一路波相位,phy2：第二路波相位

    Eout = []

    Iout = []  # 没有特殊的含义，只是一个用来保存幅度值的变量

    I = Iin1

    for i in range(len(Ein1)):

        I1 = I[i]

        I2 = abs(Ein2[i])

        Eout.append(
            2*R*I1*I2*np.cos((2*(pi)*abs(fc1-fc2)*t[i]+abs(phy1-phy2))))

        Iout.append(2*R*I1*I2)

    return [Eout, Iout]
