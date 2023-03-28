import numpy as np
import math
'''
MMA多模盲均衡算法

'''


class MMA2():

    # 下面的两个参数是滤波器的抽头个数和迭代的次数
    def __init__(self, N, K):
        self.N = N
        self.K = K

    def mma2(self, u_in, E_0, V_bias, V_pi, landa):

        u_in = np.asarray(u_in)

        u_in = u_in.reshape(2, -1)

        u_r = u_in[0, :]  # 接收信号的同向分量

        u_i = u_in[1, :]  # 接收信号的正交分量

        u_in = u_r+1j*u_i  # 接收到的信号

        # 下面是四个接收信号的幅度
        s1 = pow(E_0, 4)*np.cos(math.pi*((-3+V_bias)/2/V_pi))

        s2 = pow(E_0, 4)*np.cos(math.pi*((-1+V_bias)/2/V_pi))

        s3 = pow(E_0, 4)*np.cos(math.pi*((1+V_bias)/2/V_pi))

        s4 = pow(E_0, 4)*np.cos(math.pi*((3+V_bias)/2/V_pi))

        # Rr和Ri分别对应同相和正交的模值
        Rr = Ri = (pow(s1, 4)+pow(s2, 4)+pow(s3, 4)+pow(s4, 4)) / \
            (pow(s1, 2)+pow(s2, 2)+pow(s3, 2)+pow(s4, 2))

        # landa为权值改变的步长
        landa = 0.05

        # 滤波器的系数，每一列对应每一次迭代
        w = np.vstack([np.ones((1, self.K+1)), np.zeros((self.N-1, self.K+1))])
        u_in = u_in.reshape(1, -1)

        u_n = np.hstack([u_in, np.zeros((1, self.N-1))])

        # 迭代过程如下
        for i in range(self.K):

            U = u_n[0][i:i+self.N]

            y_n = np.sum(w[:, i]*U)  # 滤波器的输出信号

            y_r = np.real(y_n)  # yR

            y_i = np.imag(y_n)  # yI

            conjU = np.conj(U)  # 取复共轭

            delta_J = (y_r*(math.pow(y_r, 2)-math.pow(Rr, 2))+1j *
                       (y_i*(math.pow(y_i, 2)-math.pow(Ri, 2))))*conjU

            w[:, i+1] = w[:, i]-landa*np.conj(U)*delta_J  # 权重更新

        return w[:, self.K].reshape(1, self.N)

    def clu(self, w, u_test):

        u_test = np.asarray(u_test)

        u_test = u_test.reshape(1, -1)

        M = w.shape[1]

        u_t = np.hstack([u_test, np.zeros((1, M))])  # 拓展测试信号，防止下标越界

        y_t = []

        for i in range((u_test.shape[1])):

            y_t.append(np.sum(w*u_t[0][i:M+i]))

        return y_t
